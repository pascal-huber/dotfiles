#!/usr/bin/env bash
#
# This script is vibe-coded, yolo.
#
# archivarr.sh — sync a source tree into a destination tree with rsync,
# then strip the SOURCE down to empty directories (files removed,
# directory structure preserved). Deletion only happens after the full
# sync has completed and been verified.
#
# Usage:
#   ./archivarr.sh <source_dir> <dest_base_dir>
#
# Example:
#   ./archivarr.sh /arrarr/tv/x /mnt/tv
#     -> copies /arrarr/tv/x/*  into  /mnt/tv/x/...
#     -> on success, deletes files under /arrarr/tv/x (dirs stay)

set -euo pipefail

usage() {
  echo "Usage: $0 <source_dir> <dest_base_dir>" >&2
  echo "Example: $0 /arrarr/tv/x /mnt/tv" >&2
  exit 1
}

[[ $# -eq 2 ]] || usage

SRC=${1%/}
DEST_BASE=${2%/}

[[ -d "$SRC" ]] || {
  echo "Error: source '$SRC' does not exist" >&2
  exit 1
}
[[ -d "$DEST_BASE" ]] || {
  echo "Error: destination base '$DEST_BASE' does not exist" >&2
  exit 1
}

NAME=$(basename "$SRC")
DEST="$DEST_BASE/$NAME"
mkdir -p "$DEST"

# prevent two runs against the same source from racing each other
LOCK="/tmp/archivarr.$(echo -n "$SRC" | md5sum | cut -d' ' -f1).lock"
exec 9>"$LOCK"
flock -n 9 || {
  echo "Error: another archivarr.sh is already syncing '$SRC'" >&2
  exit 1
}

log() { echo "[$(date '+%F %T')] $*"; }

IONICE=()
command -v ionice >/dev/null 2>&1 && IONICE=(ionice -c2 -n7)

log "Syncing '$SRC/' -> '$DEST/'"
"${IONICE[@]}" rsync -aH --info=progress2 --partial-dir=.rsync-partial "$SRC/" "$DEST/"
log "Copy finished."

log "Verifying copy (checksum dry-run)..."
DIFF=$(rsync -ani --checksum "$SRC/" "$DEST/")
if [[ -n "$DIFF" ]]; then
  echo "Verification failed — source left untouched. Differences:" >&2
  echo "$DIFF" >&2
  exit 1
fi
log "Verification OK."

log "Removing files from source (directories preserved)..."
find "$SRC" -mindepth 1 \( -type f -o -type l \) -print -delete

log "Done. '$SRC' now contains only its directory structure."

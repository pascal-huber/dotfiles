#!/usr/bin/env python3
"""
Dialogue/center gain slider for the PipeWire 7.1/5.1 -> stereo
downmix filter-chain.

Drag the slider and it live-updates "Gain 2" on both the mix_l and
mix_r builtin mixer nodes inside the filter-chain graph, using
pw-cli.  No restart of PipeWire or the filter-chain is needed.

Requirements:
    - pipewire / pw-cli installed and on PATH
    - python3-tk (Tkinter)      e.g. sudo apt install python3-tk
    - your filter-chain's capture node.name (see NODE_NAME below)

Usage:
    python3 dialogue_slider.py
    python3 dialogue_slider.py --node-name center_adjustable_downmix_7_1
"""

import argparse
import json
import subprocess
import sys
import tkinter as tk
from tkinter import ttk

import re
from pathlib import Path

MIXER_NAMES = ("mix_l", "mix_r")   # node names inside the filter.graph
CONTROL = "Gain 2"                 # the center/dialogue control
GAIN_MIN, GAIN_MAX, GAIN_DEFAULT = 0.0, 1.3, 0.707
PRESETS = (("Off", 0.0), ("Low", 0.5), ("Default", 0.707), ("Loud", 1.0))
OTHER_GAINS = (
    (1, "Front L/R"),
    (3, "LFE"),
    (4, "Rear L/R"),
    (5, "Side L/R"),
)

CONFIG_PATH = Path.home() / ".config" / "dialogue_slider.json"


def load_saved_gain():
    """Last value we wrote, used as a fallback if the live node isn't queryable."""
    try:
        return float(json.loads(CONFIG_PATH.read_text())["gain"])
    except (FileNotFoundError, KeyError, ValueError, json.JSONDecodeError):
        return None


def save_gain(value: float) -> None:
    try:
        CONFIG_PATH.parent.mkdir(parents=True, exist_ok=True)
        CONFIG_PATH.write_text(json.dumps({"gain": value}))
    except OSError as e:
        print(f"Could not save gain to {CONFIG_PATH}: {e}", file=sys.stderr)


def get_live_gain(node_id: int):
    """Read the *actual* current value straight from the running filter-chain node."""
    out = get_props_output(node_id)
    if out is None:
        return None
    m = re.search(rf'"{MIXER_NAMES[0]}:{CONTROL}"\s+Float\s+([0-9.eE+-]+)', out)
    return float(m.group(1)) if m else None


def get_props_output(node_id: int):
    try:
        return subprocess.check_output(["pw-cli", "enum-params", str(node_id), "Props"],
                                        text=True)
    except (FileNotFoundError, subprocess.CalledProcessError):
        return None


def get_all_gains(node_id: int):
    """Read every 'Gain N' control for both mixers. Returns {(mixer, n): value}."""
    out = get_props_output(node_id)
    result = {}
    if out is None:
        return result
    for mixer in MIXER_NAMES:
        for n in range(1, 6):
            m = re.search(rf'"{mixer}:Gain {n}"\s+Float\s+([0-9.eE+-]+)', out)
            if m:
                result[(mixer, n)] = float(m.group(1))
    return result


def find_node_id(node_name: str) -> int:
    """Look up the live PipeWire node id for the given node.name via pw-dump."""
    try:
        raw = subprocess.check_output(["pw-dump"], text=True)
    except FileNotFoundError:
        sys.exit("pw-dump not found - is PipeWire installed and on PATH?")
    except subprocess.CalledProcessError as e:
        sys.exit(f"pw-dump failed: {e}")

    data = json.loads(raw)
    for obj in data:
        if obj.get("type") != "PipeWire:Interface:Node":
            continue
        props = obj.get("info", {}).get("props", {})
        if props.get("node.name") == node_name:
            return obj["id"]
    sys.exit(f"Could not find a running node named '{node_name}'. "
              f"Is the filter-chain loaded?")


def set_gain(node_id: int, value: float) -> None:
    params = []
    for m in MIXER_NAMES:
        params.append(f"{m}:{CONTROL}")
        params.append(f"{value:.4f}")
    param_str = " ".join(f'"{p}"' if not p.replace(".", "", 1).replace("-", "", 1).isdigit() else p
                          for p in params)
    cmd_json = '{ params = [ ' + param_str + ' ] }'
    try:
        subprocess.run(["pw-cli", "s", str(node_id), "Props", cmd_json],
                        check=True, capture_output=True, text=True)
    except subprocess.CalledProcessError as e:
        print(f"pw-cli error: {e.stderr}", file=sys.stderr)


def gain_to_db(g: float) -> float:
    import math
    return 20 * math.log10(g) if g > 0 else float("-inf")


class SliderApp:
    def __init__(self, node_name: str):
        self.node_name = node_name
        self.node_id = find_node_id(node_name)

        self.root = tk.Tk()
        self.root.title("Dialogue / Center Level")
        self.root.geometry("360x340")

        ttk.Label(self.root, text="Dialogue boost (Front Center gain)",
                  font=("sans-serif", 11)).pack(pady=(14, 2))

        self.value_label = ttk.Label(self.root, text="", font=("sans-serif", 10))
        self.value_label.pack()

        initial = get_live_gain(self.node_id)
        source = "live"
        if initial is None:
            initial = load_saved_gain()
            source = "saved"
        if initial is None:
            initial = GAIN_DEFAULT
            source = "default"
        print(f"Starting at gain {initial:.3f} (from {source})")

        self.var = tk.DoubleVar(value=initial)
        self.slider = ttk.Scale(self.root, from_=GAIN_MIN, to=GAIN_MAX,
                                 orient="horizontal", variable=self.var,
                                 length=320, command=self.on_change)
        self.slider.pack(pady=10)

        btn_frame = ttk.Frame(self.root)
        btn_frame.pack(pady=(4, 10))
        for label, val in PRESETS:
            ttk.Button(btn_frame, text=f"{label}\n{val:.3f}",
                       command=lambda v=val: self.set_preset(v)).pack(
                side="left", padx=6)

        ttk.Separator(self.root, orient="horizontal").pack(fill="x", pady=(4, 8), padx=10)

        ttk.Label(self.root, text="Other channel gains (read-only)",
                  font=("sans-serif", 9, "italic")).pack()

        other_frame = ttk.Frame(self.root)
        other_frame.pack(pady=(4, 10))
        self.other_labels = {}
        for row, (n, desc) in enumerate(OTHER_GAINS):
            ttk.Label(other_frame, text=f"Gain {n} ({desc}):",
                      font=("sans-serif", 9)).grid(row=row, column=0, sticky="w", padx=4)
            lbl = ttk.Label(other_frame, text="--", font=("sans-serif", 9))
            lbl.grid(row=row, column=1, sticky="w", padx=4)
            self.other_labels[n] = lbl

        self.on_change()
        self.refresh_other_gains()

    def refresh_other_gains(self):
        gains = get_all_gains(self.node_id)
        for n, _desc in OTHER_GAINS:
            l = gains.get(("mix_l", n))
            r = gains.get(("mix_r", n))
            if l is None and r is None:
                text = "unavailable"
            elif l == r:
                text = f"{l:.3f}"
            else:
                text = f"L={l:.3f}  R={r:.3f}"
            self.other_labels[n].config(text=text)
        self.root.after(2000, self.refresh_other_gains)

    def on_change(self, _evt=None):
        g = self.var.get()
        set_gain(self.node_id, g)
        save_gain(g)
        db = gain_to_db(g)
        db_str = "-inf" if g == 0 else f"{db:+.1f} dB"
        self.value_label.config(text=f"Gain = {g:.3f}   ({db_str})")

    def set_preset(self, value):
        self.var.set(value)
        self.on_change()

    def run(self):
        self.root.mainloop()


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--node-name", default="center_adjustable_downmix_7_1",
                         help="capture.props.node.name of your filter-chain "
                              "(default: center_adjustable_downmix_7_1)")
    args = parser.parse_args()

    app = SliderApp(args.node_name)
    app.run()

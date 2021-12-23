#! /usr/bin/env python2
#import gkeyring as gk
import subprocess

# Store as follows
# $ secret-tool store --label="offlineimap_email" user "email" domain mail

def get_keyring_pw(user):
    cmd = ["secret-tool", "lookup", "user", user, "domain", "mail"]
    return subprocess.Popen(cmd, stdout=subprocess.PIPE).communicate()[0]

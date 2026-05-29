# B4-01 PoC: .bashrc canary
# This tests whether Cloud Shell sources .bashrc from the cloned repo directory
# (it should NOT — bash sources $HOME/.bashrc, not $PWD/.bashrc)
#
# ETHICAL BOUNDS: Only writes a local canary file. No exfiltration.

echo "B4-01-BASHRC-CANARY: .bashrc from repo executed at $(date -u +%Y-%m-%dT%H:%M:%SZ)" > /tmp/b4-01-bashrc-canary.txt
echo "B4-01-BASHRC-CANARY: USER=$USER HOME=$HOME PWD=$PWD" >> /tmp/b4-01-bashrc-canary.txt

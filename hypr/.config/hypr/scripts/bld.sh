
#!/usr/bin/bash

name="OPPO Enco Air4 Pro"
mac_addr="60:55:56:13:B5:92"

# fire up bluetooth utility.
bluetoothctl << EOF
disconnect $mac_addr
EOF

notify-send "disconnecting $name..."


echo shutdown >>/tmp/hyprshutdown.log
date >>/tmp/hyprshutdown.log

echo hyprshutdown >>/tmp/hyprshutdown.log
hyprshutdown -t 'Shutting down...' --post-cmd 'systemctl poweroff >> /tmp/hyprshutdown.log 2>&1'
echo finished >>/tmp/hyprshutdown.log

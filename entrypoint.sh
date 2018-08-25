# startup appium server
appium -g /root/appium.log &

# startup X server
Xvfb :0 -screen 0 1920x1080x24 &

# startup VNC server for the X server with empty password
x11vnc -forever -shared -display :0 -passwd "" &

# startup openbox windows manager
openbox &
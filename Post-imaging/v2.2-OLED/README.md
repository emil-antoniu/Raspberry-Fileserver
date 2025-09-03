### PIN Connections

<ul>
<li>GND - GND (9)</li>
<li>VCC - 3.3V (1)</li>
<li>SCL - SCL (5)</li>
<li>SDA - SDA (3)</li>
</ul>

### I2C Configuration

Enable I2C on the Pi:
```
sudo raspi-config nonint do_i2c 0
```
Check that the Pi sees the display:
```
sudo apt install -y i2c-tools
i2cdetect -y 1
```
A hex address like 0x3C should appear.

### OLED Script

Install Adafruit libraries.
```
sudo apt install -y python3-pip
pip3 install adafruit-circuitpython-ssd1306 --break-system-packages
pip3 install pillow --break-system-packages
```
OLED script.
```python
import board
import busio
import subprocess
import time
from adafruit_ssd1306 import SSD1306_I2C
from PIL import Image, ImageDraw, ImageFont

def is_vpn_connected():

        verdict = subprocess.run(
                ["expressvpn", "status"], capture_output=True, text=True
        )

        if "connected to" in verdict.stdout.lower(): return True

        return False

def can_reach_internet(host="8.8.8.8"):

        try:
                verdict = subprocess.run(
                        ["ping", "-c", "1", "-W", "2", host], capture_output=True, text=True
                )

                return verdict.returncode == 0

        except any_exception: return False

def is_p2p_running(service="qbittorrent-nox.service"):

        try:
                verdict = subprocess.run(
                        ["systemctl", "is-active", service], capture_output=True, text=True
                )

                return verdict.stdout.strip() == "active"

        except any_exception: return False


def fileserver_uptime(): pass

# Setup I2C
i2c = busio.I2C(board.SCL, board.SDA)

# Create the OLED class
oled = SSD1306_I2C(128, 64, i2c)  # adjust if you have a 128x32 display

# Load default font
font = ImageFont.load_default()

while True:

        # Create a blank image for drawing
        image = Image.new("1", (oled.width, oled.height))
        draw = ImageDraw.Draw(image)

        # Draw text
        if can_reach_internet() == True:
                draw.text((0, 0), "WAN.............................OK", font=font, fill=255)
        else:
                draw.text((0, 0), "WAN........................ERROR", font=font, fill=255)

        if is_vpn_connected() == True:
                draw.text((0, 0), "\nVPN..............................OK", font=font, fill=255)
        else:
                draw.text((0, 0), "\nVPN........................ERROR", font=font, fill=255)

        if is_p2p_running() == True:
                draw.text((0, 0), "\n\nP2P..............................OK", font=font, fill=255)
        else:
                draw.text((0, 0), "\n\nP2P........................ERROR", font=font, fill=255)

        draw.text((0, 0), "\n\n\n4", font=font, fill=255)

        # Display image
        oled.image(image)
        oled.show()

        time.sleep(60)
```

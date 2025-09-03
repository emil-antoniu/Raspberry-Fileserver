### PIN Connections

GND - GND (9)
VCC - 3.3V (1)
SCL - SCL (5)
SDA - SDA (3)

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
```
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
        if is_vpn_connected() == True:
                draw.text((0, 0), "VPN.............................OK", font=font, fill=255)
        else:
                draw.text((0, 0), "VPN........................ERROR", font=font, fill=255)

        # Display image
        oled.image(image)
        oled.show()

        time.sleep(5)
```

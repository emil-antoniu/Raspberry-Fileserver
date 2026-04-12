#!/usr/bin/env python3
import board
import busio
import subprocess
import time
from adafruit_ssd1306 import SSD1306_I2C
from PIL import Image, ImageDraw, ImageFont

def vpn_status():

        status = subprocess.run(
                ["expressvpnctl", "status"], capture_output=True, text=True
        )

        return status.stdout.split()[0].lower()

def can_reach_internet(host="8.8.8.8"):

        try:
                verdict = subprocess.run(
                        ["ping", "-c", "1", "-W", "2", host], capture_output=True, text=True
                )

                return verdict.returncode == 0

        except Exception: return False

def check_lan_ip():

        try:
                ifconfig = subprocess.Popen(
                        ["ifconfig", "wlan0"], stdout=subprocess.PIPE, text=True
                )

                grep = subprocess.run(
                        ["grep", "192"], stdin=ifconfig.stdout, capture_output=True, text=True
                )
                return "." + grep.stdout.strip().split(" ")[1].split(".")[-1]

        except Exception: return "bad"

def ufw_status():

        status = subprocess.run(
                ["sudo", "ufw", "status"], capture_output=True, text=True
        )

        return status.stdout.splitlines()[0].split(" ")[-1]


def fileserver_uptime():

        uptime = subprocess.run(
                ["uptime", "-p"], capture_output=True, text=True
        )

        return uptime.stdout.strip()

# Setup I2C
i2c = busio.I2C(board.SCL, board.SDA)

# Create the OLED class
oled = SSD1306_I2C(128, 64, i2c)

# Load default font
font = ImageFont.load_default()

while True:

        # Create a blank image for drawing
        image = Image.new("1", (oled.width, oled.height))
        draw = ImageDraw.Draw(image)

        # Draw text
        draw.text((0, 0), "WAN: {0} | LAN: {1}".format("ok" if can_reach_internet() == True else "uh oh", check_lan_ip()), font=font, fill=255)

        draw.text((0, 0), "\nVPN: {0}".format(vpn_status()), font=font, fill=255)

        draw.text((0, 0), "\n\nUFW: {0}".format(ufw_status()), font=font, fill=255)

        draw.text((0, 0), "\n\n\n{0}".format(fileserver_uptime()), font=font, fill=255)

        # Display image
        oled.image(image)
        oled.show()

        time.sleep(60)

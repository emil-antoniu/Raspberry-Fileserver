# PIN Connections

<ul>
<li>GND - GND (9)</li>
<li>VCC - 3.3V (1)</li>
<li>SCL - SCL (5)</li>
<li>SDA - SDA (3)</li>
</ul>

# Installation

Install Adafruit libraries.
```
sudo apt install -y python3-pip
pip3 install adafruit-circuitpython-ssd1306 --break-system-packages
pip3 install pillow --break-system-packages
```

# I2C Configuration

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

# System Service

A system service can be created as follows:
```
sudo nano /etc/systemd/system/oled-status.service
```
With the contents:
```
[Unit]
Description=OLED Status Display
After=network.target

[Service]
ExecStart=/usr/bin/python3 /home/system-administrator/oled.py
WorkingDirectory=/home/system-administrator
StandardOutput=journal
StandardError=journal
Restart=always
User=system-administrator

[Install]
WantedBy=multi-user.target
```
Reload systemd and enable the service.
```
sudo systemctl daemon-reload
sudo systemctl enable oled-status.service
sudo systemctl start oled-status.service
systemctl status oled-status.service
```

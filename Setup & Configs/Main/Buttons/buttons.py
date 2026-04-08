import RPi.GPIO as GPIO
import subprocess
import time

BUTTON_PIN = 22 # GPIO 25

GPIO.setmode(GPIO.BCM)
GPIO.setup(BUTTON_PIN, GPIO.IN, pull_up_down=GPIO.PUD_UP)

def toggle_ufw():
    status = subprocess.run(
        ["sudo", "ufw", "status"],
        capture_output=True, text=True
    ).stdout.lower()

    if "inactive" in status:
        subprocess.run(["sudo", "ufw", "enable"])
        print("UFW ENABLED")
    else:
        subprocess.run(["sudo", "ufw", "disable"])
        print("UFW DISABLED")

try:
    while True:
        if GPIO.input(BUTTON_PIN) == GPIO.LOW:  # button pressed
            toggle_ufw()
            time.sleep(1)
        time.sleep(0.1)

except KeyboardInterrupt:
    GPIO.cleanup()
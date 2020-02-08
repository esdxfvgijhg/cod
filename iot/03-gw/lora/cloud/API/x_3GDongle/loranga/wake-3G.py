import RPi.GPIO as GPIO
import time

GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)

GPIO.setup(13, GPIO.OUT)

GPIO.setup(6, GPIO.IN)
status = GPIO.input(6)

if status == GPIO.LOW:
    print "Loranga3G is already ON"
else:
    print "Turn on Loranga3G "
    GPIO.output(13, GPIO.HIGH)
    time.sleep(2)
    GPIO.output(13, GPIO.LOW)

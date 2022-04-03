# autobright
Homemade automatic screen brightness adjustment for notebooks with webcam

It uses notebook's webcam to take a picture, and then measures the resulting image's white pixels intensity. This can be correlated with ambient luminosity to adjust notebook's screen brightness and also toogle on/off keyboard's led. 

If you wish, you can start a service for adjusting brightness upon resume from suspend (check the .service file which comes with the repo).

Last but not least, you can crontab this script to periodically adjust your screen brightness as well. 

# Dependencies

sudo apt install brightnessctl ruby fswebcam

sudo gem install mini_magick

# Instalation

First you need to discover your *devices*. For doing that cast **brightnessctl -l**. For example, mine are

-----

Available devices:

Device 'intel_backlight' of class 'backlight':
	Current brightness: 27600 (23%)
	Max brightness: 120000

Device 'phy0-led' of class 'leds':
	Current brightness: 1 (100%)
	Max brightness: 1

Device 'input3::numlock' of class 'leds':
	Current brightness: 0 (0%)
	Max brightness: 1

Device 'input3::capslock' of class 'leds':
	Current brightness: 0 (0%)
	Max brightness: 1

Device 'input3::scrolllock' of class 'leds':
	Current brightness: 0 (0%)
	Max brightness: 1

Device 'dell::kbd_backlight' of class 'leds':
	Current brightness: 1 (50%)
	Max brightness: 2

Device 'platform::micmute' of class 'leds':
	Current brightness: 0 (0%)
	Max brightness: 1
  
  -----

where my screen backlight is 'intel_backlight' and keyboard is 'dell::kbd_backlight'. Once you have discovered both devices, put them into *autobright.rb*. If keyboard backlight is not present, just comment the corresponding line in *autobright.rb*.

You may now clone the repo, and make autobright executable (chmod +x autobright.rb). Just run it as **./autobright.rb**.

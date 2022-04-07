#!/bin/ruby
require 'mini_magick'
#==========================================
log_file='/home/oliveira/.autobright.log'
snapshot_file='/home/oliveira/.selfie_autobright.jpg'
#==========================================
class MEASURE
  def initialize(file)
#------------IMPORT RAW IMAGE-------------
    image = MiniMagick::Image.open(file)
    pixels = image.get_pixels
#--TAKE A SNAPSHOT AND AVERAGE BRIGHTNESS---
    count = 0
    white = 0
    ci = image.width/3
    cf = 2*image.width/3
    image.height.times do |l|
      ci.upto cf do |c|
        red     = pixels[l][c][0]
        green   = pixels[l][c][1]
        blue    = pixels[l][c][2]
        white   = white + (red + green + blue)
        count+=1
      end
    end
    white = (white/765).to_f/count
#---------------SOME METHODS-------------
      @white = white
      def self.white
        @white
      end
#----------------------------------------
  end
end
#=========================================
keyboard=0
#==TAKE A SELFIE==========
`fswebcam #{snapshot_file}`
#=========================
snap = MEASURE.new(snapshot_file)
webcam = (snap.white*100).round
#====DAY AND NIGHT TUNINGS==
f = 0.6
x1 = 85
x2 = 95
#--------------
y1 = f*x1
a = (100-y1)/(x2-x1)
b = y1 - a*x1
h = Time.now.hour
#-------------
if h > 18 or h < 5
  `gsettings set org.cinnamon.desktop.interface gtk-theme Mint-Y-Dark` #AUTOMATIC DARK MODE FOR CINNAMON DE AT NIGHT
  screen = (0.75*webcam).round(1)
else
  `gsettings set org.cinnamon.desktop.interface gtk-theme Mint-Y`#BACK TO LIGHT THEME DURING DAYLIGHT (CINNAMON DE ONLY)
 if webcam > x2
   screen = 100
 elsif webcam > x1 and webcam <= x2
   screen=(webcam*a+b).round(1)
 else
  screen = (f*webcam).round(1)
 end
end
if webcam == 0 then screen = 1 end
if webcam < 10 then keyboard = 50 end
#==========================
`sudo brightnessctl -d 'intel_backlight' set #{screen}%`
`sudo brightnessctl -d 'dell::kbd_backlight' set #{keyboard}%` # IF YOUR KEYBOAD IS NOT RETROILLUMINATED, JUST COMMENT THIS LINE.
#==========================
puts output = "Measured: #{webcam}\nAdjusted: #{screen}\n" 
File.write(log_file,output,mode:'w')
#==========================


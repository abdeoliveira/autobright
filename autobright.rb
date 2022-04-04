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
    image.height.times do |l|
      image.width.times do |c|
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
#====IS IT DAY OR NIGHT?==
h = Time.now.hour
if h > 18 or h < 5 
  b = 30
else
  b = 5
end
#==TAKE A SELFIE==========
`fswebcam --set 'Backlight Compensation'=1 --set Brightness=#{b}% #{snapshot_file}`
snap = MEASURE.new(snapshot_file)
webcam = (snap.white*100).round
#======SOME TUNINGS=======
screen = webcam
if webcam == 0 then screen = 1 end
if webcam < 10 then keyboard = 50 end
#==========================
`sudo brightnessctl -d 'intel_backlight' set #{screen}%`
`sudo brightnessctl -d 'dell::kbd_backlight' set #{keyboard}%` # IF YOUR KEYBOAD IS NOT RETROILLUMINATED, JUST COMMENT THIS LINE.
#==========================
puts output = "Measured: #{webcam}\nAdjusted: #{screen}\nWebcam: #{b}\n" 
File.write(log_file,output,mode:'w')
#==========================


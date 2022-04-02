#!/bin/ruby
path=`pwd`.delete"\n"
require "#{path}/measure"

#=========================
keyboard=0
1.times do |i|
  `#{path}/selfie.sh #{i} #{path}`
  #sleep(1)
end
avew = 0
selfies = Dir["#{path}/tmp*"]
num_images = selfies.length
selfies.each.with_index do |file,m|
  snap = MEASURE.new(file)
  white = snap.white
  avew = avew + white/num_images
end
webcam = (avew*100).round
#======SOME TUNINGS=======
screen = (webcam*0.7).round
if webcam > 20  and webcam <= 30 then screen = webcam end
if webcam <=20 then screen = (webcam*1.3).round end
#--------------------------
if webcam <= 10 then keyboard=50 end
#==========================
puts "Measured: #{webcam}"
puts "Adjusted: #{screen}"
`#{path}/adjust.sh #{screen} #{keyboard}`
`rm #{path}/tmp_*`
#==========================

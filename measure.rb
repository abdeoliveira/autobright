require 'mini_magick'
class MEASURE
  def initialize(file)
#=========IMPORT RAW IMAGE======================  
    image = MiniMagick::Image.open(file)
    pixels = image.get_pixels
    index = file.scan(/\d+/).first #retrieve file number, e.g. 'Scan 0.png' => 0
    format = file.split('.')[2] #retrieve file format, e.g. 'Scan 0.png' => png
#=========TAKE A SNAPSHOT AND AVERAGE BRIGHTNESS =====
    count = 0
    white = 0
    ci = image.width/3
    cf = 2*image.width/3
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
#==============================================
      @white = white
      def self.white
        @white
      end
#==============================================
  end
end

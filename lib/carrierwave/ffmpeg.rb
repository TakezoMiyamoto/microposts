require 'streamio-ffmpeg'
module CarrierWave
  module FFMPEG
    module ClassMethods
      def screenshot
        process :screenshot
      end
    end
 
    def screenshot
      directory = File.dirname( current_path )
      tmpfile   = File.join( directory, "tmpfile" )
 
      File.rename( current_path, tmpfile )
 
      file = ::FFMPEG::Movie.new(tmpfile)
      file.screenshot( current_path + ".jpg", seek_time: 5)
      File.rename(current_path + ".jpg", current_path)
 
      File.delete(tmpfile)
    end
  end
end
require 'pry'

class MusicImporter

    attr_accessor :path

    def initialize(path)
        @path = path
    end

   def files
    #binding.pry
        Dir.entries(self.path).map do |file|
            file.include? ".mp3"
        end
        
   end


end
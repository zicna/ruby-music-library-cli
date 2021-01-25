require 'pry'

class MusicImporter

    attr_accessor :path

    def initialize(path)
        @path = path
    end

   def files
    # binding.pry
    #     Dir.entries(self.path)#map do |file|
        #     binding
        #     file.include? ".mp3"
        # end
        def files
            @files ||= Dir.glob("#{path}/*.mp3").collect{ |f| f.gsub("#{path}/", "") }
          end
   end

    def import
        files.each do |file|
            Song.create_from_filename(file)
        end
        #Song.create_from_filename(files)
        
    end
    


end
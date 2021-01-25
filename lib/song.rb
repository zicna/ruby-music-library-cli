require 'pry'

class Song
    #belongs to an artist
    #belong to genre

    @@all =[]

    attr_accessor :name, :artist, :genre
    #attr_reader :artist

    def initialize(name, artist= nil, genre = nil)
        @name = name
        self.artist = artist if artist
        self.genre = genre if genre
        #@genre = genre
         
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def save
        @@all << self
    end

    def self.create(name)
        song = Song.new(name)
        song.save
        song
    end

    #Associations methods
    def artist=artist
        @artist = artist
        
        artist.add_song(self) unless artist.songs.include?(self)
    end

    def genre=genre
        @genre = genre

        genre.songs << self unless genre.songs.include?(self)

    end

    #Finding methods
    def self.find_by_name(name)
        @@all.detect{|song| song.name == name}
    end

    def self.find_or_create_by_name(name)
        if self.find_by_name(name) == nil
            self.create(name)
        else 
            self.find_by_name(name)
        end
    end

    def self.new_from_filename(filename)
        # binding.pry
       info = filename.split(" - ")
        name = info[1]
    #    artist = info[0]
    #    genre = info[2].gsub(".mp3", "")
       #song = Song.new(name, artist, genre)
       #binding.pry

       genre = Genre.find_or_create_by_name(info[2].gsub(".mp3", ""))
       artist = Artist.find_or_create_by_name(info[0])

       song = Song.new(name, artist, genre)
    end

    def self.create_from_filename(filename)
        @@all << self.new_from_filename(filename)
    end

    
end
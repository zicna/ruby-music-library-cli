class Artist
    extend Concerns::Findable
    #has many songs
    attr_accessor :name

    @@all = []

    def initialize(name)
        @name = name
        @songs = []
        #@genres = []
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
        artist = Artist.new(name)
        artist.save
        artist
    end

    #associations methods

    def songs
        @songs
    end

    def add_song(song)
        #song = Song.new(name)
        song.artist = self if song.artist != self
        @songs << song unless @songs.include?(song)
    end

    def genres
         @genres = []
        @songs.each do |song|
            @genres << song.genre
        end
        @genres.uniq
    end


end
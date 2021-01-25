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

    
end
require 'pry'

class MusicLibraryController


    def initialize(path="./db/mp3s")
        @path = path
        MusicImporter.new(path).import
        #MusicImporter.import
    end

    def call
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"

        input = gets

        until input == "exit" do
            input = gets
        end

    end

    def list_songs
        #binding.pry
        count = 1
        Song.all.sort_by{|obj| obj.name}.each do |song|
            puts "#{count}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
            count += 1
        end
    end

    def list_artists
        count = 1
        binding.pry
        Song.all.sort_by{|obj| obj.artist.name}.each do |song|
            #binding.pry
            puts "#{count}. #{song.artist.name}"
            count += 1
        end
    end


end
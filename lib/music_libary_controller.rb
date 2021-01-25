require 'pry'

class MusicLibraryController


    def initialize(path="./db/mp3s")
        @path = path
        MusicImporter.new(path).import
        #MusicImporter.import
    end

    def call
        input = ''
        until input == "exit"

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

        #until input == "exit" do
        case input
        when "list songs"
          list_songs
        when "list artists"
          list_artists
        when "list genres"
          list_genres
        when "list artist"
          list_songs_by_artist
        when "list genre"
          list_songs_by_genre
        when "play song"
          play_song
        end
            #input = gets
        end

    end

    def list_songs
        count = 1
        Song.all.sort_by{|obj| obj.name}.each do |song|
            puts "#{count}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
            count += 1
        end
    end

    def list_artists
        count = 1
        Artist.all.sort_by{|obj| obj.name}.each do |song|
            puts "#{count}. #{song.name}"
            count += 1
        end
    end

    def list_genres
        count = 1
        Genre.all.sort_by{|obj| obj.name}.each do |gen|
            puts "#{count}. #{gen.name}"
            count += 1
        end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.strip
        
        if artist = Artist.find_by_name(input)
            #binding.pry
            count = 1
            ordered_list = artist.songs.sort{|a,b| a.name <=> b.name}
            ordered_list.each do |obj|
                #binding.pry
                puts "#{count}. #{obj.name} - #{obj.genre.name}"
                count += 1
            end
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.strip

        if genre = Genre.find_by_name(input)
            count = 1
            ordered_list = genre.songs.sort{|a,b| a.name <=> b.name}
            ordered_list.each do |song|
                puts "#{count}. #{song.artist.name} - #{song.name}"
                count += 1
            end
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        input = gets.strip.to_i

        if (1..Song.all.length).include?(input)
            song = Song.all.sort{|a,b| a.name <=> b.name}[input - 1]
            #binding.pry
        end

        puts "Playing #{song.name} by #{song.artist.name}" if song

    end


end
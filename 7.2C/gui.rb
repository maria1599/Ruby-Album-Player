require 'rubygems'
require 'gosu'

TOP_COLOR = Gosu::Color.new(0xFF1EB1FA)
BOTTOM_COLOR = Gosu::Color.new(0xFF1D4DB5)

module ZOrder
  BACKGROUND, PLAYER, UI = *0..2
end


class ArtWork
	attr_accessor :bmp

	def initialize (file)
		@bmp = Gosu::Image.new(file)
	end
end

class Track
	attr_accessor :name, :location

	def initialize (name, location)
		@name = name
		@location = location
	end
end

class Album
	attr_accessor  :title, :artist, :artwork, :tracks, :id

	def initialize (title, artist, artwork, tracks)
		@title = title
		@artist = artist
		@artwork = artwork
		@tracks = tracks
	end
end


class MusicPlayerMain < Gosu::Window

	def initialize
	    super 650, 450
        self.caption = "Music Player"
		@track_font =Gosu::Font.new(20)
        @info_font = Gosu::Font.new(15)
        @background = Gosu::Color::TOP_COLOR
        @locs = [60,60]
        
        @play_song = -1
      
        @album_image = Gosu::Image.new("images/ctrl2.jpg")
       
        music_file = File.new("album1.txt", "r")
        $album = read_album(music_file)
        
      	
    end

    # Put in your code here to load albums and tracks
    def read_track music_file
        track_name = music_file.gets.chomp
        track_location = music_file.gets.chomp
        track = Track.new(track_name, track_location)
        return track
    end

    def read_tracks music_file
        tracks = Array.new
        count = music_file.gets().to_i
        
        index = 0
        while (index < count)
            track = read_track(music_file)
            tracks << track
            index += 1 
        end
        return tracks
    end

    def read_album (music_file) #reads an album from a file
        album_title = music_file.gets.chomp
        album_artist = music_file.gets.chomp
        album_artwork = music_file.gets.chomp
        tracks = read_tracks(music_file)
        album = Album.new(album_title, album_artist, album_artwork, tracks)
        album
    end
    

  # Draws the artwork on the screen for all the albums

    def draw_album
      @album_image.draw(40,30, z = ZOrder::PLAYER)                 
    end

  # Detects if a 'mouse sensitive' area has been clicked on
  # i.e either an album or a track. returns true or false

    def area_clicked(leftX, topY, rightX, bottomY)
        x1 = mouse_x
        y1 = mouse_y
        x2 = leftX + rightX
        y2 = topY + bottomY

        if ((x1 > leftX) and (x1 < rightX) and (y1 > topY) and (y1 < y2))
            true
        else
            false
        end
    end
 
    def display_track 
        index = 0
        # y value of y position
        yval= 30
         while (index < $album.tracks.size)
            
            @track_font.draw($album.tracks[index].name, 300, yval, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)
            index += 1
            yval += 30
        end
    end


  # Takes a track index and an Album and plays the Track from the Album

    def playTrack(track)
        puts $album.tracks[track].location
        @song = Gosu::Song.new($album.tracks[track].location)
        @song.play(false)
    end

        
   


    def draw_background
        Gosu.draw_rect(0, 0, 650, 450, @background, ZOrder::BACKGROUND, mode=:default)
    end

	def update
	end

 # Draws the album images and the track list for the selected album

	def draw
        draw_background  
        draw_album    
       
        @info_font.draw("mouse_x: #{@locs[0]} mouse_y: #{@locs[1]} ", 5, 420, ZOrder::UI, 1.0, 1.0, Gosu::Color::WHITE)
        
        if @showTracks == true
              display_track  
         end

       if @play_song > - 1
            @info_font.draw("Now playing...#{$album.tracks[@play_song].name}", 300, 400, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)
       end
    end

 	def needs_cursor?; true; end


	def button_down(id)
	    case id
        when Gosu::MsLeft
            @locs = [mouse_x, mouse_y]
            if area_clicked(40, 30, 253, 244)
                @background = Gosu::Color::BOTTOM_COLOR
                @showTracks = true
            end
            #track 1
            if area_clicked(300, 32, 400, 51)
                playTrack(0)
                @play_song = 0
            end

            #track 2
            if area_clicked(300, 64, 367, 75)
                playTrack(1)
                @play_song = 1
            end

            #track 3
            if area_clicked(300, 93, 455, 108)
                playTrack(2)
                @play_song = 2
            end

            #track 4
            if area_clicked(300, 123, 345, 136)
                playTrack(3)
                @play_song = 3
            end

            #track 5
            if area_clicked(300, 153, 361, 166)
                playTrack(4)
                @play_song = 4
            end

            #track 6
            if area_clicked(300, 185, 370, 201)
                playTrack(5)
                @play_song = 5
            end

            #track 7
            if area_clicked(300, 215, 418, 225)
                playTrack(6)
                @play_song = 6
            end

            #track 8
            if area_clicked(300, 244, 408, 261)
                playTrack(7)
                @play_song = 7
            end

	    end
	end

end

# Show is a method that loops through update and draw

MusicPlayerMain.new.show if __FILE__ == $0

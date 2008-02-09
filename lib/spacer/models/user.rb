module Spacer
  class User
    include Model
    attr_accessor :name, :uri, :webUri, :userType, :userId, :onlineNow, :image, :__type
    attr_accessor :client
    
    class << self
      def from_hash_with_client(hash, client)
        instance = new(hash)
        instance.client = client
        instance        
      end
    end
    
    ## These are helper methods to access client calls if you already have a user instance
    
    def profile
      @client.profile(userId)
    end
    
    def friends(page=nil, page_size=nil, list=nil)
      @client.friends(userId, page, page_size, list)
    end
    
    def albums
      @client.albums(userId)
    end
    
    def album(album_id)
      @client.album(userId, album_id)
    end
    
    def photos_for_album(album_id)
      @client.photos_for_album(userId, album_id)
    end
    
    def photos
      @client.photos(userId)
    end
    
    def interests
      @client.interests(userId)
    end
    
    def details
      @client.details(userId)
    end
    
    def videos
      @client.videos(userId)
    end
    
    def video(video_id)
      @client.video(userId, video_id)
    end
    
    def photo(photo_id)
      @client.photo(userId, photo_id)
    end
    
    def status
      @client.status(userId)
    end
    
    def mood
      @client.mood(userId)
    end
    
    def friends_with?(friends_ids)
      @client.friendship?(userId, friend_ids)
    end
    
    def groups
      @client.groups(userId)
    end
  end
end
module Spacer
  class Client
    
    SERVER    = 'api.msappspace.com'
    VERSION   = 'v1'
    FORMAT    = :json
    LOG_LEVEL = Logger::INFO
    
    def initialize(api_key, secret_key, logger=nil)
      @auth = Authentication.new(api_key, secret_key)
      
      if logger
        @log = logger
      else
        @log = Logger.new(STDOUT)
        @log.level = LOG_LEVEL
      end
    end
    
    def user(user_id)
      response = do_request "users/#{user_id}"
      @user = User.from_hash(response)
    end
    
    def current_user
      response = do_request "currentuser"
      # puts response.inspect
    end
    
    def profile(user_id)
      response = do_request "users/#{user_id}/profile"
      @profile = Profile.from_hash(response)
    end
    
    def friends(user_id, page=nil, page_size=nil, list=nil)
      response = do_request "users/#{user_id}/friends.#{FORMAT.to_s}?page=#{page}&page_size=#{page_size}&list=#{list}"
      @friends = response['friends'].map do |friend|
        User.from_hash(friend)
      end
    end
    
    def albums(user_id)
      response = do_request "users/#{user_id}/albums"
      @albums = response['albums'].map do |album|
        Album.from_hash(album)
      end
    end
    
    def album(user_id, album_id)
      response = do_request "users/#{user_id}/albums/#{album_id}"
      @album = Album.from_hash(response)
    end
    
    def photos_for_album(user_id, album_id)
      response = do_request "users/#{user_id}/albums/#{album_id}/photos"
      @photos = response['photos'].map do |photo|
        Photo.from_hash(photo)
      end
    end
    
    def photos(user_id)
      response = do_request "users/#{user_id}/photos"
      @photos = response['photos'].map do |photo|
        Photo.from_hash(photo)
      end      
    end
    
    def interests(user_id)
      response = do_request "users/#{user_id}/interests"
      @interests = Interest.from_hash(response)
    end
    
    def details(user_id)
      response = do_request "users/#{user_id}/details"
      @details = Details.from_hash(response)
    end
    
    def videos(user_id)
      response = do_request "users/#{user_id}/videos"
      @videos = response['videos'].map do |video|
        Video.from_hash(video)
      end            
    end
    
    def video(user_id, video_id)
      response = do_request "users/#{user_id}/videos/#{video_id}"
      @video = Video.from_hash(response)
    end
    
    def photo(user_id, photo_id)
      response = do_request "users/#{user_id}/photos/#{photo_id}"
      @photo = Photo.from_hash(response)
    end
    
    def status(user_id)
      response = do_request "users/#{user_id}/status"
      @status = Status.from_hash(response)
    end
    
    def mood(user_id)
      response = do_request "users/#{user_id}/mood"
      @mood = Mood.from_hash(response)      
    end
    
    def friendship?(user_id, friend_ids)
      multiple_friends = friend_ids.is_a?(Array)

      friend_ids = friend_ids.join(';') if multiple_friends
      response = do_request "users/#{user_id}/friends/#{friend_ids}"
      
      if multiple_friends
        @friendships = response['friendship'].map do |friendship|
          friendship['areFriends']
        end
      else
        response['friendship'].first['areFriends']
      end
    end
  
  private 
    def do_request(query)
      request_uri = request_uri(query)

      http = Net::HTTP.new(request_uri.host, request_uri.port)
      request = Net::HTTP::Get.new(request_uri.path)
      request = @auth.process_request(http, request)
      @log.debug "REQUEST PATH: #{request.path}"
      
      response = http.request(request)
      @log.debug "RESPONSE BODY: #{response.body}\n"
      
      ActiveSupport::JSON.decode(response.body)     
    end
    
    def request_uri(query)
      URI.parse("http://#{SERVER}/#{VERSION}/#{query}.#{FORMAT.to_s}")
    end    
  end
end
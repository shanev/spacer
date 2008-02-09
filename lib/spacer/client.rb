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
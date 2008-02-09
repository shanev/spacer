module Spacer
  
  class Authentication
    def initialize(api_key, secret_key)
      @oauth_consumer = OAuth::Consumer.new(CGI.escape(api_key), secret_key)
    end
    
    def process_request(http, request)
      request.oauth!(http, @oauth_consumer, nil, { :scheme => :query_string, :nonce => nonce, :timestamp => timestamp })
      request
    end
    
  private
    def nonce
      rand(2**128).to_s
    end
  
    def timestamp
      Time.new.to_i.to_s
    end
  end
  
end
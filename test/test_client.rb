# $Id$

require File.join(File.dirname(__FILE__), %w[test_helper])
require 'test/unit'
require 'mocha'

class ClientTest < Test::Unit::TestCase
  
  STUB_NETWORK = true
  
  def setup
    api_key = 'http://www.myspace.com/yourappname'
    secret_key = 'secretkey'
    @myspace = Spacer::Client.new(api_key, secret_key)
  end

  def test_get_user_info
    stubbing_http_response_with example_user_response_json do        
      user = @myspace.user('107265345')
      assert_equal "BrownPunk!", user.name
    end
  end
  
  def test_get_profile
    stubbing_http_response_with example_profile_response_json do
      profile = @myspace.profile('107265345')
      assert_equal "CHICAGO", profile.city
    end
  end
  
  def test_get_friends
    stubbing_http_response_with example_friends_response_json do
      friends = @myspace.friends('107265345')
      assert_equal 2, friends.size
      assert_equal 'Tom', friends.first.name
    end
  end
  
  # def test_get_albums
  #   stub_http_response_with( example_albums_response_json )
  #   friends = @myspace.albums('107265345')
  #   assert_equal 4, albums.size
  #   assert_equal 'bike', albums.first.name    
  # end
  
  # def test_get_current_user
  #   @myspace.current_user
  # end
  
private
  def example_user_response_json
    '{"image":"http:\/\/x.myspace.com\/images\/no_pic.gif","name":"BrownPunk!","onlineNow":false,"uri":"http:\/\/api.msappspace.com\/v1","userId":107265345,"userType":"Band","webUri":"http:\/\/www.myspace.com\/107265345"}'
  end
  
  def example_profile_response_json
    '{"aboutme":"","age":104,"basicprofile":{"__type":"Profile:#MySpace.Services.DataContracts","image":"http:\/\/x.myspace.com\/images\/no_pic.gif","name":"BrownPunk!","type":2,"uri":"http:\/\/api.msappspace.com\/v1\/users\/107265345","userId":107265345,"webUri":"http:\/\/www.myspace.com\/107265345"},"city":"CHICAGO","country":"US","culture":"en-US","gender":"Female","hometown":"","maritalstatus":"Single","postalcode":"60614","region":"Illinois"}'
  end
  
  def example_friends_response_json
    '{"count":2,"friends":[{"__type":"User:#MySpace.Services.DataContracts","image":"http:\/\/b2.ac-images.myspacecdn.com\/00000\/20\/52\/2502_s.jpg","name":"Tom","onlineNow":false,"uri":"http:\/\/api.msappspace.com\/v1\/users\/107265345","userId":6221,"userType":"RegularUser","webUri":"http:\/\/www.myspace.com\/tom"},{"__type":"User:#MySpace.Services.DataContracts","image":"http:\/\/x.myspace.com\/images\/no_pic.gif","name":"Video Jukebox","onlineNow":false,"uri":"http:\/\/api.msappspace.com\/v1\/users\/107265345","userId":330729305,"userType":"Application","webUri":"http:\/\/www.myspace.com\/330729305"}],"next":null,"prev":null,"topFriends":null,"user":{"__type":"User:#MySpace.Services.DataContracts","image":"http:\/\/x.myspace.com\/images\/no_pic.gif","name":"BrownPunk!","onlineNow":false,"uri":"http:\/\/api.msappspace.com\/v1\/users\/107265345","userId":107265345,"userType":"Band","webUri":"http:\/\/www.myspace.com\/107265345"}}'
  end
  
  def example_albums_response_json
    '{"albums":[{"__type":"Album:#MySpace.Services.DataContracts","albumUri":"http:\/\/api.msappspace.com\/v1\/users\/107265345\/albums\/1580520","defaultImage":"http:\/\/a375.ac-images.myspacecdn.com\/images01\/3\/m_975e32aedf2bd81fbe2bf8d3d6d4674e.jpg","id":1580520,"location":"","photoCount":1,"photosUri":"http:\/\/api.msappspace.com\/v1\/users\/107265345\/albums\/1580520\/photos","privacy":"Everyone","title":"My Photos","user":{"__type":"User:#MySpace.Services.DataContracts","image":"http:\/\/a375.ac-images.myspacecdn.com\/images01\/3\/s_975e32aedf2bd81fbe2bf8d3d6d4674e.jpg","name":"BrownPunk!","onlineNow":false,"uri":"http:\/\/api.msappspace.com\/v1\/users\/107265345","userId":107265345,"userType":"Band","webUri":"http:\/\/www.myspace.com\/107265345"}}],"count":1,"next":null,"prev":null,"user":{"__type":"User:#MySpace.Services.DataContracts","image":"http:\/\/a375.ac-images.myspacecdn.com\/images01\/3\/s_975e32aedf2bd81fbe2bf8d3d6d4674e.jpg","name":"BrownPunk!","onlineNow":false,"uri":"http:\/\/api.msappspace.com\/v1\/users\/107265345","userId":107265345,"userType":"Band","webUri":"http:\/\/www.myspace.com\/107265345"}}'
  end

  def stubbing_http_response_with(xml_or_json_response)
    if STUB_NETWORK
      response = stub(:body => xml_or_json_response)
      Net::HTTP.any_instance.stubs(:request).returns(response)
    end
    yield
  end
end

# $Id$

require File.join(File.dirname(__FILE__), %w[test_helper])
require 'test/unit'
require 'mocha'

class TestClient < Test::Unit::TestCase
  
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
  
  def test_get_albums
    stubbing_http_response_with example_albums_response_json do
      albums = @myspace.albums('107265345')
      assert_equal 1, albums.size
      assert_equal 'My Photos', albums.first.title
      assert_equal 1580520, albums.first.id
    end
  end
  
  def test_get_album_by_id
    stubbing_http_response_with example_album_by_id_response_json do
      album = @myspace.album('107265345', 1580520)
      assert_equal 'My Photos', album.title
      assert_equal 1580520, album.id
    end      
  end
  
  def test_get_photos_by_album_id
    stubbing_http_response_with example_photos_for_album_response_json do
      photos = @myspace.photos_for_album('107265345', 1580520)
      assert_equal '', photos.first.caption
    end
  end
  
  def test_get_photos
    stubbing_http_response_with example_photos_response_json do
      photos = @myspace.photos(107265345)
      assert_equal '', photos.first.caption
      assert_equal 19071328, photos.first.id
    end
  end
  
  def test_get_interests
    stubbing_http_response_with example_interests_response_json do
      interests = @myspace.interests(107265345)
      assert_equal 'Stewart Copeland', interests.heroes
    end
  end
  
  def test_get_details
    stubbing_http_response_with example_details_response_json do
      details = @myspace.details(107265345)
      assert_equal 'Single', details.status # <--- see ladies!!!
    end
  end
  
  def test_get_videos
    stubbing_http_response_with example_videos_response_json do
      videos = @myspace.videos(107265345)
      assert_equal 'Keechu', videos.first.title
      assert_equal 27953679, videos.first.id
    end    
  end
  
  def test_get_videos
    stubbing_http_response_with example_video_response_json do
      video = @myspace.video(107265345, 27953679)
      assert_equal 'Keechu', video.title
      assert_equal 27953679, video.id
    end    
  end
  
  def test_get_photo
    stubbing_http_response_with example_photo_response_json do
      photo = @myspace.photo(107265345, 19071328)
      assert_equal 'hi mom', photo.caption
    end        
  end
  
  def test_get_status
    stubbing_http_response_with example_status_response_json do
      status = @myspace.status(107265345)
      assert_equal 'none', status.status
    end        
  end
  
  def test_get_mood
    stubbing_http_response_with example_mood_response_json do
      mood = @myspace.mood(107265345)
      assert_equal 'none', mood.mood
    end            
  end
  
  def test_get_friendship_for_one_person
    stubbing_http_response_with example_friendship_response_for_one_friend_json do
      friendship = @myspace.friendship?(107265345, 107265345)
      assert_equal true, friendship
    end                
  end

  def test_get_friendship_for_multiple_people
    stubbing_http_response_with example_friendship_response_for_multiple_friends_json do
      friendships = @myspace.friendship?(107265345, [107265345, 107265346])
      assert_equal true, friendships.first
      assert_equal false, friendships.last
    end                
  end

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
  
  def example_album_by_id_response_json
    '{"albumUri":"http:\/\/api.msappspace.com\/v1\/users\/107265345\/albums\/1580520","defaultImage":"http:\/\/a375.ac-images.myspacecdn.com\/images01\/3\/m_975e32aedf2bd81fbe2bf8d3d6d4674e.jpg","id":1580520,"location":"","photoCount":1,"photosUri":"http:\/\/api.msappspace.com\/v1\/users\/107265345\/albums\/1580520\/photos","privacy":"Everyone","title":"My Photos","user":{"__type":"User:#MySpace.Services.DataContracts","image":"http:\/\/a375.ac-images.myspacecdn.com\/images01\/3\/s_975e32aedf2bd81fbe2bf8d3d6d4674e.jpg","name":"BrownPunk!","onlineNow":false,"uri":"http:\/\/api.msappspace.com\/v1\/users\/107265345","userId":107265345,"userType":"Band","webUri":"http:\/\/www.myspace.com\/107265345"}}'
  end
  
  def example_photos_for_album_response_json
    '{"count":1,"next":null,"photos":[{"__type":"Photo:#MySpace.Services.DataContracts","caption":"","id":19071328,"imageUri":"http:\/\/a375.ac-images.myspacecdn.com\/images01\/3\/l_975e32aedf2bd81fbe2bf8d3d6d4674e.jpg","photoUri":"http:\/\/api.msappspace.com\/v1\/users\/107265345\/albums\/1580520\/photos\/19071328","user":{"__type":"User:#MySpace.Services.DataContracts","image":"http:\/\/a375.ac-images.myspacecdn.com\/images01\/3\/s_975e32aedf2bd81fbe2bf8d3d6d4674e.jpg","name":"BrownPunk!","onlineNow":false,"uri":"http:\/\/api.msappspace.com\/v1\/users\/107265345","userId":107265345,"userType":"Band","webUri":"http:\/\/www.myspace.com\/107265345"}}],"prev":null,"user":{"__type":"User:#MySpace.Services.DataContracts","image":"http:\/\/a375.ac-images.myspacecdn.com\/images01\/3\/s_975e32aedf2bd81fbe2bf8d3d6d4674e.jpg","name":"BrownPunk!","onlineNow":false,"uri":"http:\/\/api.msappspace.com\/v1\/users\/107265345","userId":107265345,"userType":"Band","webUri":"http:\/\/www.myspace.com\/107265345"}}'
  end
  
  def example_photos_response_json
    '{"count":1,"next":null,"photos":[{"__type":"Photo:#MySpace.Services.DataContracts","caption":"","id":19071328,"imageUri":"http:\/\/a375.ac-images.myspacecdn.com\/images01\/3\/l_975e32aedf2bd81fbe2bf8d3d6d4674e.jpg","photoUri":"http:\/\/api.msappspace.com\/v1\/users\/107265345\/photos\/19071328","user":{"__type":"User:#MySpace.Services.DataContracts","image":"http:\/\/a375.ac-images.myspacecdn.com\/images01\/3\/s_975e32aedf2bd81fbe2bf8d3d6d4674e.jpg","name":"BrownPunk!","onlineNow":false,"uri":"http:\/\/api.msappspace.com\/v1\/users\/107265345","userId":107265345,"userType":"Band","webUri":"http:\/\/www.myspace.com\/107265345"}}],"prev":null,"user":{"__type":"User:#MySpace.Services.DataContracts","image":"http:\/\/a375.ac-images.myspacecdn.com\/images01\/3\/s_975e32aedf2bd81fbe2bf8d3d6d4674e.jpg","name":"BrownPunk!","onlineNow":false,"uri":"http:\/\/api.msappspace.com\/v1\/users\/107265345","userId":107265345,"userType":"Band","webUri":"http:\/\/www.myspace.com\/107265345"}}'
  end
  
  def example_interests_response_json
    '{"books":"","general":"","heroes":"Stewart Copeland","movies":"","music":"","television":"","user":{"__type":"User:#MySpace.Services.DataContracts","image":"http:\/\/a375.ac-images.myspacecdn.com\/images01\/3\/s_975e32aedf2bd81fbe2bf8d3d6d4674e.jpg","name":"BrownPunk!","onlineNow":false,"uri":"http:\/\/api.msappspace.com\/v1\/users\/107265345","userId":107265345,"userType":"Band","webUri":"http:\/\/www.myspace.com\/107265345"}}'
  end
  
  def example_details_response_json
    '{"bodyType":"No Answer","children":"No Answer","drink":"No Answer","education":"No Answer","ethnicity":"No Answer","herefor":"Friends","hometown":"","income":"No Answer","orientation":"No Answer","religion":"No Answer","smoke":"No Answer","status":"Single","user":{"__type":"User:#MySpace.Services.DataContracts","image":"http:\/\/a375.ac-images.myspacecdn.com\/images01\/3\/s_975e32aedf2bd81fbe2bf8d3d6d4674e.jpg","name":"BrownPunk!","onlineNow":false,"uri":"http:\/\/api.msappspace.com\/v1\/users\/107265345","userId":107265345,"userType":"Band","webUri":"http:\/\/www.myspace.com\/107265345"},"zodiacsign":null}'
  end
  
  def example_videos_response_json
    '{"count":1,"next":null,"prev":null,"user":{"__type":"User:#MySpace.Services.DataContracts","image":"http:\/\/a375.ac-images.myspacecdn.com\/images01\/3\/s_975e32aedf2bd81fbe2bf8d3d6d4674e.jpg","name":"BrownPunk!","onlineNow":false,"uri":"http:\/\/api.msappspace.com\/v1\/users\/107265345","userId":107265345,"userType":"Band","webUri":"http:\/\/www.myspace.com\/107265345"},"videos":[{"__type":"Video:#MySpace.Services.DataContracts","country":"US","datecreated":"\/Date(1202587923333-0800)\/","dateupdated":"\/Date(1202587923333-0800)\/","description":"pet","id":27953679,"language":"en","mediastatus":"WatingForUpload","mediatype":"4","privacy":"Public","resourceuserid":"107265345","runtime":"0","thumbnail":"http:\/\/b5.ac-images.myspacecdn.com\/02091\/50\/94\/2091104905_thumb1.jpg","title":"Keechu","totalrating":"0","totalviews":"0","totalvotes":"0","user":{"__type":"User:#MySpace.Services.DataContracts","image":"http:\/\/a375.ac-images.myspacecdn.com\/images01\/3\/s_975e32aedf2bd81fbe2bf8d3d6d4674e.jpg","name":"BrownPunk!","onlineNow":false,"uri":"http:\/\/api.msappspace.com\/v1\/users\/107265345","userId":107265345,"userType":"Band","webUri":"http:\/\/www.myspace.com\/107265345"},"videoUri":"http:\/\/api.msappspace.com\/v1\/users\/107265345\/videos\/27953679"}]}'
  end
  
  def example_video_response_json
    '{"country":"US","datecreated":"\/Date(1202587923333-0800)\/","dateupdated":"\/Date(1202587923333-0800)\/","description":"pet","id":27953679,"language":"en","mediastatus":"ProcessingSuccessful","mediatype":"4","privacy":"Public","resourceuserid":"107265345","runtime":"18","thumbnail":"http:\/\/b5.ac-images.myspacecdn.com\/02091\/50\/94\/2091104905_thumb1.jpg","title":"Keechu","totalrating":"0","totalviews":"0","totalvotes":"0","user":{"__type":"User:#MySpace.Services.DataContracts","image":"http:\/\/a375.ac-images.myspacecdn.com\/images01\/3\/s_975e32aedf2bd81fbe2bf8d3d6d4674e.jpg","name":"BrownPunk!","onlineNow":false,"uri":"http:\/\/api.msappspace.com\/v1\/users\/107265345","userId":107265345,"userType":"Band","webUri":"http:\/\/www.myspace.com\/107265345"},"videoUri":"http:\/\/api.msappspace.com\/v1\/users\/107265345\/videos\/27953679"}'
  end
  
  def example_photo_response_json
    '{"caption":"hi mom","id":19071328,"imageUri":"http:\/\/a375.ac-images.myspacecdn.com\/images01\/3\/l_975e32aedf2bd81fbe2bf8d3d6d4674e.jpg","photoUri":"http:\/\/api.msappspace.com\/v1\/users\/107265345\/photos\/19071328","user":{"__type":"User:#MySpace.Services.DataContracts","image":"http:\/\/a375.ac-images.myspacecdn.com\/images01\/3\/s_975e32aedf2bd81fbe2bf8d3d6d4674e.jpg","name":"BrownPunk!","onlineNow":false,"uri":"http:\/\/api.msappspace.com\/v1\/users\/107265345","userId":107265345,"userType":"Band","webUri":"http:\/\/www.myspace.com\/107265345"}}'
  end
  
  def example_status_response_json
    '{"status":"none","user":{"__type":"User:#MySpace.Services.DataContracts","image":"http:\/\/a375.ac-images.myspacecdn.com\/images01\/3\/s_975e32aedf2bd81fbe2bf8d3d6d4674e.jpg","name":"BrownPunk!","onlineNow":false,"uri":"http:\/\/api.msappspace.com\/v1\/users\/107265345","userId":107265345,"userType":"Band","webUri":"http:\/\/www.myspace.com\/107265345"}}'
  end
  
  def example_mood_response_json
    '{"mood":"none","user":{"__type":"User:#MySpace.Services.DataContracts","image":"http:\/\/a375.ac-images.myspacecdn.com\/images01\/3\/s_975e32aedf2bd81fbe2bf8d3d6d4674e.jpg","name":"BrownPunk!","onlineNow":false,"uri":"http:\/\/api.msappspace.com\/v1\/users\/107265345","userId":107265345,"userType":"Band","webUri":"http:\/\/www.myspace.com\/107265345"}}'
  end
  
  def example_friendship_response_for_one_friend_json
    '{"friendship":[{"areFriends":true,"friendId":107265345}],"user":{"__type":"User:#MySpace.Services.DataContracts","image":"http:\/\/a375.ac-images.myspacecdn.com\/images01\/3\/s_975e32aedf2bd81fbe2bf8d3d6d4674e.jpg","name":"BrownPunk!","onlineNow":false,"uri":"http:\/\/api.msappspace.com\/v1\/users\/107265345","userId":107265345,"userType":"Band","webUri":"http:\/\/www.myspace.com\/107265345"}}'
  end
  
  def example_friendship_response_for_multiple_friends_json
    '{"friendship":[{"areFriends":true,"friendId":107265345},{"areFriends":false,"friendId":107265346}],"user":{"__type":"User:#MySpace.Services.DataContracts","image":"http:\/\/a375.ac-images.myspacecdn.com\/images01\/3\/s_975e32aedf2bd81fbe2bf8d3d6d4674e.jpg","name":"BrownPunk!","onlineNow":false,"uri":"http:\/\/api.msappspace.com\/v1\/users\/107265345","userId":107265345,"userType":"Band","webUri":"http:\/\/www.myspace.com\/107265345"}}'
  end

  def stubbing_http_response_with(xml_or_json_response)
    if STUB_NETWORK
      response = stub(:body => xml_or_json_response)
      Net::HTTP.any_instance.stubs(:request).returns(response)
    end
    yield
  end
end

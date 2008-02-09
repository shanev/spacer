# $Id$

STUB_NETWORK = true

require File.join(File.dirname(__FILE__), %w[test_helper])
require 'test/unit'
require 'mocha'

class TestClient < Test::Unit::TestCase
    
  def setup
    api_key = 'http://www.myspace.com/appname'
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
  
  def test_get_groups
    stubbing_http_response_with example_groups_response_json do
      groups = @myspace.groups(107265345)
      assert_equal 'Tom Morello etc.', groups.first.groupName
      assert_equal 'XOC', groups.last.groupName
    end                
  end
end

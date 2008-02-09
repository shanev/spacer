# $Id$

require File.join(File.dirname(__FILE__), %w[test_helper])
require 'test/unit'

class ClientTest < Test::Unit::TestCase
  def setup
    api_key = 'http://www.myspace.com/jukebox'
    secret_key = 'SECRET KEY'
    @myspace = Spacer::Client.new(api_key, secret_key)
  end

  def test_get_user_info
    user = @myspace.user('107265345')
    assert_equal "BrownPunk!", user.name
  end
  
  def test_get_profile
    profile = @myspace.profile('107265345')
    assert_equal "CHICAGO", profile.city
  end
  
  def test_get_friends
    friends = @myspace.friends('107265345')
    assert_equal 2, friends.size
  end
  
  # def test_get_current_user
  #   @myspace.current_user
  # end
end

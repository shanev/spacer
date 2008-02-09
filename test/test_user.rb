# $Id$

STUB_NETWORK = true

require File.join(File.dirname(__FILE__), %w[test_helper])
require 'test/unit'
require 'mocha'

class TestUser < Test::Unit::TestCase
  
  def setup
    api_key = 'http://www.myspace.com/yourapp'
    secret_key = 'secretkey'
    myspace = Spacer::Client.new(api_key, secret_key)
    stubbing_http_response_with example_user_response_json do
      @user = myspace.user('107265345')
    end
  end

  def test_get_profile
    stubbing_http_response_with example_profile_response_json do
      profile = @user.profile
      assert_equal "CHICAGO", profile.city
    end
  end  

  def test_get_friends
    stubbing_http_response_with example_friends_response_json do
      friends = @user.friends
      assert_equal 'Tom', friends.first.name
    end
  end  
end

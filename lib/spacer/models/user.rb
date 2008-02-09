module Spacer
  class User
    include Model
    attr_accessor :name, :uri, :webUri, :userType, :userId, :onlineNow, :image, :__type
  end
end
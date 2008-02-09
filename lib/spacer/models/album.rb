module Spacer
  class Album
    include Model
    attr_accessor :user, :photosUri, :photoCount, :albumUri, :title, :id, :privacy, :defaultImage, :__type, :location
  end
end
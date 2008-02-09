module Spacer
  class Photo
    include Model
    attr_accessor :user, :photoUri, :id, :imageUri, :caption, :__type
  end
end
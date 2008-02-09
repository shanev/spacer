module Spacer
  class Profile
    include Model
    attr_accessor :city, :region, :country, :gender, :postalcode, :culture, :basicprofile, :age, :aboutme, :maritalstatus, :hometown
  end
end
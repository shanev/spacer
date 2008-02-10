# $Id$

require File.expand_path(
    File.join(File.dirname(__FILE__), %w[.. lib spacer]))

def stubbing_http_response_with(xml_or_json_response)
  if defined? Spacer::STUB_NETWORK
    if Spacer::STUB_NETWORK
      response = stub(:body => xml_or_json_response)
      Net::HTTP.any_instance.stubs(:request).returns(response)
    end
  end
  yield
end

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

def example_groups_response_json
  '{"Groups":[{"__type":"Group:#MySpace.Services.DataContracts","approveMembers":false,"categoryId":23,"categoryName":null,"city":null,"country":null,"createDate":"\/Date(1123398180000-0700)\/","description":"For people who love\/worship\/talk about Tom Morello and his insane guitar wizardry","descriptionShort":null,"groupId":100875536,"groupName":"Tom Morello etc.","groupUri":"http:\/\/api.msappspace.com\/v1\/users\/107265345\/groups\/100875536","groupUrl":null,"imageId":0,"imageType":null,"isAdult":false,"isPrivate":false,"isPublic":true,"memberBulletins":false,"memberCount":107,"memberImages":false,"membersCanInvite":false,"moderatorUserId":0,"nonMemberBoardPosting":false,"postalCode":null,"region":null,"user":{"__type":"User:#MySpace.Services.DataContracts","image":"http:\/\/a375.ac-images.myspacecdn.com\/images01\/3\/s_975e32aedf2bd81fbe2bf8d3d6d4674e.jpg","name":"BrownPunk!","onlineNow":false,"uri":"http:\/\/api.msappspace.com\/v1\/users\/107265345","userId":107265345,"userType":"Band","webUri":"http:\/\/www.myspace.com\/107265345"}},{"__type":"Group:#MySpace.Services.DataContracts","approveMembers":false,"categoryId":2,"categoryName":null,"city":null,"country":null,"createDate":"\/Date(1112112360000-0700)\/","description":"This is a group for the Nissan XTERRA owners! www.xterraownersclub.com<br>\u000aif you own a X and youre not on xoc.com  check it out!!","descriptionShort":null,"groupId":100326220,"groupName":"XOC","groupUri":"http:\/\/api.msappspace.com\/v1\/users\/107265345\/groups\/100326220","groupUrl":null,"imageId":0,"imageType":null,"isAdult":false,"isPrivate":false,"isPublic":true,"memberBulletins":false,"memberCount":301,"memberImages":false,"membersCanInvite":false,"moderatorUserId":0,"nonMemberBoardPosting":false,"postalCode":null,"region":null,"user":{"__type":"User:#MySpace.Services.DataContracts","image":"http:\/\/a375.ac-images.myspacecdn.com\/images01\/3\/s_975e32aedf2bd81fbe2bf8d3d6d4674e.jpg","name":"BrownPunk!","onlineNow":false,"uri":"http:\/\/api.msappspace.com\/v1\/users\/107265345","userId":107265345,"userType":"Band","webUri":"http:\/\/www.myspace.com\/107265345"}}],"count":2,"next":null,"prev":null,"user":{"__type":"User:#MySpace.Services.DataContracts","image":"http:\/\/a375.ac-images.myspacecdn.com\/images01\/3\/s_975e32aedf2bd81fbe2bf8d3d6d4674e.jpg","name":"BrownPunk!","onlineNow":false,"uri":"http:\/\/api.msappspace.com\/v1\/users\/107265345","userId":107265345,"userType":"Band","webUri":"http:\/\/www.myspace.com\/107265345"}}'
end

# EOF

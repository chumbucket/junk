function probe()
	if vlc.access ~= "http"
	then
		return false
	end
	if string.match(vlc.path, "vimeo.com/%d") 
	then
		return true
	else
		return false
	end
end
	
function parse()
	while true do
		line = vlc.readline()
		if not line then break end
		_,_,id = string.find(vlc.path, "vimeo.com/(.*)")
		if string.match(line, "config:.*") then
			_,_,sig = string.find(line, "signature\":\"(.*)\",\"timestamp")
			_,_,timestamp = string.find(line, ",\"timestamp\":(.*),\"expiration")
			_,_,name = string.find(line, "video\":.*\"title\":\"(.*)\",\"width")
			_,_,artist = string.find(line, "owner\":{\"name\":\"(.*)\",\"portrait")
		end
	end
	return {{path = "http://player.vimeo.com/play_redirect?quality=sd&codecs=h264,vp8,vp6&clip_id="..id.."&time="..timestamp.."&sig="..sig.."&type=html5_desktop_local"; name = name; artist = artist}}
end

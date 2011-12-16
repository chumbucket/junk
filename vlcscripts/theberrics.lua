function probe()
	if vlc.access ~= "http"
	then
		return false
	end
	if string.match(vlc.path, "theberrics.com/media") 
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
		if string.match(line, "<video") then
			_,_,path = string.find(line, "<video.*src=\'(.*)\' controls")
		end
	end
	return {{path = path}}
end

function probe()
	if vlc.access ~= "http"
	then
		return false
	end
	if string.match(vlc.path, "liveleak.com/view")
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
		if string.match(line, "levels:") then
			_,_,vidinfo = string.find(line, "file: \"(.*)\", type")
		end
	end
	return {{path = vidinfo}}
end
		
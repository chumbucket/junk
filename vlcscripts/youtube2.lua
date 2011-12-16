function probe()
	if vlc.access ~= "http"
	then
		return false
	end
	if string.match(vlc.path, "youtube.com/watch") 
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
		if string.match( line, "<meta name=\"title\"" ) then
              		_,_,name = string.find( line, "content=\"(.-)\"" )
                	name = vlc.strings.resolve_xml_special_chars( name )
                	name = vlc.strings.resolve_xml_special_chars( name )
            	end
		if string.match( line, "'VIDEO_USERNAME'" ) then
               		_,_,artist = string.find( line, "VIDEO_USERNAME': \"(.*)\"" )
           	end
		fmt_url_map = string.match( line, "\"url_encoded_fmt_stream_map\": \"(.-)\"" )
		if fmt_url_map then
			fmt_url_map = string.gsub( fmt_url_map, "\\u0026", "&" )
                    	for url,itag in string.gmatch( fmt_url_map, "url=([^&,]+).-&itag=(%d+)" ) do
                        -- Apparently formats are listed in quality order,
                        -- so we can afford to simply take the first one
                        	if tonumber( itag ) == 34 then
                            		url = vlc.strings.decode_uri( url )
                            		path = url
                            		break
				
                        	end
				if tonumber( itag ) == 43 then
					url = vlc.strings.decode_uri( url )
					path = url
					--break
				end

                    	end
		end
	end
	return {{path = path; name = name; artist = artist}}
end

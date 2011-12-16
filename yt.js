var loc = document.location.href;
if (loc.indexOf("watch?v=") != -1){
	var scripts = document.getElementsByTagName("script");
	for(i=0;i<scripts.length;i++){
		if(scripts[i].innerHTML.match(/img.src.*(http.*)\"/)){
			var b = scripts[i].innerHTML.match(/img.src.*(http.*)\"/)[1].replace('generate_204', 'videoplayback').replace(/\\/g, '').replace(/u0026/g, '&');
			console.log(scripts[i]);
		}
	}

console.log(b);

var container = document.getElementById('watch-video-container');
var vid = document.createElement('video');
container.innerHTML = "<video src='"+b+"'autoplay='true'></video>";
}

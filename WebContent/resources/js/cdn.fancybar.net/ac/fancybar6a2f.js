var _fancybar = {
	init : function() {
		_fbn_placement = this.getUrlVar('placement');
		_fbn_serve = this.getUrlVar('serve');
		var pro = document.createElement('script');
		pro.id = '_fbn_projs';
		pro.type = 'text/javascript';
		pro.src = '//srv.buysellads.com/ads/' + _fbn_serve
				+ '.json?segment=placement:' + _fbn_placement
				+ '&callback=_fbn_go';
		var ck = document.cookie, day = ck.indexOf('_bsap_daycap='), life = ck
				.indexOf('_bsap_lifecap=');
		day = day >= 0 ? ck.substring(day + 12 + 1).split(';')[0].split(',')
				: [];
		life = life >= 0 ? ck.substring(life + 13 + 1).split(';')[0].split(',')
				: [];
		if (day.length || life.length) {
			var freqcap = [];
			for (var i = 0; i < day.length; i++) {
				var adspot = day[i];
				for (var found = -1, find = 0; find < freqcap.length
						&& found == -1; find++)
					if (freqcap[find][0] == adspot)
						found = find;
				if (found == -1)
					freqcap.push([ adspot, 1, 0 ]);
				else
					freqcap[found][1]++
			}
			for (var i = 0; i < life.length; i++) {
				var adspot = day[i];
				for (var found = -1, find = 0; find < freqcap.length
						&& found == -1; find++)
					if (freqcap[find][0] == adspot)
						found = find;
				if (found == -1)
					freqcap.push([ adspot, 0, 1 ]);
				else
					freqcap[found][2]++
			}
			for (var i = 0; i < freqcap.length; i++)
				freqcap[i] = freqcap[i].join(',');
			if (freqcap.length)
				pro.src += '&freqcap=' + freqcap.join(';')
		}
		document.getElementsByTagName('head')[0].appendChild(pro)
	},
	run : function(a) {
		var ad = a, c = '', link = ad.statlink.split('?encredirect='), fulllink, image = ad.image, text = ad.text, callToActionColor = ad.callToActionColor, callToActionTextColor = ad.callToActionTextColor, textcolorHover = ad.textcolorHover, barcolorHover = ad.barcolorHover, barcolor = ad.barcolor, calltoaction = ad.calltoaction, callToActionColorHover = ad.callToActionColorHover, textcolor = ad.textcolor, callToActionTextColorHover = ad.callToActionTextColorHover, time = Date
				.now() / 1000 | 0;
		c += '<style type="text/css">.fancybar_hide ._fancybar{top:-100%;}.fancybar_show ._fancybar {top:0;}._fancybar{display:block;width:100%;float:left;position:fixed;top:-50px;left:0;right:0;z-index:100001;background-color:'
				+ barcolor
				+ ';-webkit-transition:top 700ms;-moz-transition:top 700ms;-o-transition:top 700ms;transition:top 700ms;text-align:center;-webkit-box-sizing:border-box;-moz-box-sizing:border-box;-ms-box-sizing:border-box;box-sizing:border-box;font-family:helvetica,arial,sans-serif;margin:0 auto;box-shadow: 0 1px 5px rgba(0,0,0,.6);backface-visibility:hidden;}._fancybar a {display:block;position:relative;text-align:left;text-decoration:none;margin:0 auto;float:left;width:100%;padding:10px 5%;-webkit-box-sizing:border-box;-moz-box-sizing:border-box;-ms-box-sizing:border-box;box-sizing:border-box;}._fancybar a:hover {background:'
				+ barcolorHover
				+ ';display: block;}._fancybar a .fancybar-cta {display:block;float:right;color:'
				+ callToActionTextColor
				+ ';background-color:'
				+ callToActionColor
				+ ';border-radius:2px;line-height:28px;font-size:15px;-webkit-box-sizing:border-box;-moz-box-sizing:border-box;-ms-box-sizing:border-box;box-sizing:border-box;margin:0;padding:0 12px;}._fancybar a:hover .fancybar-cta {background:'
				+ callToActionColorHover
				+ ';color:'
				+ callToActionTextColorHover
				+ ';}._fancybar a .fancybar-logo {display:block;float:left;padding:0;margin:-10px 0;}._fancybar a .fancybar-logo img {display:block;max-width:110px;}._fancybar a .fancybar-text {float:left;font-size:16px;line-height:16px;padding:8px 0 0 15px;color:'
				+ textcolor
				+ ';}._fancybar a:hover .fancybar-text {color:'
				+ textcolorHover
				+ ';}@media all and (max-width: 680px){._fancybar a .fancybar-logo {margin:0 auto;display:block;min-width:100%;}._fancybar a .fancybar-logo img {max-width:110px;display:block;margin:0 auto;}._fancybar a .fancybar-text {font-size:13px;line-height:13px;padding:10px 0;text-align:center;width:100%;display:block;}._fancybar a .fancybar-cta {display:block;float:left;width:100%;margin:0;-webkit-box-sizing:border-box;-moz-box-sizing:border-box;-ms-box-sizing:border-box;box-sizing:border-box;text-align:center;}}._fancybar .fancybar-close{display: block;position: absolute;top: 11px;right: 15px;padding: 5px 10px 7px;border-radius: 2px;color:'
				+ textcolor
				+ ';z-index: 2;font-size: 14px;line-height: 12px;}._fancybar .fancybar-close:hover{cursor: pointer;background:'
				+ barcolorHover + ';}</style>';
		if (typeof link[1] != 'undefined')
			fulllink = link[0] + '?segment=placement:' + _fbn_placement
					+ ';&encredirect=' + encodeURIComponent(link[1]);
		else if (link[0].search('srv.buysellads.com') > 0)
			fulllink = link[0] + '?segment=placement:' + _fbn_placement + ';';
		else
			fulllink = link[0];
		fulllink = fulllink.replace('<<publisher>>', _fbn_placement);
		fulllink = fulllink.replace('[timestamp]', time);
		c += '<div class="_fancybar" id="_fancybar_div"><span class="fancybar-close" onclick="_fancybar.close(\'_fbn_'
				+ _fancybar.getUrlVar('serve')
				+ '\')">x</span><a href="'
				+ fulllink
				+ '" target="_blank"><span class="fancybar-logo"><img src="'
				+ image
				+ '"></span><span class="fancybar-cta">'
				+ calltoaction
				+ '</span><span class="fancybar-text">'
				+ text
				+ '</span></a></div>';
		if (ad.pixel)
			c += '<img src="' + ad.pixel.replace('[timestamp]', time)
					+ '" style="display:none;" height="0" width="0" />';
		_fancybar.drop(c, 'div', '_fbn_' + _fbn_serve);
		_bsap_serving_callback(ad.bannerid, ad.zonekey, ad.freqcap)
	},
	ismobile : function() {
		var check = false;
		(function(a) {
			if (/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino/i
					.test(a)
					|| /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i
							.test(a.substr(0, 4)))
				check = true
		})(navigator.userAgent || navigator.vendor || window.opera);
		return check
	},
	getParams : function(script_name) {
		var scripts = document.getElementsByTagName('script');
		for (var i = 0; i < scripts.length; i++) {
			if (scripts[i].src.indexOf('/' + script_name) > -1) {
				var pa = scripts[i].src.split('?').pop().split('&');
				var p = {};
				for (var j = 0; j < pa.length; j++) {
					var kv = pa[j].split('=');
					p[kv[0]] = kv[1]
				}
				return p
			}
		}
		return {}
	},
	exists : function(obj) {
		var hasOwnProperty = Object.prototype.hasOwnProperty;
		if (obj == null)
			return false;
		if (obj.length > 0)
			return true;
		if (obj.length === 0)
			return false;
		for ( var key in obj) {
			if (hasOwnProperty.call(obj, key))
				return true
		}
		return false
	},
	drop : function(c, el, id, pixel) {
		var div = document.createElement(el);
		div.id = id;
		div.innerHTML = c, script = document.getElementById(id);
		document.getElementsByTagName('body')[0].appendChild(div)
	},
	getUrlVar : function(name) {
		name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
		var regexS = "[\\?&]" + name + "=([^&#]*)";
		var regex = new RegExp(regexS);
		var results = regex.exec(document.getElementById('_fancybar_js').src);
		if (results == null)
			return '';
		else
			return results[1]
	},
	hide : function(e) {
		if (document.getElementById(e)) {
			this.removeClass(document.getElementById(e), 'fancybar_show');
			this.addClass(document.getElementById(e), 'fancybar_hide')
		}
	},
	show : function(e) {
		if (document.getElementById(e)) {
			this.removeClass(document.getElementById(e), 'fancybar_hide');
			this.addClass(document.getElementById(e), 'fancybar_show')
		}
	},
	close : function(e) {
		this.hide(e);
		var date = new Date();
		date.setTime(date.getTime() + (24 * 60 * 60 * 1000));
		document.cookie = '_fbn_' + this.getUrlVar('placement')
				+ '=hide; expires=' + date.toGMTString() + '; path=/'
	},
	hasClass : function(el, name) {
		return new RegExp('(\\s|^)' + name + '(\\s|$)').test(el.className)
	},
	addClass : function(el, name) {
		if (!this.hasClass(el, name)) {
			el.className += (el.className ? ' ' : '') + name
		}
	},
	removeClass : function(el, name) {
		if (this.hasClass(el, name))
			el.className = el.className.replace(
					new RegExp('(\\s|^)' + name + '(\\s|$)'), ' ').replace(
					/^\s+|\s+$/g, '')
	},
	getCookie : function(name) {
		var nameEQ = name + "=";
		var ca = document.cookie.split(';');
		for (var i = 0; i < ca.length; i++) {
			var c = ca[i];
			while (c.charAt(0) == ' ')
				c = c.substring(1, c.length);
			if (c.indexOf(nameEQ) == 0)
				return c.substring(nameEQ.length, c.length)
		}
		return null
	}
};
var _fbn_go = function(ads) {
	if (_fancybar.exists(ads['ads'][0].statlink))
		_fancybar.run(ads['ads'][0])
};
window['_bsap_serving_callback'] = function(banner, zone, freqcap) {
	var append = function(w, data, days) {
		var c = document.cookie, i = c.indexOf(w + '='), existing = i >= 0 ? c
				.substring(i + w.length + 1).split(';')[0]
				+ ',' : '', d = new Date();
		d.setTime(days * 3600000 + d);
		data = existing + data;
		data = data.substring(0, 2048);
		document.cookie = w + '=' + data + '; expires=' + d.toGMTString()
				+ '; path=\/'
	};
	if (freqcap) {
		append('_bsap_daycap', banner, 1);
		append('_bsap_lifecap', banner, 365)
	}
};
if (!_fancybar.getCookie('_fbn_' + _fancybar.getUrlVar('placement'))
		&& !_fancybar.ismobile()) {
	var fancybar_didScroll;
	var fancybar_didDrop = false;
	window.onscroll = function() {
		fancybar_didScroll = true
	};
	var fancybar_scrollInterval = setInterval(
			function() {
				if (fancybar_didScroll
						&& !_fancybar.getCookie('_fbn_'
								+ _fancybar.getUrlVar('placement'))) {
					fancybar_didScroll = false;
					var scrollTop = (window.pageYOffset !== undefined) ? window.pageYOffset
							: (document.documentElement
									|| document.body.parentNode || document.body).scrollTop;
					if (scrollTop >= 200
							&& !document.getElementById('_fbn_projs')) {
						_fancybar.init()
					} else if (scrollTop >= 200) {
						_fancybar.show('_fbn_' + _fancybar.getUrlVar('serve'))
					}
					if (scrollTop < 200) {
						_fancybar.hide('_fbn_' + _fancybar.getUrlVar('serve'))
					}
				}
			}, 500)
}
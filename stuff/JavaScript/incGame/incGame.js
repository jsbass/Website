var player = {
	level:         1,
	health:        10,
	mana:          10,
	strength:      0,
	magic:         0,
	determination: 0,
	accuracy:      0,
	evasiveness:   0,
	crit_rate:     0,
	agility:       0,
	inventory:     []
};

var pSprite = $('<p id="player">\u263a<p>');
	
$(document).ready(function(){
	pSprite.offset({ top: 0, left: 0});
	$('#content').append(pSprite);
	$(document).keydown(function(e){
		console.log(e.which+' button pressed');
		if($.inArray(e.which,[37,38,39,40])){
			e.preventDefault();
			switch(e.which){
			case 37: //left
				var left = pSprite.offset().left - $('#content').offset().left;
				console.log(left);
				if(left>=5){pSprite.animate({'left': '-=5px'})};
				break;
			case 38: //up
				var top = pSprite.offset().top - $('#content').offset().top;
				console.log(top);
				if(top>=5){pSprite.animate({'top': '-=5px'})};
				break;
			case 39: //right
				var right = ($('#content').offset().left+$('#content').width)-(pSprite.offset().left+pSprite.width);
				console.log(pSprite.offset().right);
				if(right>=5){pSprite.animate({'left': '+=5px'})};
				break;
			case 40: //down
				var bottom = ($('#content').offset().top+$('#content').height)-(pSprite.offset().top+pSprite.height);
				console.log(bottom);
				if(bottom>=5){pSprite.animate({ "left": "-=50px" })};
			};
		};
	});
});
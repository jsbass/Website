var playerName = "";
var playerWins = 0;
var playerLosses = 0;

var gameInProgress = false;
var $ = document;

var myShips = {
	patrol:    [[2]]
	destroyer: [[2]]
	submarine: [[2]]
	battleship:[[2]]
	carrier:   [[2]]
	remaining: 5;
};
var enemyShips = {
	patrol:    [[2]]
	destroyer: [[2]]
	submarine: [[2]]
	battleship:[[2]]
	carrier:   [[2]]
	remaining: 5;
};

var myBoard = (function(a){ while(a.push([]) < 10); return a})([]);
var enemyBoard = (function(a){ while(a.push([]) < 10); return a})([]);

var COLORS = {
	BLANK : 'LightBlue',
	HIT   : 'red',
	MISS  : 'green',
	SHIP  : 'gray'
};

function addTiles(){
	for (var i = 0; i < 10; i++){
		for (var j = 0; j < 10; j++){
			myBoard[i][j] = $.createElement('div');
			myBoard[i][j].className = 'tile';
			myBoard[i][j].style.top = i*50+'px';
			myBoard[i][j].style.left = j*50+'px';
			$.getElementById("myBoard").appendChild(myBoard[i][j]);
	
			enemyBoard[i][j] = $.createElement('div');
			enemyBoard[i][j].className = 'tile';
			enemyBoard[i][j].style.top = i*50+'px';
			enemyBoard[i][j].style.left = j*50+'px';
			$.getElementById("enemyBoard").appendChild(enemyBoard[i][j]);
		};
	};
	resetBoard();
};

function resetBoard(){
	for (var i = 0; i < 10; i++){
		for (var j = 0; j < 10; j++){
			myBoard[i][j].style.backgroundColor = COLORS.BLANK;
			myBoard[i][j].setAttribute('onclick','onBlockClick('+(i+1)+','+(j+1)+')');
			
			enemyBoard[i][j].style.backgroundColor = COLORS.BLANK;
		};
	};
};

window.onload = function(){
	setTimeout(addTiles,1000);
};

function createPlayer(){
	if(playerName!=""|playerWins!=0|playerLosses!=0){
		if(!(window.confirm("Are you sure you want to start a new game? All records will be reset!"))){
			return;
		};
	};
	this.playerName = window.prompt("What is your name?");
	this.playerLosses = 0;
	this.playerWins = 0;
};

function startNewGame(){
	if(gameInProgress){
		if(!(window.confirm("Are you sure you want to start a new game? All progress for this game will be lost!"))){
			return;
		}
	};
	this.gameInProgress=true;
};

function onBlockClick(x,y){
	console.log('x:'+x+',y:'+y);
	console.log(typeof x);
	console.log(x);
	myBoard[x-1][y-1].style.backgroundColor=COLORS.MISS;
	myBoard[x-1][y-1].removeAttribute("onclick");
}
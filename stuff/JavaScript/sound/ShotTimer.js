var Trial = function (peakDetector, threshold, onRender, onStart, onStop) {
    this.max_shots = 0;
    this.max_time = 0;
    var href = window.location.href.split('/');
    var beepSrc = window.location.href.replace(href[href.length-1], "") + "Beep.wav";
    var audioLdr = new AudioLoader();
    audioLdr.load(beepSrc);
    
    var _this = this;
    var intervalToken = -1;
    var start = function(){
        audioLdr.playNew(beepSrc);
        console.log('Start!!!');
        preVol = 0;
        time = 0;
        old = false;
        shots = [];
        stopped = false;
        intervalToken = requestAnimationFrame(update);
        _this.onStart();
    };
    
    this.start = function() {
        console.log('start delay');
        setTimeout(start, (this.startDelay + Math.random() * this.randomStartLength) * 1000);
    }
    
    var stopped = true;
    this.stop = function() {
        audioLdr.playNew(beepSrc);
        console.log('Stop!!!');
        cancelAnimationFrame(intervalToken);
        stopped = true;
    };
    
    this.threshold = threshold;
    this.startDelay = 1;
    this.randomStartLength = 1;
    var shots = [];
    this.onRender = onRender;
    this.onStart = onStart;
    this.onStop = onStop;
    
    var preVol = 0;
    var time = 0;
    var old = false;
    function update(now) {
        console.log('tick');
        if(!old) old = now;
        dt = now - old;
        time += dt;
        vol = Math.round(peakDetector.volume * 1000);
        volElem.value = vol;
        if(vol > _this.threshold && prevVol <= _this.threshold) {
            console.log('Shot!');
            shots[shots.length] = time;
        }
        prevVol = vol;
        countElem.value = count;
        old = now;
        _this.onRender(time, shots);
        if(_this.max_time > 0 && time >= _this.max_time) {
            console.log('time limit reached');
            _this.stop();
        }
        if(_this.max_shots > 0 && shots.length >= _this.max_shots) {
            console.log('shot limit reached');
            _this.stop();
        }
        if(!stopped){
            requestAnimationFrame(update);
        } else {
            _this.onStop();
        }
    }
}
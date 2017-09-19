

(function () {
    var PeakSoundDetector = function (context) {
        var that = this;
        var BUFFER_SIZE = 4096;
        
        this.input = context.createGain();
        var output = context.createGain();
        this.volume = 0;
        var scriptNode = context.createScriptProcessor(4096, 1, 1);
        
        scriptNode.onaudioprocess = function(event) {
            var inputData = event.inputBuffer.getChannelData(0);
            var max = 0;
            for(var i = 0; i < inputData.length; i++) {
                if(inputData[i] > max) max = inputData[i];
            }
            that.volume = max;
        }
        
        this.input.connect(scriptNode);
        scriptNode.connect(output);
        
        this.connect = function() {
            output.connect.apply(output, arguments);
        }
        
        this.disconnect = function() {
            output.disconnect.apply(output, arguments);
        }
    }

    var AudioContext = window.AudioContext || window.webkitAudioContext;
    if(AudioContext === undefined) {
        console.error("AudioContext Not Supported");
        return;
    }
    AudioContext.prototype.createPeakSoundDetector = function () {
        return new PeakSoundDetector(this);
    };
})();
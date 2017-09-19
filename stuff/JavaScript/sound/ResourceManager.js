ImageLoader = function () {
    var bind = this;
    var cache = {};
    this.status = {loaded: 0, total: 0};
    this.onReady = function () { };
    
    this.load = function (urls) {
        if (urls instanceof Array) {
            urls.forEach(function (url) {
                bind.load(url);
            });
        } else {
            if (cache[urls]) {
                return;
            }
            
            var img = new Image();
            img.onload = function () {
                cache[urls] = img;
                bind.status.loaded++;
                if (bind.isReady()) {
                    bind.onReady();
                }
            }
            this.status.total++;
            cache[urls] = false;
            img.src = urls;
        }
    }

    this.unload = function (urls) {
        if (urls == null) {
            this.status.loaded = 0;
            this.status.total = 0;
            cache = {};
        } else if (urls instanceof Array) {
            urls.forEach(function (url) {
                if (urls.hasOwnProperty(url)) {
                    bind.unload(url);
                }
            });
        } else {
            this.status.total--;
            this.status.loaded--;
            delete cache[urls];
        }
    }

    this.get = function (url) {
        if (!cache[url]) {
            console.error("Resource not loaded: " + url);
            return new Image();
        }
        return cache[url];
    }

    this.isLoaded = function (url) {
        return !(cache.hasOwnProperty(url) && !cache[url]);
    }

    this.isReady = function () {
        var ready = true;
        for (var url in cache) {
            if (cache.hasOwnProperty(url) && !cache[url]) {
                ready = false;
            }
        }
        return ready;
    }
}

ImageLoader.prototype.constructor = ImageLoader;

AudioLoader = function () {
    this.allPaused = [];
    var paused = false;
    var ids = 0;
    var playing = {};
    var bind = this;
    var ctx = new AudioContext();
    var gainNode = ctx.createGain();
    gainNode.connect(ctx.destination);
    var buffers = {};
    this.getBuffer = function () {
        return buffer;
    };
    this.status = { loaded: 0, total: 0 };
    var loopCallback = function () { };
    this.onReady = function () { };
    this.setVolume = function (vol) {
        gainNode.gain.value = vol / 100;
    }
    this.getVolume = function () {
        return gainNode.gain.value * 100;
    }
    this.dumpPlaying = function() {
        return playing;
    }
    this.setVolume(50);
    this.load = function (urls) {
        if (urls instanceof Array) {
            urls.forEach(function (url) {
                bind.load(url);
            });
        } else {
            if (buffers[urls]) {
                return;
            }
            this.status.total++;
            var request = new XMLHttpRequest();
            request.open('GET', urls, true);
            request.responseType = "arraybuffer";
            request.onload = function () {
                ctx.decodeAudioData(request.response, function (buffer) {
                    if (!buffer) {
                        console.log("error decoding " + urls);
                        delete buffers[urls];
                        num--;
                        return;
                    }
                    bind.status.loaded++;
                    buffers[urls] = buffer;
                    if (bind.isReady()) {
                        bind.onReady();
                    }
                }, function () {
                    console.log("error loading " + urls);
                    delete buffers[urls];
                    bind.status.total--;
                });
            }
            request.onerror = function () {
                bind.status.total--;
                console.log("XHR error loading " + urls);
                console.log(this.status);
            }

            buffers[urls] = false;
            request.send();
        }
    }
    this.unload = function (urls) {
        if (urls == null) {
            this.status.loaded = 0;
            this.status.total = 0;
            buffers = {};
        } else if (urls instanceof Array) {
            urls.forEach(function (url) {
                if (urls.hasOwnProperty(url)) {
                    bind.unload(url);
                }
            });
        } else {
            this.status.loaded--;
            this.status.total--;
            delete buffers[urls];
        }
    }

    this.get = function (url) {
        if (!buffers[url]) {
            console.error("Resource not loaded: " + url);
        }
        return buffers[url];
    }

    this.isLoaded = function (url) {
        return !(buffers.hasOwnProperty(url) && !buffers[url]);
    }

    this.isReady = function () {
        var ready = true;
        for (var url in buffers) {
            if (buffers.hasOwnProperty(url) && !buffers[url]) {
                ready = false;
            }
        }
        return ready;
    }

    var play = function (url, loop, time, id) {
        try {
            var play_id = id;
            if (play_id === null || play_id !== undefined) {
                play_id = ids++;
            }
            var source = ctx.createBufferSource();
            source.buffer = buffers[url];
            source.connect(gainNode);
            source.loop = loop || false;
            source.start(0,time);
            source.onended = function () {
                if (!playing[play_id].paused) {
                    delete playing[play_id];
                }
            };
            playing[play_id] = {
                source: source,
                url: url,
                loop: loop,
                time: time,
                paused: false
            };
            return play_id;
        } catch (e) {
            console.error(e);
            return -1;
        }
    }

    this.playNew = function (url, loop) {
        return play(url, loop, 0, null);;
    }

    this.play = function (id) {
        if (!playing[id]) return;
        if (playing[id].paused) {
            console.log("replay from time: " + playing[id].time);
            return play(playing[id].url,playing[id].loop, playing[id].time, id)
        }
    }

    this.pause = function (id) {
        if (!playing[id]) return;
        if (!playing[id].paused) {
            playing[id].paused = true;
            playing[id].source.disconnect();
            playing[id].source.stop();
        }
    }

    this.stop = function (id) {
        if (!playing[id]) return;
        playing[id].paused = false;
        playing[id].source.stop();
    }

    this.toggle = function (id) {
        if (!playing[id]) return;
        if (playing[id].paused) {
            this.play(id);
        } else {
            this.pause(id);
        }
    }

    this.pauseAll = function () {
        if (paused) return;
        this.allPaused = [];
        paused = true;
        for (var id in playing) {
            if (playing.hasOwnProperty(id)) {
                if (!playing[id].paused) {
                    this.allPaused.push(id);
                    this.pause(id);
                }
            }
        }
    }

    this.resume = function() {
        paused = false;
        this.allPaused.forEach(function (id) {
            this.play(id);
        }, this);
        this.allPaused = [];
    }

    var loop = function (dt) {
        for (var item in playing) {
            if (playing.hasOwnProperty(item)) {
                if (!playing[item].paused) {
                    playing[item].time += dt;
                }
            }
        }

        setTimeout(loop, 100, 100 / 1000);
    }

    loop();
}

AudioLoader.prototype.constructor = AudioLoader;

AudioItem = function (url, context, nodeTree) {
    this.url = url;
    var volume;
    this.setVolume(50);
    var gainNode = context.createGain();
    nodeTree.connect(gainNode);
    
    this.setVolume = function (vol) {
        gainNode.gain.value = vol / 100;
        volume = vol;
    }

    this.getVolume = function (vol) {
        return volume;
    }

    this.getNodeTree = function () {
        return nodeTree;
    }
}
var RiotLifeCycleMixin  = {

    // init method is a special one which can initialize
    // the mixin when it's loaded to the tag and is not
    // accessible from the tag its mixed in
    selfRiotLifeCycleMixin:null,
    init: function() {
        console.log('RiotLifeCycleMixin:init:', this);
        var self=this;
        this.on('before-mount', function() {
            for (var i = 0, len = self._registrants.beforeMount.length; i < len; i++) {
                self._registrants.beforeMount[i]();
            }
        })
        this.on('mount', function() {
            for (var i = 0, len = self._registrants.mount.length; i < len; i++) {
                self._registrants.mount[i]();
            }
        })
        this.on('update', function() {
            for (var i = 0, len = self._registrants.update.length; i < len; i++) {
                self._registrants.update[i]();
            }
        })
        this.on('updated', function() {
            for (var i = 0, len = self._registrants.updated.length; i < len; i++) {
                self._registrants.updated[i]();
            }
        })
        this.on('before-unmount', function() {
            for (var i = 0, len = self._registrants.beforeUnmount.length; i < len; i++) {
                self._registrants.beforeUnmount[i]();
            }
        })
        this.on('unmount', function() {
            for (var i = 0, len = self._registrants.unmount.length; i < len; i++) {
                self._registrants.unmount[i]();
            }
        })

    },
    _registrants:{
        mount:[],
        beforeMount:[],
        update:[],
        updated:[],
        beforeUnmount:[],
        unmount:[]
    },
    registerLifeCycleHandler:function(evtName,handler){
        if(evtName == 'before-mount'){
            this._registrants.beforeMount.push(handler);
            return this;
        }
        if(evtName == 'mount'){
            this._registrants.mount.push(handler);
            return this;
        }
        if(evtName == 'update'){
            this._registrants.update.push(handler);
            return this;
        }
        if(evtName == 'updated'){
            this._registrants.updated.push(handler);
            return this;
        }
        if(evtName == 'before-unmount'){
            this._registrants.beforeUnmount.push(handler);
            return this;
        }
        if(evtName == 'unmount'){
            this._registrants.unmount.push(handler);
            return this;
        }
        return this;
    }
}

if (typeof(module) !== 'undefined') module.exports = RiotLifeCycleMixin;

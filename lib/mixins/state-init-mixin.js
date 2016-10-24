var StateInitMixin  = {
    // init method is a special one which can initialize
    // the mixin when it's loaded to the tag and is not
    // accessible from the tag its mixed in
    init: function() {
        console.log('StateInitMixin:init:',this,this.opts)
        var self = this;
        var opts = self.opts
        if(!opts.name){
            console.error('self.opts.name DOES NOT EXIST')
            console.error('  this tag must be named for the mixin(state-init-mixin) to work')
        }else{
            if(self.onStateInit){
                self.registerObserverableEventHandler(
                    opts.name+'-state-init',
                    self.onStateInit)
            }else{
                console.error('self.onStateInit = () =>{}  DOESN NOT EXIST')
                console.error('  Place it before the mixin:state-init-mixin')
            }
        }

    },
}

if (typeof(module) !== 'undefined') module.exports = StateInitMixin;
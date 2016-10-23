var SharedObservableMixin  = {
    observable: riot.observable(),
    // init method is a special one which can initialize
    // the mixin when it's loaded to the tag and is not
    // accessible from the tag its mixed in

    // This requires that the riot-lifecycle-mixin is mixed in before this one, as this one requires it to register with it.
    init: function() {
        var self = this;
        console.log('SharedObservableMixin:init:',self)
        self.triggerEvent = (evt,args) =>{
            args.unshift(evt);
            self.observable.trigger.apply(self,args);
        }
    }
}

if (typeof(module) !== 'undefined') module.exports = SharedObservableMixin;


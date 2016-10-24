<simple-input>

    <i if={opts.materialIcon} class="material-icons prefix">{opts.materialIcon}</i>
    <input
            type="text" class="validate"
            oninput = { onRChange }
            onchange = { onRChange }
            onkeypress = { onKeyPress }
            name='r' >
    <label>{opts.label}</label>

    <style>

    </style>
    <script>
        /*
         <simple-input
            value={myStringValue}
            min-length=4
            label="My Label"
         ></simple-input>
         */
        var self = this;
        self.mixin("opts-mixin");
        self.mixin("shared-observable-mixin");
        self._isValid = false;

        self.validateInput = (force) =>{

            var temp = opts.value.length>= opts.minLength
            if(temp != self._isValid){
                self._isValid = temp
                force = true;
            }
            if(force){
                self.triggerEvent(opts.name+'-valid',[self._isValid]);
            }
        }

        self.onRChange = function(e) {
            var rValue = self.r.value
            opts.value = rValue
            self.validateInput(false);
        }

        self.onKeyPress = function(e) {
            if(!e)
                e=window.event;
            var keyCode = e.keyCode || e.which;
            if(keyCode== 13){
                event.preventDefault();
                if(self._isValid){
                    self.triggerEvent(opts.name+'-enter',[self._isValid]);
                }
                return false;
            }else{
                return true;
            }
        }
        self.on('mount',function(){
            self.validateInput(true)
        })
    </script>
</simple-input>
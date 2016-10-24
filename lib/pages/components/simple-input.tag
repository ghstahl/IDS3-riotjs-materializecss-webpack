<simple-input>

    <i if={opts.materialIcon} class="material-icons prefix">{opts.materialIcon}</i>
    <input
            type="text" class="validate"
            oninput = { onRChange }
            onchange = { onRChange }
            onkeypress = { onKeyPress }
            name='r'
    ><span if={!_isValid } class="badge">{lengthCounter} more required</span>
    <label>{opts.label}</label>


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

        self.showBadge = true;
        self.lengthCounter = opts.minLength;
        self._isValid = false;

        self.onStateInit = (state) =>{
            opts.state = state
            self.r.value = opts.state.value
            self.validateInput(true)
            self.update()
        }

        self.validateInput = (force) =>{
            var temp = opts.state.value.length>= opts.minLength
            if(temp != self._isValid){
                self._isValid = temp
                force = true;
            }
            if(force){
                self.triggerEvent(opts.name+'-valid',[self._isValid]);
            }
            self.lengthCounter = opts.minLength - opts.state.value.length
        }


        self.onRChange = function(e) {
            var rValue = self.r.value
            opts.state.value = rValue
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

        // place mixins here that require stuff to already exist.
        self.mixin("state-init-mixin");
    </script>

</simple-input>


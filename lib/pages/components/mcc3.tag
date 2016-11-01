import './stepper-panel.tag'
<mcc3>
    <stepper-panel>
        <yield to="body">
            <form action="#">
                <p>
                    <input type="checkbox" id="sure"
                           checked={!parent.disabled}
                           onchange = { parent.toggleSureOnChange }
                    />
                    <label for="sure">Are you sure?</label>
                </p>
            </form>

            <div class="progress">
                <div class="determinate" style="width: {parent.progressValue}%"></div>
            </div>
        </yield>
        <yield to="footer">
            <a class="waves-effect waves-light btn {parent.state.state.cssDone}"
               disabled={parent.state.state.disabled}
               onclick={parent.onAgree}>Agree</a>
        </yield>
    </stepper-panel>
    <style scoped>
        .mcc3-done {
            color: #9e9e9e;
            pointer-events: none;
        }
        .eula {
            overflow-y: auto;
            max-height: 310px;
        }

        textarea.materialize-textarea {
            max-height: 3rem;
            border: 2px solid black;
        }

        .progress {
            height: 2px;
        }
    </style>

    <script>
        var self = this;
        self.mixin("opts-mixin");
        self.mixin("shared-observable-mixin");
        self.state = {}
        self.progressValue = 0;

        self.disabled = true;

        self.on('mount',function(){
            self.state = opts.state
            console.log('mount:mcc3',opts,self.state)
            self.update()
        })
        self.toggleSureOnChange = (e) =>{
            var disabled = !e.target.checked
            self.progressValue = disabled?0:100;
            self.state.state.disabled = disabled;
            self.update();
        }

        self.onAgree = () =>{
            self.state.state.cssDone = "mcc3-done";
            self.state.state.disabled = true;
        }

        self.onStateInit = (state) =>{
            self.state = state;

            console.log('mcc3: onStateInit',self.state)
            self.markdown = self.state.state.eula
            self.state.state.disabled = true;
            self.state.state.eulaAgreed = "";
            self.update();
        }
        // place mixins here that require stuff to already exist.
        self.mixin("state-init-mixin");

    </script>
</mcc3>

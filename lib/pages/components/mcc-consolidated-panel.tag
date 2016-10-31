import './stepper-panel.tag'
import './consolidated-form-inner.tag'

<mcc-consolidated-panel>
    <stepper-panel>
        <yield to="body">
            <consolidated-form-inner name={parent.cfiName} state={parent.state.cftState}></consolidated-form-inner>
       </yield>
        <yield to="footer">
            <a class="waves-effect waves-light btn {parent.state.cftState.disabledState}"
               disabled ={parent.state.cftState.disabled}
               onclick={parent.onSubmit}>Next</a>
        </yield>
    </stepper-panel>
    <style scoped>

        textarea.materialize-textarea {
            max-height: 3rem;
            border: 2px solid black;
        }
        .disabled-state {
            pointer-events: none;
        }
        .progress {
            height: 2px;
        }

    </style>
    <script>
        var self = this;
        self.cfiName = opts.name +"-cft";

        self.mixin("opts-mixin");
        self.mixin("shared-observable-mixin");
        self.state = {};


        self.on('mount',function(){
            console.log('mcc-consolidated-panel mount',self,opts.name,opts.state);
            self.state = opts.state
            self.state.cftState.disabled = true;
            self.state.cftState.disabledState = "disabled-state";

            self.triggerEvent(self.cfiName + '-state-init',[self.state.cftState]);
            self.update()
        })

        self.onSubmit = (e) =>{
            console.log('mcc-consolidated-panel stepContinue',e.item);
            self.state.cftState.disabled = true
            self.state.cftState.disabledState = "disabled-state"
            self.triggerEvent(opts.name+'-continue')
        }

        self.onStateInit = (state) =>{
            self.state = state;
            console.log('mcc-consolidated-panel-state-init: onStateInit',self.state)
            self.triggerEvent(self.cfiName + '-state-init',[self.state.cftState]);
            self.update();
        }

        self.onCFTValid = (valid) =>{
            self.state.cftState.disabled = !valid;
            self.state.cftState.disabledState = valid==true?"":"disabled-state";
            self.update();
        }

        self.registerObserverableEventHandler(
                self.cfiName + '-valid',
                self.onCFTValid)

        // place mixins here that require stuff to already exist.
        self.mixin("state-init-mixin");
    </script>
</mcc-consolidated-panel>

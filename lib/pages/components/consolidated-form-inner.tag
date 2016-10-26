import './dd-form-card.tag'
import './simple-input.tag'
import './simple-select.tag'

<consolidated-form-inner>

    <div class="row">
        <div class="input-field col s6">
            <simple-input
                    name={frientlyNameSeed}
                    state={friendlyNameState}
                    min-length=4
                    label="Friendly Client Name"
            ></simple-input>
        </div>
        <div class="input-field col s6">
            <simple-select
                    name={flowTypeSeed}
                    state={flowState}
                    items={flowItems}
                    prompt="Select Flow..."
                    label="Flow"
            ></simple-select>
        </div>
    </div>
    <dd-form-card name={ddSeedName} ></dd-form-card>

    <div class="progress">
        <div class="determinate" style="width: {validProgress}%"></div>
    </div>


    <style></style>
    <script>
        var self = this;
        self.mixin("opts-mixin");
        self.mixin("shared-observable-mixin");

        self.friendlyNameState = {value:''}
        self.flowState = {}

        self.isFormValid = false;
        self.validProgress = 0;
        self.validFriendlyName = false;
        self.ddSeedName = opts.name + "-assign-scopes";
        self.ddChangedEvt = self.ddSeedName+"-target-changed";

        self.frientlyNameSeed = opts.name + "-friendly-name";
        self.flowTypeSeed = opts.name + "-flow-type";


        self.flowItems = [
            {name:'Resource Owner'},
            {name:'Client Credentials'},
        ]

        self.ddState =  {
            dragTarget:{
                title:"Assigned Scopes",
                titleSecondary:"Drag granted scopes here...",
                data:[],
            },
            dragSource:{
                title:"Granted Scopes",
                titleSecondary:"Drag granted scopes from here...",
                data:[
                    { name: 'offline_access' },
                    { name: 'api1' },
                    { name: 'geo_location' }
                ]
            },
        }

        self.onStateInit = (state) =>{
            self.state = state;
            self.ddState.dragTarget.data = state.scopes;
            self.triggerEvent(self.ddSeedName + '-state-init',[
                self.ddState
            ]);
            self.friendlyNameState = {value:self.state.friendlyName}
            self.triggerEvent(self.frientlyNameSeed + '-state-init',[self.friendlyNameState]);
            self.doValidationCheck(true)
        }

        self.onSubmit = function() {
            if(self.isFormValid == true){
                console.log('onSubmit',self.lastRole)

                var state = {
                    friendlyName:self.friendlyNameState.value,
                    scopes:self.ddState.dragTarget.data,
                    flowType:self.flowState.selected
                }
                self.triggerEvent(opts.name+'-submit',[state]);
            }
        }

        self.doValidationCheck = (force) =>
        {
            force = force === undefined?false:force;
            var temp =
                    self.validFriendlyName &&
                    self.ddState.dragTarget.data.length > 0 &&
                    self.flowState.selected !== undefined;

            if(temp != self.isFormValid){
                self.isFormValid = temp
                force = true;
            }

            if (self.isFormValid) {
                self.validProgress = 100
            } else {
                var percent = 0;
                percent += self.validFriendlyName ? 33 : 0;
                percent += (self.ddState.dragTarget.data.length > 0) ? 33 : 0;
                percent += (self.flowState.selected !== undefined ) ? 33 : 0;
                self.validProgress = percent;
            }
            self.update()
            opts.state.ddState = self.ddState;
            opts.state.flowState = self.flowState;
            opts.state.friendlyNameState = self.friendlyNameState;
            if(force){
                self.triggerEvent(self.opts.name+'-valid',[self.isFormValid]);
            }
        }

        self.onAssignScopesTargetChanged = () =>{
            console.log(self.ddChangedEvt,self.ddState.dragTarget)
            self.doValidationCheck()
        }


        self.onFriendlyNameValid = (valid) =>{
            console.log(self.frientlyNameSeed+"-valid",self.friendlyNameState,valid)
            self.validFriendlyName = valid;
            self.doValidationCheck()
        }

        self.onFlowTypeChanged = (state) =>{
            console.log(self.flowTypeSeed + '-changed',state,self.flowState)
            self.doValidationCheck()
        }
        self.registerObserverableEventHandler(
                self.ddChangedEvt,
                self.onAssignScopesTargetChanged)

        self.registerObserverableEventHandler(
                self.frientlyNameSeed + '-valid',
                self.onFriendlyNameValid)

        self.registerObserverableEventHandler(
                self.flowTypeSeed + '-changed',
                self.onFlowTypeChanged)

        // place mixins here that require stuff to already exist.
        self.mixin("state-init-mixin");
    </script>
</consolidated-form-inner>
import './consolidated-form-inner.tag'

import './dd-form-card.tag'
import './simple-input.tag'
import './simple-select.tag'

<consolidated-form-test>
    <form>
        <div class="card">
            <div class="card-content">
                <span class="card-title">My Consolidated Form</span>
                <div class="row">
                    <div class="input-field col s6">
                        <simple-input
                                name="friendly-name"
                                state={friendlyNameState}
                                min-length=4
                                label="Friendly Client Name"
                        ></simple-input>
                    </div>
                    <div class="input-field col s6">
                        <simple-select
                                name="flow-type"
                                state={flowState}
                                items={flowItems}
                                prompt="Select Flow..."
                                label="Flow"
                        ></simple-select>
                    </div>
                </div>
                <dd-form-card name={ddSeedName} ></dd-form-card>
            </div>
            <div class="card-action">
                <div class="progress">
                    <div class="determinate" style="width: {validProgress}%"></div>
                </div>
                <a class="waves-effect waves-light btn"
                   disabled={ !isFormValid }
                   onclick={onSubmit}
                >
                    Sumbit
                </a>
            </div>
        </div>
    </form>

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
        self.ddSeedName = opts.name+"-assign-scopes";
        self.ddChangedEvt = self.ddSeedName+"-target-changed";


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
            self.triggerEvent('friendly-name-state-init',[self.friendlyNameState]);
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

        self.doValidationCheck = () =>
        {
            self.isFormValid =
                    self.validFriendlyName &&
                    self.ddState.dragTarget.data.length > 0 &&
                    self.flowState.selected !== undefined;
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
        }

        self.onAssignScopesTargetChanged = () =>{
            console.log(self.ddChangedEvt,self.ddState.dragTarget)
            self.doValidationCheck()
        }

        self.onFriendlyNameValid = (valid) =>{
            console.log('friendly-name-valid',self.friendlyNameState,valid)
            self.validFriendlyName = valid;
            self.doValidationCheck()
        }

        self.onFlowTypeChanged = (state) =>{
            console.log('flow-type-changed',state,self.flowState)
            self.doValidationCheck()
        }

        self.registerObserverableEventHandler(
                self.ddChangedEvt,
                self.onAssignScopesTargetChanged)

        self.registerObserverableEventHandler(
                'friendly-name-valid',
                self.onFriendlyNameValid)

        self.registerObserverableEventHandler(
                'flow-type-changed',
                self.onFlowTypeChanged)

        // place mixins here that require stuff to already exist.
        self.mixin("state-init-mixin");
    </script>
</consolidated-form-test>

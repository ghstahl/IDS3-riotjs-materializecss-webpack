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
                <a class="waves-effect waves-light btn"
                   disabled={ !isFormValid }
                   onclick={onSubmit}
                >
                    Sumbit
                </a>
                <a class="waves-effect waves-light btn">Cancel</a>
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
        self.validFriendlyName = false;
        self.ddSeedName = "cft-assign-scopes";
        self.ddChangedEvt = self.ddSeedName+"-target-changed";

        self.flowItems = [
            {name:'Resource Owner'},
            {name:'Client Credentials'},
        ]


        self.dragSource = {
            title:"Granted Scopes",
            titleSecondary:"Drag granted scopes from here...",
            data:[
                { name: 'offline_access' },
                { name: 'api1' },
                { name: 'geo_location' }
            ]
        }
        self.dragTarget = {
            title:"Assigned Scopes",
            titleSecondary:"Drag granted scopes here...",
            data:[],
        }

        self.onStateInit = (state) =>{
            self.state = state;
            self.dragTarget.data = state.scopes;
            self.triggerEvent(self.ddSeedName + '-state-init',[
                    {
                        dragTarget:self.dragTarget,
                        dragSource:self.dragSource,
                    }
            ]);
            var state = {value:self.state.friendlyName}
            self.triggerEvent('friendly-name-state-init',[state]);
        }

        self.onSubmit = function() {
            if(self.isFormValid == true){
                console.log('onSubmit',self.lastRole)

                var state = {
                    friendlyName:self.friendlyNameState.value,
                    scopes:self.dragTarget.data,
                    flowType:self.flowState.selected
                }
                self.triggerEvent(opts.name+'-submit',[state]);
            }
        }

        self.doValidationCheck = () =>{
            self.isFormValid =  self.validFriendlyName &&
                                self.dragTarget.data.length > 0 &&
                                self.flowState.selected !== undefined;
            self.update()
        }

        self.onAssignScopesTargetChanged = () =>{
            console.log(self.ddChangedEvt,self.dragTarget)
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


import './dd-form-card.tag'
import './simple-input.tag'
import './simple-select.tag'
<consolidated-form-test>

    <form class="col s12" >
        <div class="row">
            <div class="input-field col s6">
                <simple-input
                        name="friendly-name"
                        value={myStringValue}
                        min-length=4
                        label="Friendly Client Name"

                ></simple-input>
            </div>
            <div class="input-field col s6">

            </div>
        </div>
    </form>
    <dd-form-card name={ddSeedName} drag-target={dragTarget} drag-source={dragSource} ></dd-form-card>

    <style></style>
    <script>

        var self = this;
        self.mixin("opts-mixin");
        self.mixin("shared-observable-mixin");

        self.ddSeedName = "cft-assign-scopes";
        self.ddChangedEvt = self.ddSeedName+"-target-changed";
        self.flowType = null
        self.flowItems = [
            {name:'Resource Owner'},
            {name:'Client Credentials'},
        ]

        self.myStringValue = ""
        self.dragSource = {
            title:"Granted Scopes",
            titleSecondary:"Drag granted scopes from here...",
            data:[
                { name: 'offline_access' },
                { name: 'api1' },
                { name: 'geo_location' }
            ]
        }
        self.dragTarget= {
            title:"Assigned Scopes",
            titleSecondary:"Drag granted scopes here...",
            data:[],
        }
        self.onAssignScopesTargetChanged = () =>{
            console.log(self.ddChangedEvt,self.dragTarget)
        }
        self.onFriendlyNameValid = (valid) =>{
            console.log('friendly-name-valid',self.myStringValue,valid)
        }
        self.onFlowTypeChanged = () =>{
            console.log('flow-type-changed',self.flowType)
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



    </script>
</consolidated-form-test>
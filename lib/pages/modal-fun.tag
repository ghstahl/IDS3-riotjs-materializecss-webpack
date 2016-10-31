import RiotControl from 'riotcontrol';
import './components/consolidated-form-inner.tag'
import './components/stepper.tag'
import './components/mcc1.tag'
import './components/mcc2.tag'
import './components/mcc3.tag'
import './components/mcc-consolidated-panel.tag'

<modal-fun>
    <div class="section">
        <div class="container">
            <a class="waves-effect waves-light btn"
               onclick={onOpenClose}>Agree/Disagree</a>
            <a class="waves-effect waves-light btn"
               onclick={onOpenClose2}>Consolidated</a>
        </div>
    </div>
    <div class="section">
        <p>{output}</p>
    </div>


    <!-- Modal Structure -->
    <div id="modal1" class="modal">
        <div class="modal-content">
            <h4>Company EULA</h4>
            <p>…you give Google a perpetual, irrevocable, worldwide, royalty-free, and non-exclusive license to reproduce, adapt, modify, translate, publish, publicly perform, publicly display and distribute any Content which you submit, post or display on or through, the Services.</p>
        </div>
        <div class="modal-footer">
            <a class=" modal-action modal-close waves-effect waves-green btn-flat">Cancel</a>
            <a onclick={onAgree} class=" modal-action waves-effect waves-green btn-flat">Agree</a>
        </div>
    </div>

    <!-- Modal Structure -->
    <div id="modal2" class="modal">
        <div class="modal-content">
            <h4>Consolidated Form</h4>
            <consolidated-form-inner name="cft" state={cftInnerState}></consolidated-form-inner>
        </div>


        <div class="modal-footer">
            <a class="modal-action modal-close waves-effect waves-green btn">Cancel</a>
            <a onclick={onCFTSubmit}
               disabled={formDisabled}
               class="waves-effect waves-green btn-flat" >Submit</a>
        </div>
    </div>

    <stepper name="cc-stepper" state={ccStepperState}></stepper>

    <style scoped>
        .modal { width: 75% !important ; max-height: 100% !important ; overflow-y: hidden !important ;}
    </style>
    <script>
        var self = this
        self.mixin("shared-observable-mixin");
        self.mixin("riotcontrol-registration-mixin");

        self.ccStepperState = {}

        self.stepState = {
            step1: {
                id:1,
                invalid:"invalid",
                name:'mcc1',
                tag:'mcc1',
                title: 'Soogle Company End User License Agreement',
                description:'Accept our EULA or we will Soogle you!',
                active: '',
                step:{
                    primary:true,
                },
                contentHide:'',
                custom:{
                    eula:"placeholder"
                }
            },
            step2: {
                id:2,
                invalid:"invalid",
                name:'mcc-consolidated-panel',
                tag:'mcc-consolidated-panel',
                title: 'Consolidated',
                description:'Consolidate this.',
                active: 'inactive',
                 step:{
                 primary:false,
                 },
                contentHide:'content-hide',
                cftState:{},
            },
            step3: {
                id:3,
                invalid:"invalid",
                name:'mcc3',
                tag:'mcc3',
                title: 'step_3',
                description:'description step_3',
                active: 'inactive',
                step:{
                    primary:false,
                },
                contentHide:'content-hide',
            },
        }



        self.cftState = {
            friendlyName:"Some Friendly Name",
            scopes:[]
        }

        self.formDisabled = true;

        self.onEulaFetch = (result) =>{
            self.stepState.step1.custom.eula = result
            self.triggerEvent('mcc1-state-init',[self.ccStepperState.step1]);
        }

        self.on('before-mount',function(){
            self.initCFTState()
        })

        self.on('mount',function(){
            var url = "https://raw.githubusercontent.com/ghstahl/IDS3-riotjs-materializecss-webpack/master/eula.md";
            RiotControl.trigger('fetch-text',url,null,{name:'eula-fetched'});
            self.triggerEvent('cft-state-init',[self.cftState]);
            self.ccStepperState = self.stepState;
            self.triggerEvent('cc-stepper-state-init',[self.ccStepperState]);

            for (var key in self.ccStepperState) {
                var current = self.stepState[key];
                // fan out
                self.triggerEvent(current.name + '-state-init', [current]);
            }
        })


        self.initCFTState = () => {
            var cftState = {
                friendlyName:"Some Friendly Name",
                scopes:[]
            }
            self.cftState = cftState;
            var cftState2 = {
                friendlyName:"Some Friendly Name2",
                scopes:[]
            }
            self.stepState.step2.cftState = cftState2;
        }

        self.onOpenClose = () =>{
            console.log('onEULA')
            $("#modal1").openModal({
                dismissible: false
            })
        }

        self.onAgree = () =>{
            console.log('onAgree');
            $("#modal1").closeModal()
        }

        self.onOpenClose2 = () =>{
            console.log('onEULA')
            $("#modal2").openModal({
                dismissible: false
            })
        }

        self.onAgree2 = () =>{
            console.log('onAgree');
            $("#modal2").closeModal()
        }

        self.onCFTValid = (valid) =>{
            console.log('cft-valid',self.cftInnerState,valid)
            self.formDisabled = !valid;
            self.update()
        }

        self.onCFTSubmit = (state) =>{
            console.log('onCFTSubmit',state)
            if(!self.formDisabled){
                self.output =  self.jsFriendlyJSONStringify(self.cftInnerState);

                self.initCFTState()
        //        self.triggerEvent('cft-state-init',[self.cftState]);
                self.update()
                $("#modal2").closeModal()
            }
        }

        self.onMccContinue = ( ) =>{
            console.log('mcc1-continue')
            self.triggerEvent('cc-stepper-next')
        }

        for (var key in self.stepState) {
            var current = self.stepState[key]
            self.registerObserverableEventHandler(
                    current.name + '-continue',
                    self.onMccContinue)
        }

        self.registerObserverableEventHandler(
                'cft-submit',
                self.onCFTSubmit)

        self.registerObserverableEventHandler(
                'cft-valid',
                self.onCFTValid)

        self.jsFriendlyJSONStringify = (s)=> {
            return JSON.stringify(s,null, ' ').
                    replace(/\u2028/g, '\\u2028').
                    replace(/\u2029/g, '\\u2029');
        }
        self.riotControlRegisterEventHandler('eula-fetched',self.onEulaFetch)

    </script>

</modal-fun>
import RiotControl from 'riotcontrol';
import './components/consolidated-form-inner.tag'
import './components/stepper.tag'
import './components/mcc1.tag'
import './components/mcc2.tag'
import './components/mcc3.tag'

<modal-fun>
    <div class="section">
        <div class="container">
            <a class="waves-effect waves-light btn"
               onclick={onOpenClose}>Agree/Diasagree</a>
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
            <h4>Company EULA</h4>
            <consolidated-form-inner name="cft" state={cftInnerState}></consolidated-form-inner>
        </div>


        <div class="modal-footer">
            <a class="modal-action modal-close waves-effect waves-green btn">Cancel</a>
            <a onclick={onCFTSubmit}
               disabled={formDisabled}
               class="waves-effect waves-green btn-flat" >Submit</a>
        </div>
    </div>

    <stepper name="cc" state={ccStepperState}></stepper>

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
                name:'mcc1',
                tag:'mcc1',
                title: 'Soogle Company End User License Agreement',
                description:'Accept our EULA or we will Soogle you!',
                active: '',
                contentHide:'',
                custom:{
                    eula:"We are constantly changing and improving our Services. We may add or remove functionalities or features, and we may suspend or stop a Service altogether.\nYou can stop using our Services at any time, although we’ll be sorry to see you go. Google may also stop providing Services to you, or add or create new limits to our Services at any time.\nWe believe that you own your data and preserving your access to such data is important. If we discontinue a Service, where reasonably possible, we will give you reasonable advance notice and a chance to get information out of that Service.\n…you give Google a perpetual, irrevocable, worldwide, royalty-free, and non-exclusive license to reproduce, adapt, modify, translate, publish, publicly perform, publicly display and distribute any Content which you submit, post or display on or through, the Services."
                }
            },
            step2: {
                id:2,
                name:'mcc2',
                tag:'mcc2',
                title: 'step_2',
                description:'description step_2',
                active: 'inactive',
                contentHide:'content-hide',
            },
            step3: {
                id:3,
                name:'mcc3',
                tag:'mcc3',
                title: 'step_3',
                description:'description step_3',
                active: 'inactive',
                contentHide:'content-hide',
            },
        }



        self.cftState = {
            friendlyName:"Some Friendly Name",
            scopes:[]
        }
        self.cftInnerState = {}
        self.formDisabled = true;

        self.onEulaFetch = (result) =>{
            console.log('eula-fetched',result)
            self.stepState.step1.custom.eula = result
            self.triggerEvent('mcc1-state-init',[self.ccStepperState.step1]);
        }

        self.on('mount',function(){
            self.initCFTState()
            var url = "https://raw.githubusercontent.com/ghstahl/IDS3-riotjs-materializecss-webpack/master/eula.md";
            RiotControl.trigger('fetch-text',url,null,{name:'eula-fetched'});
            self.triggerEvent('cft-state-init',[self.cftState]);
            self.ccStepperState = self.stepState;
            self.triggerEvent('cc-state-init',[self.ccStepperState]);
        })

        self.initCFTState = () => {
            var cftState = {
                friendlyName:"Some Friendly Name",
                scopes:[]
            }
            self.cftState = cftState;
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
                self.triggerEvent('cft-state-init',[self.cftState]);
                self.update()
                $("#modal2").closeModal()
            }
        }

        self.onMccContinue = ( ) =>{
            console.log('mcc1-continue')
            self.triggerEvent('cc-next')
        }

        self.registerObserverableEventHandler(
                'mcc1-continue',
                self.onMccContinue)

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
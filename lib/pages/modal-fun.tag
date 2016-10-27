import './components/consolidated-form-inner.tag'
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
            <a

                    onclick={onCFTSubmit}
               disabled={formDisabled}
               class="waves-effect waves-green btn-flat" >Submit</a>
        </div>
    </div>



    <style>
        .modal { width: 75% !important ; max-height: 100% !important ; overflow-y: hidden !important ;}
    </style>
    <script>
        var self = this
        self.mixin("shared-observable-mixin");

        self.cftState = {
            friendlyName:"Some Friendly Name",
            scopes:[]
        }
        self.cftInnerState = {}
        self.formDisabled = true;

        self.on('mount',function(){
            self.initCFTState()
            self.triggerEvent('cft-state-init',[self.cftState]);
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

    </script>

</modal-fun>
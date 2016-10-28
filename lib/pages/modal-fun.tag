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

    <div class="stepper">
        <div class="step {stepSate.step1.active}">
            <div>
                <div class="circle">1</div>
                <div class="line"></div>
            </div>
            <div>
                <div class="title">Title 123</div>
                <div class="description">Description</div>
                <div class="body">
                    {output}
                </div>
                <a class="waves-effect waves-light btn"
                   onclick={onOpenClose}>Agree/Diasagree</a>
            </div>

        </div>
        <div class="step {stepSate.step2.active}">
            <div>
                <div class="circle">2</div>
                <div class="line"></div>
            </div>
            <div>
                <div class="title">Title 12345 1</div>
                <div class="body">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</div>
            </div>
        </div>
        <div class="step {stepSate.step3.active}">
            <div>
                <div class="circle">2</div>
                <div class="line"></div>
            </div>
            <div>
                <div class="title">Title 12345 1</div>
                <div class="body">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</div>
            </div>
        </div>
    </div>

    <style scoped>
        .modal { width: 75% !important ; max-height: 100% !important ; overflow-y: hidden !important ;}

        .stepper .step {
            position: relative;
            min-height: 32px;
            padding: 24px;
        }
        .stepper .step:hover {
            background: #F6F6F6;
        }
        .stepper .step > div:first-child {
            position: static; height: 0;
        }
        .stepper .step > div:last-child {
            margin-left: 32px;
            padding-left: 16px;
            min-height: 24px;
        }
        .stepper .circle {
            background: #4285f4;
            width: 32px;
            height: 32px;
            line-height: 32px;
            border-radius: 16px;
            position: relative;
            color: white;
            text-align: center;
        }
        .stepper .line {
            position: absolute;
            border-left: 1px solid gainsboro;
            left: 40px;
            bottom: -12px;
            top: 68px;
            z-index: 1;
        }
        .stepper .step:last-child .line {
            display: none !important;
        }
        .stepper .title {
            line-height: 32px;
            font-weight: 500;
        }
        .stepper .body {
            padding-bottom: 28px;
            padding-top: 8px;
        }
        .stepper .description {
            line-height: 0.1;
            font-size: 1em;
            padding-bottom: 24px;
            color: #989898;
        }
        /** Horizontal **/
        .stepper.horizontal {
            line-height: 72px;
            position: relative;
        }
        .stepper.horizontal .step {
            display: inline-block;
        }
        .stepper.horizontal .step .line, .stepper.horizontal .step .circle, .stepper.horizontal .step .title {
            display: inline-block;
        }
        .stepper.horizontal .step .line {
            border-left: 0px;
            position: inherit;
            border-top: 1px solid gainsboro;
            width: 100px;
            margin-bottom: 5px;
            margin-left: 8px;
            margin-right: 8px;
        }
        .stepper.horizontal .step .title {
            margin-left: 8px;
        }
        .stepper.horizontal .step .body {
            line-height: initial;
        }
        .stepper.horizontal .step > div:last-child {
            position: absolute;
            width: 90vw;
            top: 93px;
            margin-left: 0px;
            padding-left: 0px;
            margin: auto;
        }
        .stepper .step.inactive .title{
            color: #C9C9C9;
            font-weight: 400;
        }
        .stepper .step.inactive .body{
            display: none;
        }
        .stepper .step.inactive .circle{
            background-color: #9e9e9e;
        }

    </style>
    <script>
        var self = this
        self.mixin("shared-observable-mixin");
        self.stepSate = {
            step1:{
                active:""
            },
            step2:{
                active:"inactive"
            },
            step3:{
                active:""
            },

        }
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
            self.stepSate.step2.active=""
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
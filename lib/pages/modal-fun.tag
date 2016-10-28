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
        <div each={key in stepSate} class="step {stepSate[key].active}">

            <div>
                <a class="btn-floating btn-small waves-effect waves-light circle2">{stepSate[key].id}</a>
                <div class="line"></div>
            </div>
            <div>
                <div class="title">{stepSate[key].title}</div>
                <div class="description">{stepSate[key].description}</div>
                <div class="line-separator"></div>
                <div class="body">
                    {output}
                </div>
                <div class="footer">
                    <a class="waves-effect waves-light btn"
                       onclick={stepContinue}>Continue:{id}</a>
                </div>
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
        .stepper .circle2 {
            color: white;
            background: #4285f4;
            text-align: center;
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
            left: 41px;
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
            padding-bottom: 12px;
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
        .stepper .step.inactive .footer{
            display: none;
        }
        .stepper .step .line-separator{
            border-bottom:1px solid gainsboro;

        }
        .stepper .step .footer{
            border-top:1px solid gainsboro;
            padding-top: 4px;
        }
        .stepper .step .footer .btn, .stepper .step .footer .btn-large, .stepper .step .footer .btn-flat {
            float: right;
            margin: 6px 0;
        }


        .stepper .step.inactive .circle{
            background-color: #9e9e9e;
        }
        .stepper .step.inactive .circle2{
            background-color: #9e9e9e;
            pointer-events: none;
        }
        .stepper .step.toggleHidden .body{
            display: none;
        }

    </style>
    <script>
        var self = this
        self.mixin("shared-observable-mixin");
        self.stepSate = {
            step1: {
                id:1,
                title: 'step_1',
                description:'description step_1',
                active: ''
            },
            step2: {
                id:2,
                title: 'step_2',
                description:'description step_2',
                active: 'inactive'
            },
            step3: {
                id:3,
                title: 'step_3',
                description:'description step_3',
                active: 'inactive'
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

        self.stepContinue = (e) =>{
            console.log('stepContinue',e.item);
            console.log(self.stepSate[e.item.key])
            var current = self.stepSate[e.item.key]
            var next = self.stepSate["step"+(current.id +1)]
            next.active = ""
            $("#modal1").closeModal()
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
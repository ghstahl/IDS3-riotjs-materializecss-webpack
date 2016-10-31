<stepper-raw-content>
    <script>
        var self = this
        riot.mount(this.root, opts.content.state.tag, opts.content)
    </script>
</stepper-raw-content>

<stepper>

    <div class="stepper">
        <div each={key in stepperData}
             class="step {stepperData[key].state.active} {stepperData[key].state.contentHide} {stepperData[key].state.invalid}">

            <div>
                <a class="btn-floating btn-small waves-effect waves-light circle2"
                   onclick={toggleStepExpand}>{stepperData[key].state.id}</a>
                <i class="material-icons circle3">done</i>
                <div class="line"></div>
                <div class="line-hover"></div>
            </div>
            <div >
                <div class="title">{stepperData[key].state.title}</div>
                <div class="description">{stepperData[key].state.description}</div>
                <div class="line-separator"></div>
                <div class="body">
                    <stepper-raw-content id={parent.stepperData[key].state.rawId}
                                         content="{parent.stepperData[key]}"></stepper-raw-content>
                </div>
            </div>
        </div>
    </div>

    <style scoped>
        .stepper .step {
            position: relative;
            min-height: 32px;
            padding: 24px;
        }
        .stepper .step:hover .line-hover {
            background: #F6F6F6;
            border-left: 1px solid black;
            position: absolute;
            left: 41px;
            bottom: -12px;
            width: 12px;
            top: 68px;
            z-index: 1;
        }
        .stepper .step.inactive:hover .line-hover {
            display: none !important;
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
        .stepper .circle3 {
            float: right;
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
            padding-bottom: 0px;
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
        .stepper .step.inactive .body,.stepper .step.content-hide .body{
            display: none;
        }
        .stepper .step.inactive .footer,.stepper .step.content-hide .footer{
            display: none;
        }

        .stepper .step .line-separator{
            border-bottom:1px solid gainsboro;

        }
        .stepper .step .footer{
            /*
            border-top:1px solid gainsboro;
            padding-top: 4px;*/
        }
        .stepper .step .footer .btn, .stepper .step .footer .btn-large, .stepper .step .footer .btn-flat {
            float: right;
            margin: 6px 0;
        }

        .stepper .step.invalid .circle3{
            display: none;
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
        var self = this;

        self.mixin("opts-mixin");

        self.mixin("shared-observable-mixin");

        self.stepState = self.opts.state;
        self.stepperData = {}

        self.on('mount', function() {
            var stepperData = {}
            for (var key in self.stepState) {
                var current = self.stepState[key]
                current.rawId = current.name + "-raw-id"
                stepperData[key] = {state:current,name:current.name}
            }
            self.stepperData = stepperData
            self.update();
        })

        self.on('unmount', function() {
            console.log('unmount: stepper');
            for (var key in self.stepState) {
                var current = self.stepState[key]
                var elm = self[current.rawId]
                elm._tag.unmount()
            }
        })

        self._toggleString = (current,s1,s2) =>{
            if(current === undefined)
                return s1
            if(current === s1)
                return s2
            return s1
        }

        self.onNext = () =>{
            console.log('onNext')
            for (var key in self.stepState) {
                var current = self.stepState[key]
                current.contentHide = "content-hide"
                current.step.primary = false
                current.invalid = ""
                if(current.active ==="inactive"){
                    current.invalid = "invalid"
                    current.step.primary = true
                    current.active = ""
                    current.contentHide = ""
                    break;
                }
            }
            self.update()
        }

        self.toggleStepExpand = (e) =>{
            console.log('toggleStepExpand',e.item);
            var current = self.stepState[e.item.key]
            if(!current.step.primary) {
                // allow toggle
                current.contentHide = self._toggleString(current.contentHide,"","content-hide")
            }
        }

        self.registerObserverableEventHandler(
                opts.name + '-next',
                self.onNext)

        self.onStateInit = (state) =>{
            self.stepState = state;
            console.log('stepper: onStateInit',self.stepState)
            for (var key in self.stepState) {
                var current = self.stepState[key]
                current.rawId = current.name + "-raw-id"
            }
            self.update();
        }

        // place mixins here that require stuff to already exist.
        self.mixin("state-init-mixin");
    </script>
</stepper>
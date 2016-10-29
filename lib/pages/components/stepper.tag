

<stepper-raw-content>
    riot.mount(this.root, opts.content.tag, opts.content)
</stepper-raw-content>
<stepper>

    <div class="stepper">
        <div each={key in stepState} class="step {stepState[key].active} {stepState[key].contentHide}">

            <div>
                <a class="btn-floating btn-small waves-effect waves-light circle2"
                   onclick={toggleStepExpand}>{stepState[key].id}</a>
                <div class="line"></div>
            </div>
            <div>
                <div class="title">{stepState[key].title}</div>
                <div class="description">{stepState[key].description}</div>
                <div class="line-separator"></div>
                <div class="body">
                    <stepper-raw-content content="{parent.stepState[key]}"></stepper-raw-content>
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
        var self = this;

        self.mixin("opts-mixin");

        self.mixin("shared-observable-mixin");

        self.stepState = {};

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
                if(current.active ==="inactive"){
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
            console.log(current)

            current.contentHide = self._toggleString(current.contentHide,"","content-hide")
            console.log(current)
        }

        self.registerObserverableEventHandler(
                opts.name + '-next',
                self.onNext)

        self.onStateInit = (state) =>{
            self.stepState = state;
            console.log('stepper: onStateInit',self.stepState)
            self.update();
        }

        // place mixins here that require stuff to already exist.
        self.mixin("state-init-mixin");
    </script>
</stepper>
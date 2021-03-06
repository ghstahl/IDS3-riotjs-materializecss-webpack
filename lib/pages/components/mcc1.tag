import './stepper-panel.tag'
import './markdown.tag'
import marked from 'marked'

<mcc1>
    <stepper-panel>
        <yield to="body">
            <div class = "eula" >
                <markdown markdown={parent.markdown}></markdown>
            </div>
            <div class="progress">
                <div class="determinate" style="width: {parent.progressValue}%"></div>
            </div>
        </yield>
        <yield to="footer">
            <a class="waves-effect waves-light btn {parent.state.state.eulaAgreed}"
                                                    disabled={parent.state.state.disabled}
                                                    onclick={parent.onAgree}>Agree</a>
            <a class="waves-effect waves-light btn"
               onclick={parent.onDisagree}>Disagree</a>

        </yield>
    </stepper-panel>
    <style scoped>
        .eula-agreed {
            color: #9e9e9e;
            pointer-events: none;
        }
        .eula {
            overflow-y: auto;
            max-height: 310px;
        }

        textarea.materialize-textarea {
            max-height: 3rem;
            border: 2px solid black;
        }

        .progress {
            height: 2px;
        }
    </style>
    <script>
        var self = this;
        self.mixin("opts-mixin");
        self.mixin("shared-observable-mixin");
        self.state = {};
        self.markdown = ""
        self.progressValue = 10;

        self.tick = () =>{
            console.log('tick')
            self.progressValue += 15;
            if(self.progressValue >= 100){
                self.progressValue = 100;
                self.state.state.disabled = false;
                clearInterval(self.timer)
            }
            self.update();
        }



        self.on('unmount', function() {
            console.log('unmount: mcc1',self,opts);
            clearInterval(self.timer)
        })

        self.on('mount',function(){
            console.log('mount: mcc1',self,opts);
            marked.setOptions({
                renderer: new marked.Renderer(),
                gfm: true,
                tables: true,
                breaks: false,
                pedantic: false,
                sanitize: false,
                smartLists: true,
                smartypants: false
            });
            console.log(marked('I am using __markdown__.'));
            self.timer = setInterval(self.tick, 300)
        })
        self.onDisagree = (e) =>{
            console.log('mcc1 onDisagree',e.item);
            self.triggerEvent(opts.name+'-dirty',[self.state])
        }
        self.onAgree = (e) =>{
            console.log('mcc1 stepContinue',e.item);
            self.state.state.eulaAgreed="eula-agreed"
            self.state.state.disabled = true;
            self.triggerEvent(opts.name+'-continue')
        }
        self.makeDirty = () =>{
            self.state.state.disabled = false;
            self.state.state.eulaAgreed = "";

        }
        self.onStateInit = (state) =>{
            self.state = state;

            console.log('mcc1: onStateInit',self.state)
            self.markdown = self.state.state.eula
            self.state.makeDirty = self.makeDirty;
            self.makeDirty();
            self.state.state.disabled = true; // want the button grey, the timer will light it up
            self.update();
        }
        // place mixins here that require stuff to already exist.
        self.mixin("state-init-mixin");
    </script>
</mcc1>

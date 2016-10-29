import './stepper-panel.tag'
import './markdown.tag'
import marked from 'marked'

<mcc1>
    <stepper-panel>
        <yield to="body">
            <div class = "eula" >
                <markdown markdown={parent.markdown}></markdown>
            </div>

        </yield>
        <yield to="footer">
            <a class="waves-effect waves-light btn-flat {parent.state.custom.eulaAgreed}"
               onclick={parent.onAgree}>Agree</a>
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
    </style>
    <script>
        var self = this;
        self.mixin("opts-mixin");
        self.mixin("shared-observable-mixin");
        self.state = {};
        self.markdown = ""

        self.on('updated',function(){
            console.log('updated',self.state.custom)
        })

        self.on('mount',function(){
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
        })
        self.onAgree = (e) =>{
            console.log('mcc1 stepContinue',e.item);
            self.state.custom.eulaAgreed="eula-agreed"
            self.triggerEvent(opts.name+'-continue')
        }
        self.onStateInit = (state) =>{
            self.state = state;

            console.log('mcc1: onStateInit',self.state)
            self.markdown = self.state.custom.eula

            self.update();
        }
        // place mixins here that require stuff to already exist.
        self.mixin("state-init-mixin");
    </script>
</mcc1>

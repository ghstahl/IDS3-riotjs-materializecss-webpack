import Sortable from '../../js/Sortable.min.js';

<dd-form-card>

    <div class="row">
        <div class="input-field col s6">
            <ul class="collection with-header" id="dragTarget">
                <div class="collection-header">
                    <h4>{state.dragTarget.title}</h4>
                    <span>{state.dragTarget.titleSecondary}</span>
                    <span><i class="material-icons secondary-content">system_update_alt</i></span>
                </div>

                <li each={state.dragTarget.data}
                    data-item={name}
                    class="collection-item">
                    <span><i class="material-icons">assignment_turned_in</i></span>
                    <span>{name}</span>
                    <a onclick={onRemoveItem}
                       class="waves-effect secondary-content">
                        Remove</a>
                </li>
            </ul>
        </div>

        <div class="input-field col s6">
            <ul class="collection with-header" id="dragSource">
                <div class="collection-header">
                    <h4>{state.dragSource.title}</h4>
                    <span>{state.dragSource.titleSecondary}</span>
                </div>
                <li each={state.dragSource.data}
                    data-item="{name}"
                    class="collection-item">
                    <span class="my-handle"><i class="material-icons">assignment_return</i></span>
                    <span>{name}</span>
                </li>
            </ul>
        </div>
    </div>

    <style scoped>
        .sortable-ghost {
            opacity: .3;
            background: #f60;
        }
        .my-handle {
            cursor: move;
            cursor: -webkit-grabbing;
        }
        .ignore-elements{}
        #dragTarget  {
            min-height: 160px
        }
    </style>
    <script>
        /*
         USAGE:

         <dd-form-card name="assign-scopes" drag-target={dragTarget} drag-source={dragSource} ></dd-form-card>


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
         self.observable.on('assign-scopes-target-changed',function(){
         console.log('assign-scopes-target-changed',self.dragTarget)
         })
         */
        var self = this;
        self.mixin("opts-mixin");
        self.mixin("shared-observable-mixin");

        self.state = {}

        self.emptyUL2 = (ul) => {
            var lis = ul.getElementsByTagName("li");
            for(var i = lis.length; i--;){
                if(lis[i].attributes["do-not-remove"]  == undefined){
                    ul.removeChild(lis[i]);
                }
            }
        }

        self.onRemoveItem = (e) =>{
            console.log('onRemoveItem',e.item.name)
            var result = self.state.dragTarget.data.filter(function( item ) {
                return item.name != e.item.name;
            });
            self.state.dragTarget.data = result;
            self.update()
            self.triggerEvent(opts.name+'-target-changed',[]);
        }

        self.onStateInit = (state) =>{
            self.state = state;
            self.update();
        }

        // listen to 'start' event
        this.on('mount', function() {
            console.log('dd-form-card',opts)

            Sortable.create(self.dragSource, {
                handle: ".my-handle",
                filter: ".ignore-elements",
                group: {
                    name: 'scopes',
                    pull: 'clone',
                    put: false
                },
                sort:false
            });

            Sortable.create(self.dragTarget, {
                filter: ".ignore-elements",
                group: {
                    name: 'scopes',
                    pull: false
                },
                sort:false,
                onAdd: function (evt) {
                    var el = evt.item;
                    var newItem = evt.item.attributes["data-item"].value;
                    console.log(newItem);

                    // is it in our backing array
                    var item = self.state.dragTarget.data.find(x => x.name === newItem);
                    if (item) {
                        console.log("This item already exists");
                    }
                    else {
                        self.state.dragTarget.data.push({ name: newItem });
                    }
                    self.emptyUL2(self.dragTarget);
                    var temp = self.state.dragTarget.data;
                    self.state.dragTarget.data = [];
                    self.update();
                    self.state.dragTarget.data = temp;
                    self.update();
                    self.triggerEvent(opts.name+'-target-changed',[]);
                }
            });
        })

        // place mixins here that require stuff to already exist.
        self.mixin("state-init-mixin");
    </script>
</dd-form-card>

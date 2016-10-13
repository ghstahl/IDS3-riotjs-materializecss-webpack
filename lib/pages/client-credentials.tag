import RiotControl from 'riotcontrol';
import './components/credential-card.tag'

<client-credentials>


    <ul class="collapsible collection with-header">
        <li class="collection-header"><h5>Client Credentials</h5></li>
        <li  each="{ item in items }">

            <div class="collapsible-header"><i class="material-icons">mode_edit</i>{ item.friendlyName }</div>
            <div class="collapsible-body">
                <credential-card
                         item={ item }
                         onremove = {parent.onRemove}>
                </credential-card>
            </div>
        </li>
    </ul>

    <ul class="collection with-header">
        <li class="collection-header"><h5>Create New Client Credentials</h5></li>
        <li>
            <form class="col s12" >
                <div class="row">
                    <div class="input-field col s6">
                        <i class="material-icons prefix">account_circle</i>
                        <input
                                type="text" class="validate"
                                oninput = { onRChange }
                                onchange = { onRChange }
                                onkeypress = { onKeyPress }
                                name='r' >
                        <label >Friendly Client Name</label>
                    </div>

                </div>
                <div class="row">
                    <div class="input-field col s6" id="flowPickerContainer">
                        <i class="material-icons prefix">timeline</i>
                        <select id="selectFlow">
                            <option  value="-1" disabled selected>Add New Flow...</option>
                            <option  each="{availableFlows}" value="{Name}"
                                     onChange={this.onSelectChanged}
                                     data-message={Name}>{Name}</option>
                        </select>
                        <label>Flow Type</label>
                    </div>
                </div>

                <div class="row">
                    <div class="input-field col s6" id="scopePickerContainer">
                        <i class="material-icons prefix">my_location</i>
                        <select id="selectScope">
                            <option id="selectScope_default" value="-1" disabled selected>Add New Scope...</option>
                            <option  each="{availableScopes}" value="{Name}"
                                     onChange={this.onSelectChanged}
                                     data-message={Name}>{Name}</option>
                        </select>
                        <label>Scopes</label>
                    </div>

                </div>
                <div class="row">
                    <div class="col s6">
                        <a
                                id="addButton"
                                disabled={ !isAddable }
                                onclick={onAdd}
                                class="waves-effect waves-light btn right">Add New Client</a>
                    </div>
                </div>
            </form>
        </li>

    </ul>
    <script>
        var self = this;
        self.items  = [];
        self.availableScopes = [{Name:"offline-access"},{Name:"api1"}]
        self.availableFlows = [{Name:"Credentials"},{Name:"Resource Owner"}]

        self.isAddable = false;
        self.lastR = null;

        self.excludeItemFromItems = (items,item)=>{
            var fn = item.friendlyName.toUpperCase()
            var result = items.filter(function( obj ) {
                return obj.friendlyName.toUpperCase() != fn;
            });
            return result;
        }
        self.containsItemInItems = (items,item) =>{
            var fn = item.friendlyName.toUpperCase()
            var result = items.filter(function( obj ) {
                return obj.friendlyName.toUpperCase() == fn;
            });
            return result.length > 0;
        }

        self.onItemsChanged = function(items){
            console.log('client-credential-items-changed',items)
            self.items = items;
            self.update();
        }

        self.onSelectChange = (e) =>{
            console.log('onSelectChange',e)
            self.calcOnAddable()
            self.update();
        }

        self.on('unmount', function() {
            RiotControl.off('client-credential-items-changed', self.onItemsChanged)
        });

        self.on('mount', function() {
            console.log('mount',this)
            riot.observable(self.selectFlow) // Riot provides our event emitter.
            riot.observable(self.selectScope) // Riot provides our event emitter.

            $('.collapsible').collapsible({
                accordion : false // A setting that changes the collapsible behavior to expandable instead of the default accordion style
            });
            $('select').material_select();
            self.selectFlow.on('contentChanged', function() {
                console.log('selectFlow::contentChanged')
                // re-initialize (update)
                $(this).material_select();
            });
            self.selectScope.on('contentChanged', function() {
                console.log('selectScope::contentChanged')
                // re-initialize (update)
                $(this).material_select();
            });

            $('#scopePickerContainer').on('change', 'select',self.onSelectChange);
            $('#flowPickerContainer').on('change', 'select',self.onSelectChange);

            RiotControl.on('client-credential-items-changed', self.onItemsChanged)
            RiotControl.trigger('client-credential-items-get');
            self.calcOnAddable();
        });


        self.onRemove = (e) =>{
            console.log('onRemove',e,e.target.dataset.message)
            RiotControl.trigger('client-credential-remove',
                    {friendlyName:e.target.dataset.message},
                    self.excludeItemFromItems );
            self.collapseAll();
        }

        self.onAdd = function() {
            if(self.isAddable == true){

                var record = {
                    friendlyName:self.lastR,
                    flow:self.selectFlow.value,
                    scope:self.selectScope.value
                }

                console.log('onAdd',record)
                RiotControl.trigger('client-credential-add',record,self.containsItemInItems);
                self.lastR = "";
                self.r.value  = self.lastR;
                self.selectFlow.value = "-1";
                self.selectScope.value = "-1";
                self.calcOnAddable();

                self.selectFlow.trigger('contentChanged');
                self.selectScope.trigger('contentChanged');

                self.update();
            }
        }
        self.calcOnAddable = ()=>{
            if(self.lastR &&
                    self.lastR.length > 1 &&
                    self.selectFlow.value != "-1" &&
                    self.selectScope.value != "-1"
            ){
                self.isAddable =  true;

            }else{
                self.isAddable =  false;
            }
            console.log('calcOnAddable',self.isAddable)
        }
        self.onRChange = function(e) {
            console.log('onRChange',self.r,self.r.value);
            var rValue = self.r.value
            self.lastR = rValue

            self.calcOnAddable();

        }

        self.onKeyPress = function(e) {
            if(!e)
                e=window.event;
            var keyCode = e.keyCode || e.which;
            console.log('onKeyPress',keyCode,e);
            if(keyCode== 13){
                event.preventDefault();
                if(self.isAddable){
                    self.onAdd();
                }
                return false;
            }else{
                return true;
            }
        }
        self.collapseAll = () =>{
            $(".collapsible-header").removeClass(function(){
                return "active";
            });
            $(".collapsible").collapsible({accordion: true});
            $(".collapsible").collapsible({accordion: false});
        }
    </script>
</client-credentials>
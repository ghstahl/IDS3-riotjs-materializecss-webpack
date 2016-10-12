import RiotControl from 'riotcontrol';

<client-credentials>


    <ul class="collapsible collection with-header">
        <li class="collection-header"><h4>Client Credentials</h4></li>
        <li each="{ name, i in roles }">
            <div class="collapsible-header"><i class="material-icons">mode_edit</i>{ name }</div>
            <div class="collapsible-body">
                <p>
                    <a onclick={ onRemove }
                       data-message={name}
                       class="waves-effect waves-light red btn">Remove</a>
                </p>
            </div>
        </li>



        <li>
            <form class="col s12" onkeypress="return event.keyCode != 13">
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
                            <option value="-1" disabled selected>Add New Flow...</option>
                            <option  each="{availableFlows}" value="{Name}"
                                     onChange={this.onSelectChanged}
                                     data-message={Name}>{Name}</option>
                        </select>
                        <label>Flow Type</label>
                    </div>
                </div>

                <div class="row">
                    <div class="input-field col s6" id="scopePickerContainer">
                        <i class="material-icons prefix">scope</i>
                        <select id="selectScope">
                            <option value="-1" disabled selected>Add New Scope...</option>
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
        self.roles = ["Should","Never","See","This"]
        self.isAddable = false;
        self.lastR = null;

        self.containsItemInItems = function(items,value){
            var result = items.filter(function( obj ) {
                return obj.friendlyName == value.friendlyName;
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


        self.onRolesChanged =  function(roles) {
            console.log('roles_changed',roles)
            self.roles = roles;
            self.update();
        }

        self.on('unmount', function() {
            RiotControl.off('client-credential-items-changed', self.onItemsChanged)
            RiotControl.off('roles_changed', self.onRolesChanged)
        });

        self.on('mount', function() {
            console.log('mount',this)
            $('.collapsible').collapsible({
                accordion : false // A setting that changes the collapsible behavior to expandable instead of the default accordion style
            });
            $('select').material_select();
            $('#scopePickerContainer').on('change', 'select',self.onSelectChange);
            $('#flowPickerContainer').on('change', 'select',self.onSelectChange);

            RiotControl.on('client-credential-items-changed', self.onItemsChanged)
            RiotControl.on('roles_changed', self.onRolesChanged)
            RiotControl.trigger('roles_fetch');
            RiotControl.trigger('client-credential-items-get');
            self.calcOnAddable();
        });

        self.onRemove = (e) =>{
            console.log('onRemove',e,e.target.dataset.message)
            RiotControl.trigger('roles_remove',  e.target.dataset.message );
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
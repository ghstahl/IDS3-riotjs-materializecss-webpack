import RiotControl from 'riotcontrol';

<client-credentials>


    <ul class="collapsible collection with-header">
        <li class="collection-header"><h4>Client Credentials</h4></li>
        <li each="{ name, i in roles }">
            <div class="collapsible-header"><i class="material-icons">mode_edit</i>{ name }</div>
            <div class="collapsible-body">
                <p>
                    <a onclick={ onRemoveRole }
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
                                    oninput = { onRoleChange }
                                    onchange = { onRoleChange }
                                    onkeypress = { onKeyPress }
                                    name='r' >
                            <label >Friendly Client Name</label>
                        </div>

                    </div>
                    <div class="row">
                    <div class="input-field col s6">
                        <i class="material-icons prefix">timeline</i>
                        <select>
                            <option value="" disabled selected>Choose your flow</option>
                            <option value="1">Resource Owner</option>
                            <option value="2">Credential</option>

                        </select>
                        <label>Flow Type</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="input-field col s6">
                            <i class="material-icons prefix">scope</i>
                            <select>
                                <option value="" disabled selected>Choose your scopes</option>
                                <option value="1">Resource Owner</option>
                                <option value="2">Credential</option>

                            </select>
                            <label>Scopes</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col s6">
                            <a
                                    id="addRoleButton"
                                    disabled={ !isRoleAddable }
                                    onclick={onAddRole}
                                    class="waves-effect waves-light btn right">Add New Client</a>
                        </div>


                    </div>

                </form>
        </li>

    </ul>


    <script>
        var self = this;
        self.items  = [];
        self.roles = ["Should","Never","See","This"]
        self.isRoleAddable = false;
        self.lastRole = null;

        self.containsItemInItems = function(items,value){
            var result = self.roles.filter(function( obj ) {
                return obj == value;
            });
            return result.length > 0;
        }

        self.onItemsChanged = function(items){
            console.log('client-credential-items-changed',items)
            self.items = items;
            self.update();
        }

        self.onRolesChanged =  function(roles) {
            console.log('roles_changed',roles)
            self.roles = roles;
            self.update();
        }

        self.on('unmount', function() {
            RiotControl.off('roles_changed', self.onRolesChanged)
        });

        self.on('mount', function() {
            console.log('mount',this)
            $('.collapsible').collapsible({
                accordion : false // A setting that changes the collapsible behavior to expandable instead of the default accordion style
            });
            $('select').material_select();
            RiotControl.on('client-credential-items-changed', self.onItemsChanged)
            RiotControl.on('roles_changed', self.onRolesChanged)
            RiotControl.trigger('roles_fetch');
            RiotControl.trigger('client-credential-items-get');
            self.calcOnRoleAddable();
        });

        self.onRemoveRole = (e) =>{

            console.log('onRemoveRole',e,e.target.dataset.message)
            RiotControl.trigger('roles_remove',  e.target.dataset.message );
            self.collapseAll();
        }

        self.onAddRole = function() {
            if(self.isRoleAddable == true){
                console.log('onAddRole',self.lastRole)
                RiotControl.trigger('roles_add',self.lastRole);
                self.lastRole = "";
                self.r.value  = self.lastRole;
                self.calcOnRoleAddable();
            }
        }
        self.calcOnRoleAddable = ()=>{
            if(self.lastRole && self.lastRole.length > 1){
                self.isRoleAddable =  true;
                self.addRoleCallback = self.onAddRole;
            }else{
                self.isRoleAddable =  false;
                self.addRoleCallback = null;
            }
        }
        self.onRoleChange = function(e) {
            console.log('onRoleChange',self.r,self.r.value);
            var roleTerm = self.r.value
            self.lastRole = roleTerm

            self.calcOnRoleAddable();
            console.log(self.isRoleAddable)
        }

        self.onKeyPress = function(e) {
            if(!e)
                e=window.event;
            var keyCode = e.keyCode || e.which;
            console.log('onKeyPress',keyCode,e);
            if(keyCode== 13){
                event.preventDefault();
                if(self.isRoleAddable){
                    self.onAddRole();
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
import RiotControl from 'riotcontrol';

<roles>


    <ul class="collapsible collection with-header">
        <li class="collection-header"><h4>Roles</h4></li>
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



        <li >
            <form  class="col s12">

            <div class="row">
                <div class="input-field col s0">
                    <a id="addRoleButton"
                       disabled={ !isRoleAddable }
                       onclick={onAddRole}
                       class="btn-floating btn-medium waves-effect waves-light "><i class="material-icons">add</i></a>
                </div>
                <div class="input-field col s10">
                    <input
                            type="text" class="validate"
                             oninput = { onRoleChange }
                             onchange = { onRoleChange }
                             onkeypress = { onKeyPress }
                             name='r' >
                    <label>Add a new role.</label>
                </div>

            </div>
        </form>
        </li>
    </ul>


    <script>
        var self = this;
        self.roles = ["Should","Never","See","This"]
        self.isRoleAddable = false;
        self.lastRole = null;


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
            RiotControl.on('roles_changed', self.onRolesChanged)
            RiotControl.trigger('roles_fetch');
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
</roles>
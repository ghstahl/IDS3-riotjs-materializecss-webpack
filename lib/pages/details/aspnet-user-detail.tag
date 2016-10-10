import RiotControl from 'riotcontrol';

<aspnet-user-detail>
    <h4>{ result.name }</h4>

    <div class="s12 l9 col">
        <table class="highlight">
            <thead>
            <tr>
                <th><h5>User Details</h5></th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>Id</td>
                <td>{ result.User.Id }</td>
            </tr>
            <tr>
                <td>Email</td>
                <td>{ result.User.Email }</td>
            </tr>
            <tr>
                <td>UserName</td>
                <td>{ result.User.UserName }</td>
            </tr>
            <tr>
                <td>EmailConfirmed</td>
                <td>{ result.User.EmailConfirmed }</td>
            </tr>

            </tbody>
        </table>
    </div>
    <div  class="s12 l9 col">
        <div if={is_display_user_roles}>
            <table  class="highlight">
                <thead>
                <tr>
                    <th><h5>Roles</h5></th>
                    </th>
                </tr>
                </thead>
                <tbody>



                </tbody>
            </table>
            <ul class="collapsible" data-collapsible="accordion">
                <li each="{ name, i in result.Roles }">
                    <div class="collapsible-header"><i class="material-icons">mode_edit</i>{ name }</div>
                    <div class="collapsible-body">
                        <p>
                            <a onclick={ onRemoveRole }
                               data-message={name}
                               class="waves-effect waves-light red btn">Remove</a>
                        </p>

                    </div>
                </li>


            </ul>
        </div>




        <div if={is_add_role_allowed}  class="row">
            <form  class="col s12">
                <div class="row">
                    <div class="input-field col s12" id="rolePickerContainer">
                        <select id="selectRole">
                            <option value="-1" disabled selected>Add New Role...</option>
                            <option  each="{availableRoles}" value="{Name}"
                                     onChange={this.onAddRole}

                                     data-message={Name}>{Name}</option>
                        </select>

                    </div>
                </div>

            </form>
        </div>
        </div>
    </div>

    <!-- Dropdown Structure -->

        <ul id='dropdown1' class='dropdown-content'>
            <li><a >Cancel</a></li>
            <li class="divider"></li>
            <li><a  data-message=true onclick={ onRoleRemoveConfirmation }>Confirm Delete</a></li>


        </ul>


<style scoped>

    .role-edit{
        margin: 10px;
    }
    #aside {
             width:350px;
         }

    .dropdown-content {
        min-width: 200px; /* Changed this to accomodate content width */

    }

</style>
    <script>
        var self = this;
        self.is_display_user_roles = true;
        self.inPlayItem = null;
        self.systemRoles = null;
        self.availableRoles = null;
        self.result = null;
        self.is_add_role_allowed = false;

        self.on('before-mount',function(){
            console.log('on before-mount: aspnet-user-detail');
            RiotControl.on('aspnet_roles_changed', self.onAspNetRolesChanged);
            RiotControl.on('aspnet_user_changed', self.onAspNetUserChanged);

        });
        self.on('unmount', function() {
            RiotControl.off('aspnet_roles_changed', self.onAspNetRolesChanged);
            RiotControl.off('aspnet_user_changed', self.onAspNetUserChanged);
        })

        self.on('mount', function() {
            var self = this;
            self.result = null;
            var q = riot.route.query();
            console.log('on mount: aspnet-user-detail',q);
            RiotControl.trigger('aspnet_roles_fetch');
            RiotControl.trigger('aspnet_user_by_id', { id: q.id });
            $('select').material_select();
        });

        self.onRoleRemoveConfirmation = (e) =>{

            console.log(e)
            console.log('onRoleRemoveConfirmation',e.target.dataset.message,self.inPlayItem)
        }

        self.onRemoveRole = (e) =>{

            console.log('onRemoveRole',e,e.target.dataset.message)
            RiotControl.trigger('aspnet_user_role_remove', { id: self.result.User.Id,role: e.target.dataset.message});
            self.collapseAll();
        }
        self.onAddRole = (e) =>{

            console.log(e)
            console.log('onAddRole',e.target.value)
            RiotControl.trigger('aspnet_user_roles_add', { id: self.result.User.Id,role: e.target.value});
            self.collapseAll();
        }

        self.calcIsAddRoleAllowed = () =>{
            self.is_add_role_allowed = false;
            if(self.result && self.systemRoles){
                self.availableRoles = self.systemRoles.filter(
                        (item)=>{
                            var result = self.result.Roles.filter(function( name ) {
                                return name == item.Name;
                            });

                            return result.length == 0;
                        });
                self.is_add_role_allowed = self.availableRoles.length > 0;
                var tt = self.availableRoles;
                self.update();

                $('#selectRole').val("1");

                $('select').material_select();
                $('#rolePickerContainer').on('change', 'select',self.onAddRole);
                console.log('is_add_role_allowed',self.is_add_role_allowed,self.availableRoles )
            }
        }


        self.onAspNetRolesChanged = (data) =>{
            console.log('aspnet_roles_changed',data)
            self.systemRoles = data;
            self.calcIsAddRoleAllowed();
        }
        self.onAspNetUserChanged = (user) =>{
            self.result = user;
            console.log('aspnet_user_changed',self.result)


            $('.collapsible').collapsible({
                accordion : false // A setting that changes the collapsible behavior to expandable instead of the default accordion style
            });
            for (var i = 0; i < user.Roles.length; i++) {
                var ddb = '.ddb'+i;

                $(ddb).dropdown({
                    inDuration: 300,
                    outDuration: 225,
                    constrain_width: false, // Does not change width of dropdown to that of the activator
                    hover: true, // Activate on hover
                    gutter: 0, // Spacing from edge
                    belowOrigin: false, // Displays dropdown below the button
                    alignment: 'left' // Displays dropdown with edge aligned to the left of button
                });
                var collapsible = '.collapsible'+i;
                $(collapsible).collapsible({
                    accordion : false // A setting that changes the collapsible behavior to expandable instead of the default accordion style
                });
            }

            self.calcIsAddRoleAllowed();
            self.update();
        }

        self.collapseAll = () =>{
            $(".collapsible-header").removeClass(function(){
                return "active";
            });
            $(".collapsible").collapsible({accordion: true});
            $(".collapsible").collapsible({accordion: false});
        }
    </script>
</aspnet-user-detail>

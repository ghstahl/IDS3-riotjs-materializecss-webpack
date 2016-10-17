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
                <tbody></tbody>
            </table>
            <div if={hasRoles}>
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
        <!-- Dropdown Structure -->

        <ul id='dropdown1' class='dropdown-content'>
            <li><a >Cancel</a></li>
            <li class="divider"></li>
            <li><a  data-message=true onclick={ onRoleRemoveConfirmation }>Confirm Delete</a></li>
        </ul>
    </div>
    <div if={hasDeveloperRole}>
        <h5>Identity Server Settings</h5>
        <div if={!isUserEnrolledInIdentityServer}>
            <a class="waves-effect waves-light btn">Enroll</a>
        </div>
    </div>

    <div if={hasDeveloperRole && isUserEnrolledInIdentityServer}  class="s12 l9 col">
        <table class="highlight">
            <thead>
            <tr>
                <th><h5>Scopes</h5></th>
            </tr>
            </thead>
        </table>
        <div if={hasUserScopes}>
            <ul class="collapsible" data-collapsible="accordion">
                <li each="{ name, i in userScopes }">
                    <div class="collapsible-header"><i class="material-icons">mode_edit</i>{ name }</div>
                    <div class="collapsible-body">
                        <p>
                            <a onclick={ onRemoveUserScope }
                               data-message={name}
                               class="waves-effect waves-light red btn">Remove</a>
                        </p>

                    </div>
                </li>
            </ul>
        </div>

        <div if={is_add_scope_allowed}  class="row">
            <form  class="col s12">
                <div class="row">
                    <div class="input-field col s12" id="scopePickerContainer">
                        <select id="selectScope">
                            <option value="-1" disabled selected>Add New Scope...</option>
                            <option  each="{availableScopes}" value="{Name}"
                                     onChange={this.onAddScope}
                                     data-message={Name}>{Name}</option>
                        </select>
                    </div>
                </div>
            </form>
        </div>
    </div>




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

        self.scopes = null;
        self.userScopes = null;
        self.hasUserScopes = false;
        self.availableScopes = null;
        self.is_display_user_roles = true;
        self.inPlayItem = null;
        self.systemRoles = null;
        self.availableRoles = null;
        self.result = null;

        self.allowedUserScopes = null;
        self.is_add_role_allowed = false;
        self.is_add_scope_allowed = false;
        self.hasDeveloperRole = false;
        self.hasRoles = false;
        self.isUserEnrolledInIdentityServer = false;

        self.on('before-mount',function(){
            console.log('on before-mount: aspnet-user-detail');
            for (var i = 0, len = self.riotControlMap.length; i < len; i++) {
                console.log(self.riotControlMap[i])

                RiotControl.on(self.riotControlMap[i].evt, self.riotControlMap[i].handler);
            }
        });
        self.on('unmount', function() {
            for (var i = 0, len = self.riotControlMap.length; i < len; i++) {
                RiotControl.off(self.riotControlMap[i].evt, self.riotControlMap[i].handler);
            }
        })

        self.on('mount', function() {
            self.result = null;
            var q = riot.route.query();
            console.log('on mount: aspnet-user-detail',q);
            RiotControl.trigger('identityserver-admin-scopes-get');
            RiotControl.trigger('identityserver-admin-scopes-users-get',{userId:q.id});
            RiotControl.trigger('aspnet_roles_fetch');
            RiotControl.trigger('aspnet_user_by_id', { id: q.id });
            RiotControl.trigger('identityserver-admin-users-get', { userId: q.id });

            $('select').material_select();
        });


        self.onUserScopeResult = (result) => {
            console.log('onUserScopeResult',result)
            self.userScopes = result;
            $('.collapsible').collapsible({
                accordion : false // A setting that changes the collapsible behavior to expandable instead of the default accordion style
            });
            self.calcIsAddScopeAllowed();
            self.hasUserScopes = self.userScopes.length>0;
            self.update();
        }
        self.onScopesResult = (result) => {
            console.log('onScopesResult',result)
            self.scopes = result;
            self.calcIsAddScopeAllowed();
            self.update();
        }

        self.onIdentityServerScopesUsersGetResult= (query,data) =>{
            console.log('identityserver-admin-scopes-users-get-result',query,data)
            self.allowedUserScopes = data;
            self.update();
        }

        self.onIdentityServerUserGetResult = (query,data) =>{
            console.log('identityserver-admin-users-get-result',query,data)
            if(data && data.UserId == query.userId){
                self.isUserEnrolledInIdentityServer = true;
                self.update();
                RiotControl.trigger('identityserver-admin-scopes-get');
                RiotControl.trigger('identityserver-admin-scopes-users-get', { userId:  query.userId });
            }
            console.log(self.isUserEnrolledInIdentityServer)
        }

        self.onRoleRemoveConfirmation = (e) =>{

            console.log(e)
            console.log('onRoleRemoveConfirmation',e.target.dataset.message,self.inPlayItem)
        }

        self.onRemoveUserScope = (e) =>{
            console.log('onRemoveRole',e,e.target.dataset.message)
            RiotControl.trigger('identityserver-admin-scopes-users-delete',
                    { userId: self.result.User.Id,name: e.target.dataset.message});
            self.collapseAll();
        }
        self.onAddScope = (e) =>{
            console.log(e)
            console.log('onAddScope',e.target.value)
            RiotControl.trigger('identityserver-admin-scopes-users-create',
                    { userId: self.result.User.Id,scopes: [e.target.value]});
            self.collapseAll();
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

        self.calcIsAddScopeAllowed = () =>{

            self.is_add_scope_allowed = false
            if(self.scopes && self.userScopes){
                self.availableScopes = self.scopes.filter(
                                (item)=>{
                                var result = self.userScopes.filter(function( name ) {
                                    return name == item.Name;
                                });

                    return result.length == 0;
                });
                self.is_add_scope_allowed = self.availableScopes.length > 0;

                self.update();

                $('#selectScope').val("1");

                $('select').material_select();
                $('#scopePickerContainer').on('change', 'select',self.onAddScope);
                console.log('is_add_scope_allowed',self.is_add_scope_allowed,self.availableScopes )
            }
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
            self.hasRoles = self.result.Roles.length > 0;
            var result = self.result.Roles.filter(function( name ) {
                return name == "Developer";
            });
            self.hasDeveloperRole = (result && result.length > 0);
            self.update();
        }

        self.collapseAll = () =>{
            $(".collapsible-header").removeClass(function(){
                return "active";
            });
            $(".collapsible").collapsible({accordion: true});
            $(".collapsible").collapsible({accordion: false});
        }
        self.riotControlMap = [
            {evt:'aspnet_roles_changed', handler:self.onAspNetRolesChanged},
            {evt:'aspnet_user_changed', handler:self.onAspNetUserChanged},
            {evt:'identityserver-admin-users-get-result', handler:self.onIdentityServerUserGetResult},
            {evt:'identityserver-admin-scopes-get-result', handler:self.onIdentityServerScopeGetResult},
            {evt:'identityserver-admin-scopes-users-get-result', handler:self.onIdentityServerScopesUsersGetResult},
            {evt:'identityserver-admin-scopes-get-result', handler:self.onScopesResult},
            {evt:'identityserver-admin-scopes-users-get-result', handler:self.onUserScopeResult},

        ]
    </script>
</aspnet-user-detail>








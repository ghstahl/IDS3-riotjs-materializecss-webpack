import RiotControl from 'riotcontrol';

<identity-server-scopes>
    <ul class="collapsible collection with-header">
        <li class="collection-header"><h4>Identity Server Scopes</h4></li>
        <li each="{scopes}">
            <div class="collapsible-header"><i class="material-icons">mode_edit</i>{ Name }</div>
            <div class="collapsible-body">
                <p>
                    <a onclick={ onRemoveScope }
                       data-message={Name}
                       class="waves-effect waves-light red btn">Remove</a>
                </p>
            </div>
        </li>

        <li>
            <form  class="col s12">
                <div class="row">
                    <div class="input-field col s0">
                        <a id="addScopeButton"
                           disabled={ !isScopeAddable }
                           onclick={onAddScope}
                           class="btn-floating btn-medium waves-effect waves-light "><i class="material-icons">add</i></a>
                    </div>
                    <div class="input-field col s10">
                        <input
                                type="text" class="validate"
                                 oninput = { onScopeInputChange }
                                 onchange = { onScopeInputChange }
                                 onkeypress = { onKeyPress }
                                 name='r' >
                        <label>Add a new Scope.</label>
                    </div>
                </div>
            </form>
        </li>
    </ul>


    <script>
        var self = this;
        self.scopes = []
        self.isScopeAddable = false;
        self.lastScope = null;

        self.onScopesResult =  function(result) {
            console.log('onScopesResult',result)
            self.scopes = result;
            self.update();
        }

        self.on('before-mount', function() {
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
        });

        self.on('mount', () =>{
            console.log('mount',this)
            $('.collapsible').collapsible({
                accordion : false // A setting that changes the collapsible behavior to expandable instead of the default accordion style
            });

            RiotControl.trigger('identityserver-admin-scopes-get');
            self.calcOnScopeAddable();
        });

        self.onRemoveScope = (e) =>{
            console.log('onRemoveScope',e,e.target.dataset.message)
            RiotControl.trigger('identityserver-admin-scopes-delete',  {name:e.target.dataset.message} );
            self.collapseAll();
        }

        self.onAddScope = () => {
            if(self.isScopeAddable == true){
                console.log('onAddScope',self.lastScope)
                RiotControl.trigger('identityserver-admin-scopes-create',{
                    name:self.lastScope,
                    type:'Resource',
                    enabled:true
                });
                self.lastScope = "";
                self.r.value  = self.lastScope;
                self.calcOnScopeAddable();
            }
        }

        self.calcOnScopeAddable = () => {
            if(self.lastScope && self.lastScope.length > 1){
                self.isScopeAddable =  true;
                self.addScopeCallback = self.onAddScope;
            }else{
                self.isScopeAddable =  false;
                self.addScopeCallback = null;
            }
        }
        self.onScopeInputChange = (e) =>{
            console.log('onScopeInputChange',self.r,self.r.value);
            var roleTerm = self.r.value
            self.lastScope = roleTerm

            self.calcOnScopeAddable();
            console.log(self.isScopeAddable)
        }

        self.onKeyPress = (e) =>{
            if(!e)
                e=window.event;
            var keyCode = e.keyCode || e.which;
            console.log('onKeyPress',keyCode,e);
            if(keyCode== 13){
                event.preventDefault();
                if(self.isScopeAddable){
                    self.onAddScope();
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
        self.riotControlMap = [
            {evt:'identityserver-admin-scopes-get-result', handler:self.onScopesResult},
        ]
    </script>
</identity-server-scopes>
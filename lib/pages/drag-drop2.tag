import Sortable from '../js/Sortable.min.js';
import './components/simple-table.tag';
import './components/consolidated-form-test.tag'

<drag-drop2>
    <simple-table title={stTitle}
                  cols={stCols}
                  rows={stRows}></simple-table>
    <div class="secion">
        <div class="row">
            <form class="col s12" >
                <div class="row">
                    <div class="input-field col s6">
                        <ul class="collection" id="roleA">
                            <li each={_itemsRoleA} data-role="{name}" class="collection-item">
                                {name}
                            </li>
                        </ul>
                    </div>
                    <div class="input-field col s6">
                        <ul class="collection" id="roleB">
                            <li each={_itemsRoleB} data-role="{name}" class="collection-item">
                                {name}
                            </li>
                        </ul>
                    </div>
                </div>
            </form>
        </div>
        <div class="row">
            <form class="col s12" >
                <ul class="collection" id="roleFinal">
                    <li>
                        <p>Drag stuff to....
                            Here!
                        </p>
                    </li>
                    <li each={_itemsRoleFinal} class="collection-item avatar">

                        <img src="images/graduation.png" alt="" class="circle">
                        <span class="title">{name}</span>
                        <p>First Line <br>
                            Second Line
                        </p>

                        <a onclick={onRemoveItem}
                           class="waves-effect secondary-content waves-light ">
                            <i class="material-icons">remove</i>
                            Remove</a>
                    </li>
                </ul>
            </form>
        </div>
    </div>

    <consolidated-form-test name="cft"></consolidated-form-test>

    <button class="btn waves-effect waves-light" onclick="{updateRoles}"  >Submit</button>


    <!-- Modal Structure -->
    <!-- Modal Trigger -->
    <a class="waves-effect waves-light btn modal-trigger" onclick={onEULA}>EULA</a>

    <!-- Modal Structure -->
    <div id="modal1" class="modal">
        <div class="modal-content">
            <h4>Modal Header</h4>
            <p>A bunch of text</p>
        </div>
        <div class="modal-footer">
            <a class=" modal-action modal-close waves-effect waves-green btn-flat">Cancel</a>
            <a onclick={onAgree} class=" modal-action waves-effect waves-green btn-flat">Agree</a>
        </div>
    </div>

    <style scoped>
        .sortable-ghost {
            opacity: .3;
            background: #f60;
        }
        #roleA,#roleB,#roleFinal {
            border: 2px dashed #f60;
            min-height: 100px
        }
    </style>


    <script>
        var self = this
        self.mixin("shared-observable-mixin");

        self.hasAssignedScopes = false
        self.stCols = ["hi"]
        self.stTitle ="My Title"

        self.cftState = {
            friendlyName:"Some Friendly Name",
            scopes:[]
        }

        self.updateRoles = () =>{
            console.log(self.roleFinal)
        }

        self.inPlayItem = null;

        self._itemsGrantedScopes = [
            { name: 'offline_access' },
            { name: 'api1' },
            { name: 'geo_location' }
        ]


        self._itemsAssignedScopes = [
        ]
        self._itemsRoleA = [
            { name: 'Administrator' },
            { name: 'Developer',herb:'dig' },
            { name: 'User' }
        ]
        self._itemsRoleB = [
            { name: 'Dog' },
            { name: 'Cat' },
            { name: 'Mouse' }
        ]
        self._itemsRoleFinal = [
            { name: 'Administrator' }
        ]
        self.stRows =  self._itemsRoleFinal.map(function(item) {
            return ['scope',item.name];
        });

        self.initCFTState = () => {
            var cftState = {
                friendlyName:"Some Friendly Name",
                scopes:[]
            }
            self.cftState = cftState;
        }

        self.emptyUL = (ul) => {
            var lis = ul.getElementsByTagName("li");
            while(lis.length> 0){
                ul.removeChild(lis[0]);
                lis = ul.getElementsByTagName("li");
            }
        }

        self.onRemoveItem = (e) =>{

            console.log('onRemoveRole',e,e.item)
            var result = self._itemsRoleFinal.filter(function( item ) {
                return item.name != e.item.name;
            });
            self._itemsRoleFinal = result;
            self.stRows =  self._itemsRoleFinal.map(function(item) {
                return ['scope',item.name];
            });
            self.update()
        }

        self.onCFTSubmit = (state) =>{
            console.log('onCFTSubmit',state)
            self.initCFTState()
            self.triggerEvent('cft-state-init',[self.cftState]);
        }

        self.on('before-mount', function() {
            self.initCFTState()
        })

        self.on('mount', function() {
            self.initCFTState()
            self.triggerEvent('cft-state-init',[self.cftState]);

            Sortable.create(self.roleA, {
                group: {
                    name: 'roles',
                    pull: 'clone',
                    put: false
                },
                sort:false,
                onStart: function (/**Event*/evt) {
                    var newItem = self._itemsRoleA[evt.oldIndex];
                    self.inPlayItem = newItem;
                }
            });
            Sortable.create(self.roleB, {
                group: {
                    name: 'roles',
                    pull: 'clone',
                    put: false
                },
                sort:false,
                onStart: function (/**Event*/evt) {
                    var newItem = self._itemsRoleB[evt.oldIndex];
                    self.inPlayItem = newItem;
                }
            });

            Sortable.create(self.roleFinal, {
                group: {
                    name: 'roles',
                    pull: false
                },
                sort:false,
                onAdd: function (evt) {
                    var el = evt.item;
                    var roleName = el.getAttribute("data-role");
                    console.log(roleName);

                    // is it in our backing array
                    var item = self._itemsRoleFinal.find(x => x.name === roleName);
                    if (item) {
                        console.log("This item already exists");
                    }
                    else {
                        self._itemsRoleFinal.push(self.inPlayItem);
                    }
                    self.emptyUL(self.roleFinal);
                    var temp = self._itemsRoleFinal;
                    self._itemsRoleFinal = [];
                    self.update();
                    self._itemsRoleFinal = temp;


                    self.stRows =  self._itemsRoleFinal.map(function(item) {
                        return ['scope',item.name];
                    });
                    self.update();
                }
            });
            self.update();
        })
        self.onEULA = () =>{
            console.log('onEULA')
            $("#modal1").openModal({
                dismissible: false
            })
        }

        self.onAgree = () =>{
            console.log('onAgree');
            $("#modal1").closeModal()
        }
        self.registerObserverableEventHandler(
                'cft-submit',
                self.onCFTSubmit)
    </script>

</drag-drop2>


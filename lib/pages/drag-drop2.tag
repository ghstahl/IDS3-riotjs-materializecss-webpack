
import Sortable from '../js/Sortable.min.js';
import './components/simple-table.tag';

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


    <div class="secion">
        <div class="row">
            <form class="col s12" >
                <div class="row">
                    <div class="input-field col s6">
                        <ul class="collection with-header" id="assignedScopeDragTarget">
                            <div class="collection-header">
                                <h4>Assigned Scopes</h4>
                                <span>Drag granted scopes here...</span>
                                <span><i class="material-icons secondary-content">arrow_downward</i></span>
                            </div>

                            <li each={_itemsAssignedScopes}
                                data-item={name}
                                class="collection-item">
                                <span><i class="material-icons">assignment_turned_in</i></span>
                                <span>{name}</span>
                                <a onclick={onRemoveScopeItem}
                                   class="waves-effect secondary-content">
                                    Remove</a>
                            </li>
                        </ul>
                    </div>

                    <div class="input-field col s6">
                        <ul class="collection with-header" id="grantedScopeDragSource">
                            <div class="collection-header">
                                <h4>Granted Scopes</h4>
                                Drag granted scopes from here...
                            </div>
                            <li each={_itemsGrantedScopes} data-item="{name}" class="collection-item">
                                <span class="my-handle"><i class="material-icons">assignment_return</i></span>
                                <span>{name}</span>
                            </li>
                        </ul>
                    </div>
                </div>
            </form>
        </div>
    </div>


        <button class="btn waves-effect waves-light" onclick="{updateRoles}"  >Submit</button>


    <!-- Modal Structure -->
    <div id="modal1" class="modal">
        <div class="modal-content">
            <h4>Modal Header</h4>
            <p>A bunch of text</p>
        </div>
        <div class="modal-footer">
            <a href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat">Agree</a>
        </div>
    </div>
    <a href="#modal1" data-toggle="modal" class=" modal-trigger waves-effect waves-light blue accent-2 white-text btn">Add Comment</a>
    <!-- Modal Trigger -->
    <button data-target="modal1" class="btn waves-effect waves-light modal-trigger">Modal</button>
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
    #assignedScopeDragTarget  {
        min-height: 150px
    }

    #roleA,#roleB,#roleFinal {
        border: 2px dashed #f60;
        min-height: 100px
    }

</style>
    <script>
        var self = this

        self.hasAssignedScopes = false
        self.stCols = ["hi"]
        self.stTitle ="My Title"
        self.stRows = [[]]

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

        self.emptyUL = (ul) => {

            var lis = ul.getElementsByTagName("li");
            while(lis.length> 0){
                ul.removeChild(lis[0]);
                lis = ul.getElementsByTagName("li");
            }
        }

        self.emptyUL2 = (ul) => {

            var lis = ul.getElementsByTagName("li");
            for(var i = lis.length; i--;){
                if(lis[i].attributes["do-not-remove"]  == undefined){
                    ul.removeChild(lis[i]);
                }
            }
        }
        self.onRemoveScopeItem = (e) =>{
            console.log('onRemoveScopeItem',e.item.name)
            var result = self._itemsAssignedScopes.filter(function( item ) {
                return item.name != e.item.name;
            });
            self._itemsAssignedScopes = result;
            self.update()
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

        self.on('mount', function() {
            // the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
      //      $('.modal-trigger').leanModal();

            Sortable.create(self.grantedScopeDragSource, {
//                handle: ".my-handle",
                filter: ".ignore-elements",
                group: {
                    name: 'scopes',
                    pull: 'clone',
                    put: false
                },
                sort:false
            });

            Sortable.create(self.assignedScopeDragTarget, {
                filter: ".ignore-elements",
                group: {
                    name: 'scopes',
                    pull: false
                },
                sort:false,

                // Element dragging started
                onStart: function (/**Event*/evt) {
                    console.log('onStart',evt);
                },
                onMove: function (evt) {
                    console.log('onMove',evt);
                },
                onFilter: function (/**Event*/evt) {
                    console.log('onFilter',evt);
                },
                // Called by any change to the list (add / update / remove)
                onSort: function (/**Event*/evt) {
                    console.log('onSort',evt);
                    // same properties as onUpdate
                },

                onAdd: function (evt) {
                    var el = evt.item;
                    var newItem = evt.item.attributes["data-item"].value;
                    console.log(newItem);

                    // is it in our backing array
                    var item = self._itemsAssignedScopes.find(x => x.name === newItem);
                    if (item) {
                        console.log("This item already exists");
                    }
                    else {
                        self._itemsAssignedScopes.push({ name: newItem });
                    }
                    self.emptyUL2(self.assignedScopeDragTarget);
                    var temp = self._itemsAssignedScopes;
                    self._itemsAssignedScopes = [];
                    self.update();
                    self._itemsAssignedScopes = temp;
                     self.update();
                }
            });
            /////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////

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
        })
    </script>
</drag-drop2>


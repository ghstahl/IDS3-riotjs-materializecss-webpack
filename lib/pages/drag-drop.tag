
import Sortable from '../js/Sortable.min.js';
<drag-drop>
    <form onsubmit={ updateRoles }>

        <ul class="collection" id="roleA">

            <li each={_itemsRoleA} data-role="{name}" class="collection-item">
                <div>{name}<i class="material-icons">send</i></div>
            </li>
        </ul>

        <ul id="roleB">
            <li each={_itemsRoleB} data-role="{name}">{name}</li>
        </ul>

        <button class="btn waves-effect waves-light" type="submit" name="updateRoles">Submit</button>

    </form>

    <style >


    .sortable-ghost {
        opacity: .3;
        background: #f60;
    }


    #listC,#listD,#roleA,#roleB {
        border: 2px dashed #f60;
        min-height: 100px
    }

</style>
    <script>
        var self = this

        self.updateRoles = () =>{

            console.log(self.roleB)
        }

        self.inPlayItem = null;

        self._itemsRoleA = [
            { name: 'Developer' },
            { name: 'User' }

        ]
        self._itemsRoleB = [
            { name: 'Administrator' }
        ]

        self.on('mount', function() {

            Sortable.create(self.roleA, {
                group: {
                    name: 'roles'
                },
                sort:false,
                onAdd: function (evt) {
                   console.log(evt)
                }
            });


            Sortable.create(self.roleB, {
                group: {
                    name: 'roles'
                },
                sort:false,
                onAdd: function (evt) {

                    console.log(evt)
                }
            });
        })
    </script>
</drag-drop>

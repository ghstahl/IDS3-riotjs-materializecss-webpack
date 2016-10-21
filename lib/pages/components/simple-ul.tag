<simple-ul>
    <ul class="collection" id="myUL">

        <li each={_itemsRoleFinal} class="collection-item avatar">

            <img src="images/graduation.png" alt="" class="circle">
            <span class="title">{name}</span>
            <p>First Line <br>
                Second Line
            </p>

            <a onclick={onRemoveItem}  class="waves-effect secondary-content waves-light "><i class="material-icons">remove</i>
                Remove</a>
        </li>
    </ul>
    <table class="highlight">
        <thead>
        <tr>
            <h5>{title}</h5>
            <th each={ name, i in cols }>{name}</th>
        </tr>
        </thead>
        <tbody>
        <tr each={row in rows }  >
            <td each={ name in row }>{name}</td>
        </tr>
        </tbody>
    </table>


    <script>
        var self = this;
        self.mixin("opts-mixin");

        self.rows = [];

        self.on('mount', function() {
            self.rows = opts.rows;
            console.log('mount:simple-ul',self.title,'cols:',self.cols ,'rows:',self.rows )
        })
        self.on('update', function() {
            self.rows = opts.rows;
            console.log('update:simple-ul',self.title,'cols:',self.cols ,'rows:',self.rows )
        })
    </script>
</simple-ul>
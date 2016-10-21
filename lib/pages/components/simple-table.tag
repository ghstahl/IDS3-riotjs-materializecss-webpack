<simple-table>

    <table class="highlight">
        <thead>
            <tr>
                <h5>{opts.title}</h5>
                <th each={ name, i in opts.cols }>{name}</th>
            </tr>
        </thead>
        <tbody>
            <tr each={row in opts.rows }  >
                <td each={ name in row }>{name}</td>
            </tr>
        </tbody>
    </table>


    <script>
        var self = this;
        self.mixin("opts-mixin");
        // an array of strings ["column1","column2"]
        self.cols = [];
        // an string "My Title"
        self.title = null;

        /*
         An array or string arrays.
         self.scopes = ["offline_acess","api1"]
         self.scopesT =  self.scopes.map(function(item) {
         return ['scope',item];
         });

         [
         ['a','b'],
         ['c','d'],
         ]
         */
        self.rows = [[]];

    </script>
</simple-table>
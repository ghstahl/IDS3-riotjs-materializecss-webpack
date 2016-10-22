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
    </script>
</simple-table>

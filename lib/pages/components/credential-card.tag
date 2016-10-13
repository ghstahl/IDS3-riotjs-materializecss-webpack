<credential-card>


    <p>
        <a onclick={ onRemove }
           data-message={item.friendlyName}
           class="waves-effect waves-light red btn">Remove</a>
    </p>


    <script>
        var self = this;

        self.item = opts.item;
        self.onRemove = opts.onremove;
        self.on('mount', function() {
            console.log('credential-card:self.item',self.item )
            console.log('credential-card:onRemove',self.onRemove )
        })
        $('.collapsible').collapsible({
            accordion : false // A setting that changes the collapsible behavior to expandable instead of the default accordion style
        });
    </script>
</credential-card>
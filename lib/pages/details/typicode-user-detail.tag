import RiotControl from 'riotcontrol';

<typicode-user-detail>
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
                <td>Email</td>
                <td>{ result.email }</td>
            </tr>
            <tr>
                <td>Phone</td>
                <td>{ result.phone }</td>
            </tr>
            <tr>
                <td>UserName</td>
                <td>{ result.username }</td>
            </tr>
            <tr>
                <td>website</td>
                <td>{ result.website }</td>
            </tr>
            </tbody>
        </table>
    </div>

    <div class="s12 l9 col">
        <table class="highlight">
            <thead>
            <tr>
                <th><h5>Address</h5></th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>Suite</td>
                <td>{ result.address.suite }</td>
            </tr>
            <tr>
                <td>Street</td>
                <td>{ result.address.street }</td>
            </tr>
            <tr>
                <td>City</td>
                <td>{ result.address.city }</td>
            </tr>
            <tr>
                <td>Zip Code</td>
                <td>{ result.address.zipcode }</td>
            </tr>

            </tbody>
        </table>
    </div>
    <div class="s12 l9 col">
        <table class="highlight">
            <thead>
            <tr>
                <th><h5>Company</h5></th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>Name</td>
                <td>{ result.company.name }</td>
            </tr>
            <tr>
                <td>Catch Phrase</td>
                <td>{ result.company.catchPhrase }</td>
            </tr>
            <tr>
                <td>Business Statement</td>
                <td>{ result.company.bs }</td>
            </tr>

            </tbody>
        </table>
    </div>

<style>
    #aside {
             width:350px;
         }
</style>
    <script>
        var self = this;

        self.result = {};
        self.onUserChanged = (user) => {
            self.result = user;
            console.log(self.result);
            self.update();
        }

        self.on('unmount', function() {
            console.log('on unmount:');
            RiotControl.off('typicode_user_changed', self.onUserChanged);

        });

        self.on('mount', function() {
            var q = riot.route.query();
            console.log('on mount: typicode-user-detail',q);
            RiotControl.on('typicode_user_changed', self.onUserChanged);

            $('.collapsible').collapsible({
                accordion : false // A setting that changes the collapsible behavior to expandable instead of the default accordion style
            });
            RiotControl.trigger('typicode_user_fetch', { id: q.id });
        });

    </script>
</typicode-user-detail>
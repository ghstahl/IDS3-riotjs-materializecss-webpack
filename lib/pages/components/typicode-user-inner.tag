<typicode-user-inner>

    <h5>User Details</h5>
    <div class="divider"></div>
    <div class="row">
        <div class="input-field col s6">
            <i class="material-icons prefix">account_circle</i>
            <input id="name" value={state.name} type="text" class="validate">
            <label for="name">Name</label>
        </div>
        <div class="input-field col s6">
            <i class="material-icons prefix">account_circle</i>
            <input id="user_name" value={state.username} type="text" class="validate">
            <label for="user_name">User Name</label>
        </div>
    </div>
    <div class="row">
        <div class="input-field col s6">
            <i class="material-icons prefix">email</i>
            <input id="email" value={state.email} type="text" class="validate">
            <label for="email">Email</label>
        </div>
        <div class="input-field col s6">
            <i class="material-icons prefix">phone</i>
            <input id="phone" value={state.phone} type="text" class="validate">
            <label for="phone">Phone</label>
        </div>
    </div>

    <div class="row">
        <div class="input-field col s6">
            <i class="material-icons prefix">cloud</i>
            <input id="website" value={state.website} type="text" class="validate">
            <label for="website">Website</label>
        </div>
    </div>

    <h5>Address</h5>
    <div class="divider"></div>
    <div class="row">
        <div class="input-field col s6">
            <input id="street" value={state.address.street} type="text" class="validate">
            <label for="street">Street</label>
        </div>
        <div class="input-field col s6">
            <input id="suite" value={state.address.suite} type="text" class="validate">
            <label for="suite">Suite</label>
        </div>
    </div>
    <div class="row">
        <div class="input-field col s6">
            <input id="city" value={state.address.city} type="text" class="validate">
            <label for="city">City</label>
        </div>
        <div class="input-field col s6">
            <input id="zipcode" value={state.address.zipcode} type="text" class="validate">
            <label for="zipcode">Zip Code</label>
        </div>
    </div>
    <div class="row">
        <div class="input-field col s6">
            <input id="geolat" value={state.address.geo.lat} type="text" class="validate">
            <label for="geolat">Lattitude</label>
        </div>
        <div class="input-field col s6">
            <input id="geolng" value={state.address.geo.lng} type="text" class="validate">
            <label for="geolng">Longitude</label>
        </div>
    </div>

    <h5>Company</h5>
    <div class="divider"></div>
    <div class="row">
        <div class="input-field col s6">
            <input id="company_name" value={state.company.name} type="text" class="validate">
            <label for="company_name">Company Name</label>
        </div>
        <div class="input-field col s6">
            <input id="company_catchphrase" value={state.company.catchPhrase} type="text" class="validate">
            <label for="company_catchphrase">Catch Phrase</label>
        </div>
    </div>
    <div class="row">
        <div class="input-field col s6">
            <textarea id="company_bs" value={state.company.bs} class="materialize-textarea"></textarea>
            <label for="company_bs">Company BS</label>
        </div>

    </div>

    <style scoped>
        textarea.materialize-textarea {
            max-height: 3rem;
        }
    </style>
    <script>
        var self = this

        self.mixin("opts-mixin");
        self.mixin("shared-observable-mixin");

        self.state = opts.state

        self.on('mount',function(){
            console.log(self.state)
        })
        self.onStateInit = (state) =>{
            self.state = state;
            self.update();
            Materialize.updateTextFields()
        }
        // place mixins here that require stuff to already exist.
        self.mixin("state-init-mixin");
    </script>
</typicode-user-inner>
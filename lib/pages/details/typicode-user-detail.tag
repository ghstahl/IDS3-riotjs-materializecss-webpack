import RiotControl from 'riotcontrol';
import '../components/typicode-user-inner.tag';

<typicode-user-detail>
    <h4>{ result.name }</h4><span> <a class="waves-effect waves-light btn"
                                      onclick={onUserEdit}>Edit User</a></span>
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

    <!-- Modal Structure -->
    <div id="modalUserEdit" class="modal">
        <div class="modal-content">
            <div class="row">
                <form class="col s12">
                    <typicode-user-inner name="user-edit" state={userState}></typicode-user-inner>
              </form>
            </div>
        </div>


        <div class="modal-footer">
            <a class="modal-action modal-close waves-effect waves-green btn">Cancel</a>
            <span> </span>
            <a

                    onclick={onUserSubmit}
                    disabled={formDisabled}
                    class="waves-effect waves-green btn" >Submit</a>
        </div>
    </div>
<style scoped>
    #aside {
             width:350px;
         }
    .modal .modal-footer .btn, .modal .modal-footer .btn-large, .modal .modal-footer .btn-flat {
        float: right;
        margin: 6px 4px;
    }
    .modal { width: 75% !important ; max-height: 100% !important ; overflow-y: hidden !important ;}
</style>
    <script>
        var self = this;
        self.mixin("shared-observable-mixin");

        self.result = {};
        self.onUserChanged = (user) => {
            self.result = user;
            console.log(self.result);
            self.update();
        }
        self.userState = {}
        self.formDisabled = true;

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

        self.onUserEdit = () =>{
            console.log('onUserEdit')
            self.userState = self.result
            self.triggerEvent('user-edit-state-init',[self.userState]);
            $("#modalUserEdit").openModal({
                dismissible: false
            })
        }

        self.onUserSubmit = () =>{
            console.log('onUserSubmit');
            if(!self.formDisabled){

                $("#modalUserEdit").closeModal()
            }
        }


    </script>
</typicode-user-detail>
/**
 * Created by Herb on 9/27/2016.
 */
// TodoStore definition.
// Flux stores house application logic and state that relate to a specific domain.
// In this case, a list of todo items.
import RiotControl from 'riotcontrol';

const baseIdentityServerAdminUrlTest = 'http://localhost:31949/api/v1/IdentityServerAdmin/';

function IdentityServerAdminScopesUsersStore() {
    var self = this
    riot.observable(self) // Riot provides our event emitter.

    self.baseIdentityServerAdminUrl = baseIdentityServerAdminUrlTest;
    self.scopesUsersUrl = null;
    /**
     * Reset tag attributes to hide the errors and cleaning the results list
     */
    self.resetData = function() {

    }

    self.on('app-mount', function() {
        console.log('IdentityServerAdminScopesUsersStore app-mount');
    })

    self.on('app-unmount', function() {
        console.log('IdentityServerAdminScopesUsersStore app-unmount');
    })


    self.on('identityserver-api-baseurl', function(baseurl) {
        var triggerName = 'identityserver-api-baseurl';
        console.log('on',triggerName,baseurl);
        self.baseIdentityServerAdminUrl = baseurl;
        self.scopesUsersUrl = self.baseIdentityServerAdminUrl + 'scopes/users';
        self.trigger(triggerName+'-ack');
    })

    self.on('identityserver-admin-scopes-users-get', function(query) {
        var triggerName = 'identityserver-admin-scopes-users-get';
        console.log('on',triggerName);
        var url = self.scopesUsersUrl + '?userId='+query.userId;
        RiotControl.trigger(
            'fetch',url,
            {
                method: 'GET'
            },
            {name:triggerName +'-result',query:query});
    })

    self.on('identityserver-admin-scopes-users-delete', function(query) {
        var triggerName = 'identityserver-admin-scopes-users-delete';
        console.log('on',triggerName);

        var url = self.scopesUsersUrl   + '?userId='+query.userId
                                        + '?name='+query.name;
        RiotControl.trigger(
            'fetch',url,
            {
                method: 'DELETE'
            },
            {name:triggerName+'-ack',query:query});
    })



    self.on('identityserver-admin-scopes-users-create', function(query) {
        var triggerName = 'identityserver-admin-scopes-users-create';
        console.log('on',triggerName);

        var url = self.scopesUsersUrl;
        RiotControl.trigger(
            'fetch',url,
            {
                method: 'POST',
                body:{
                    userId:query.userId,
                    scopes:query.scopes
                }
            },
            {name:triggerName+'-ack',query:query});
    })
}

if (typeof(module) !== 'undefined') module.exports = IdentityServerAdminScopesUsersStore;



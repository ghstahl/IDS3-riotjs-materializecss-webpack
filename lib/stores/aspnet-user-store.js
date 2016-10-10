/**
 * Created by Herb on 9/27/2016.
 */
// TodoStore definition.
// Flux stores house application logic and state that relate to a specific domain.
// In this case, a list of todo items.
import RiotControl from 'riotcontrol';

const baseAspNetUrl = 'http://localhost:31949/api/v1/IdentityAdmin/';

function AspNetUserStore() {
    var self = this

    riot.observable(self) // Riot provides our event emitter.

    self.fetchException = null;

    /**
     * Reset tag attributes to hide the errors and cleaning the results list
     */
    self.resetData = function() {
        self.fetchException = null;

    }

    self.on('aspnet_roles_fetch', function() {
        console.log('aspnet_roles_fetch:');
        var url = baseAspNetUrl + 'roles';
        RiotControl.trigger('fetch',url,null,{name:'aspnet_roles_changed'});
    })

    self.on('aspnet_roles_create', function(query) {
        console.log('aspnet_roles_create:');
        var url = baseAspNetUrl + 'roles/create?role=' + query.role;
        RiotControl.trigger(
            'fetch',
            url,
            {
                method: 'POST'
            },
            {name:'aspnet_roles_create_ack'});
    })


    self.on('aspnet_roles_delete', function(query) {
        console.log('aspnet_roles_delete:');
        var url = baseAspNetUrl + 'roles/delete?role=' + query.role;
        RiotControl.trigger(
            'fetch',
            url,
            {
                method: 'DELETE'
            },
            {name:'aspnet_roles_delete_ack'});
    })

    // Our store's event handlers / API.
    // This is where we would use AJAX calls to interface with the server.
    // Any number of views can emit actions/events without knowing the specifics of the back-end.
    // This store can easily be swapped for another, while the view components remain untouched.

    self.on('aspnet_users_page', function(query) {
        console.log('aspnet_users_page:');
        self.pagingState = null;
        var ps = '';
        if(query.PagingState)
            ps = query.PagingState;
        var url = baseAspNetUrl + 'users/page/' + query.Page + '?pagingState=' + ps;
        RiotControl.trigger('fetch',url,null,{name:'aspnet_users_page_changed'});
    })

    self.on('aspnet_user_roles_add', function(query) {
        console.log('aspnet_user_roles_add:');
        var url = baseAspNetUrl + 'users/roles/add?role=' + query.role
            +'&id=' + query.id;
        RiotControl.trigger(
            'fetch',
            url,
            {
                method: 'POST'
            },
            {name:'aspnet_user_by_id',query:{id:query.id}});
    })

    self.on('aspnet_user_role_remove', function(query) {
        console.log('aspnet_user_role_remove:');
        var url = baseAspNetUrl + 'users/roles/delete?role=' + query.role
            +'&id=' + query.id;
        RiotControl.trigger(
            'fetch',
            url,
            {
                method: 'DELETE'
            },
            {name:'aspnet_user_by_id',query:{id:query.id}});
    })

    self.on('aspnet_user_by_id', function(query) {
        console.log('aspnet_user_by_id:');
        var url = baseAspNetUrl + 'users/id?id=' + query.id;
        RiotControl.trigger('fetch',url,null,{name:'aspnet_user_changed'});
    })
}

if (typeof(module) !== 'undefined') module.exports = AspNetUserStore;




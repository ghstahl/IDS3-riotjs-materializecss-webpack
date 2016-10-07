/**
 * Created by Herb on 9/27/2016.
 */
// TodoStore definition.
// Flux stores house application logic and state that relate to a specific domain.
// In this case, a list of todo items.

import RiotControl from 'riotcontrol';

const user_cache = 'd861b1ab-d9a6-4a0f-ac5d-ced615611903';

function TypicodeUserStore() {
    riot.observable(this) // Riot provides our event emitter.

    var self = this

    self.fetchException = null;

    /**
     * Reset tag attributes to hide the errors and cleaning the results list
     */
    self.resetData = function() {
        this.fetchException = null;
    }

    // Our store's event handlers / API.
    // This is where we would use AJAX calls to interface with the server.
    // Any number of views can emit actions/events without knowing the specifics of the back-end.
    // This store can easily be swapped for another, while the view components remain untouched.

    self.on(user_cache, function(data) {
        console.log(user_cache);
        console.log(data);
        localStorage.setItem(user_cache, JSON.stringify(data));
        console.log('localStorage get:',localStorage.getItem(user_cache));
        var restoredSession = JSON.parse(localStorage.getItem(user_cache));
        console.log('restoredSession:',restoredSession);
        self.results = restoredSession;
        RiotControl.trigger('typicode_users_fetch_changed', self.results)

    })

    self.on('typicode_users_fetch', function() {
        console.log('typicode_users_fetch:');
        var url = 'http://jsonplaceholder.typicode.com/users';
        RiotControl.trigger('fetch',url,null,{name:'typicode_users_fetch_changed'});
    })

    self.on('typicode_user_fetch', function(query) {
        console.log('typicode_user_fetch:');
        var restoredSession = JSON.parse(localStorage.getItem(user_cache));
        var result = restoredSession.filter(function( obj ) {
            return obj.id == query.id;
        });
        if(result && result.length>0){
            RiotControl.trigger('typicode_user_fetch_changed',result[0]);
        }
    })

    // The store emits change events to any listening views, so that they may react and redraw themselves.

}

if (typeof(module) !== 'undefined') module.exports = TypicodeUserStore;




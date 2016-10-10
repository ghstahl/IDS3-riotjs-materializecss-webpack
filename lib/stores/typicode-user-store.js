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
    self.baseurl = 'http://jsonplaceholder.typicode.com/';
    self.fetchException = null;

    self.on('typicode-baseurl', function(baseurl) {
        console.log('typicode-baseurl:',baseurl);
        self.baseurl = baseurl;
        self.trigger('typicode-baseurl-ack');
    })

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
    
    self.on('typicode_users_fetch', function() {
        console.log('typicode_users_fetch:');
        var url =  self.baseurl + 'users';
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




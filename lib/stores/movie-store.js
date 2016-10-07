/**
 * Created by Herb on 9/27/2016.
 */
// TodoStore definition.
// Flux stores house application logic and state that relate to a specific domain.
// In this case, a list of todo items.
import RiotControl from 'riotcontrol';
function MovieStore() {
    riot.observable(this) // Riot provides our event emitter.

    var self = this

    self.movies = []

    self.lastSearch = null;
    self.error = false;

    /**
     * Reset tag attributes to hide the errors and cleaning the results list
     */
    self.resetData = function() {
        this.movies = [];
        this.error = false;
    }

    // Our store's event handlers / API.
    // This is where we would use AJAX calls to interface with the server.
    // Any number of views can emit actions/events without knowing the specifics of the back-end.
    // This store can easily be swapped for another, while the view components remain untouched.

    self.on('movies_search_fetch_result', function(data) {
        console.log('movies_search_fetch_result:');
        console.log(data);
        localStorage.setItem("movies", JSON.stringify(data.Search));
        console.log('localStorage get:',localStorage.getItem("movies"));
        var restoredSession = JSON.parse(localStorage.getItem('movies'));
        console.log('restoredSession:',restoredSession);
        self.movies = restoredSession;
        self.trigger('movies_changed', self.movies)

    })

    self.on('movies_search', function(value) {
        console.log('movies_search:');
        console.log(value);
        var url = 'http://www.omdbapi.com/?s=' + value.searchTerm;
        RiotControl.trigger('fetch',url,null,{name:'movies_search_fetch_result'});
    })

    self.on('movie_fetch_detail', function(value) {
        console.log('movie_fetch_detail:');
        console.log(value);
        var url = 'http://www.omdbapi.com/?i=' + value.imdbID
            +'&tomatoes=true'
            +'&plot=full';
        RiotControl.trigger('fetch',url,null,{name:'movie_detail'});
    })

    self.on('movies_clear', function() {
        self.movies.clear();
        self.trigger('movies_changed', self.movies)
    })

    self.on('movies_localstorage', function() {
        var stored = localStorage.getItem('movies');
        if(stored && stored !== "undefined"){
            var restoredSession = JSON.parse(stored)
            self.movies = restoredSession
            self.trigger('movies_changed', self.movies)
        }
    })

    // The store emits change events to any listening views, so that they may react and redraw themselves.

}

if (typeof(module) !== 'undefined') module.exports = MovieStore;




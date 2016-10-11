import 'whatwg-fetch';
import RiotControl from 'riotcontrol';
import Sortable from '../js/Sortable.min.js';

<movie-drag-drop>
    <form onsubmit={ search }>
        <label>
          <span>
            Search a movie
          </span>
            <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                <input
                        oninput={ search }
                        onchange={ search }
                        name='s'
                        placeholder='28 Days Later..'
                        type='search' />

            </div>
            <!-- Textfield with Floating Label -->
            </label>
        </form>
        <ul class="collection" id="moviecollection">
            <li each={results} data-imdb="{imdbID}" class="collection-item">
                 {Title}
            </li>
        </ul>
        <ul class="collection" id="movieDetail">
            <li class="collection-item">
                Drag a movie here...
            </li>
            <li  each={movieDetails} class="collection-item">
                 <div id="aside" class="card">
                    <div class="card-image waves-effect waves-block waves-light">
                        <img class="activator" src="{Poster}">
                    </div>
                    <div class="card-content">
                        <span class="card-title activator grey-text text-darken-4">{ Title }<i class="material-icons right">more_vert</i></span>
                        <p><a href="http://www.imdb.com/title/{ imdbID }">IMDB</a></p>
                    </div>
                    <div class="card-reveal">
                        <span class="card-title grey-text text-darken-4">{ Title }<i class="material-icons right">close</i></span>
                        <p>{ Plot }</p>
                    </div>
                </div>
            </li>
        </ul>
    <style >


        #aside {
            width:350px;
        }
    .sortable-ghost {
        opacity: .3;
        background: #f60;
    }


    #roleA,#roleB,#roleFinal {
        border: 2px dashed #f60;
        min-height: 100px
    }

    </style>

    <script>
        var self = this;
        self.lastSearch = null;
        self.error = false;
        self.results = [];

        self.inPlayItem = null;
        self.movieDetails = [];
        /**
         * Reset tag attributes to hide the errors and cleaning the results list
         */
        self.resetData = function() {
            this.results = [];
            this.error = false;
        }

        self.onMoviesChanged = (result)=>{
            console.log('movies_changed:',result);
            self.results = result;
            self.update();
        }

        self.onMovieCacheResult = (result)=>{
            console.log('movie_cache_result:',result);
            if(!result){
                result =  [];
            }
            self.results = result;
            self.update();
        }

        self.onMovieDetail = (movie)=>{
            console.log('movie_detail:',movie);
            self.movieDetails = [];
            self.update();
            self.movieDetails.push(movie);
            self.update();
        }


        self.on('unmount', function() {
            RiotControl.off('movies_changed', self.onMoviesChanged);
            RiotControl.off('movie_cache_result', self.onMovieCacheResult);
            RiotControl.off('movie_detail', self.onMovieDetail);
        });

        self.on('mount', function() {
            var self = this;

            Sortable.create(self.moviecollection, {
                group: {
                    name: 'movies',
                    pull: 'clone',
                    put: false
                },
                sort:false,
                onStart: function (/**Event*/evt) {
                    var newItem = self.results[evt.oldIndex];
                    self.inPlayItem = newItem;
                }
            });
            Sortable.create(self.movieDetail, {
                group: {
                    name: 'movies',
                    pull: false
                },
                sort:false,
                onAdd: function (evt) {
                    var el = evt.item;
                    var imdbID = el.getAttribute("data-imdb");
                    console.log(imdbID);
                    RiotControl.trigger('movie_fetch_detail', { imdbID: imdbID });
                    self.emptyUL(self.movieDetail);
                    self.movieDetails = [];
                    self.update();
                }
            });

            RiotControl.on('movies_changed', self.onMoviesChanged);
            RiotControl.on('movie_cache_result', self.onMovieCacheResult);
            RiotControl.on('movie_detail', self.onMovieDetail);
            RiotControl.trigger('localstorage_get',{key:'moviesCache',trigger:'movie_cache_result'});

        });

        /**
         * Search callback
         */
        self.search = function(e) {
            var searchTerm = this.s.value

            if (searchTerm === undefined || !searchTerm) {
                this.resetData()
            } else if (this.lastSearch != searchTerm && searchTerm.length > 1)  {
                this.resetData()
                this.isLoading = true
                RiotControl.trigger('movies_search', { searchTerm: searchTerm });
                //     this.doApiRequest(searchTerm)
            }

            this.lastSearch = searchTerm
        }


        self.emptyUL = (ul) => {

            var lis = ul.getElementsByTagName("li");
            while(lis.length> 0){
                ul.removeChild(lis[0]);
                lis = ul.getElementsByTagName("li");
            }
        }

    </script>
</movie-drag-drop>

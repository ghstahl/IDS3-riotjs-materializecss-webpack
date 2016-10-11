import 'whatwg-fetch';
import RiotControl from 'riotcontrol';

import Sortable from '../js/Sortable.min.js';
<home>
      <form onsubmit={ search }>
          <span>
            Search a movie
          </span>
          <!-- Textfield with Floating Label -->



          <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
          <input
                    oninput={ search }
                    onchange={ search }
                    name='s'
                    placeholder='28 Days Later..'
                    type='search' />

        </div>

        <div if={ results.length }>
          <table class=" ">
            <thead>
            <tr>
              <th class="mdl-data-table__cell--non-numeric">Title</th>
              <th>Year</th>
              <th>Details</th>
            </tr>
            </thead>
            <tbody>
            <tr each={ this.results }>
              <td class="mdl-data-table__cell--non-numeric">{ this.Title }</td>
              <td>{ this.Year }</td>
              <td>
                <a href="#movie-detail/?imdbID={imdbID}" class="btn-floating btn-small waves-effect waves-light red"><i class="material-icons">more</i></a>
              </td>
            </tr>
            </tbody>
          </table>
        </div>
          <p class='error' if={ error }>{ error }</p>

          <div if={ results.length }>
            <ul>
              <li each={ results }>
                <div id="aside" class="card">
                  <div class="card-image waves-effect waves-block waves-light">
                    <img class="activator" src="{Poster}">
                  </div>
                  <div class="card-content">
                    <span class="card-title activator grey-text text-darken-4">{ Title }<i class="material-icons right">more_vert</i></span>
                    <p><a href="http://www.imdb.com/title/{ imdbID }">IMDB</a></p>
                  </div>
                  <div class="card-reveal">
                    <span class="card-title grey-text text-darken-4">Card Title<i class="material-icons right">close</i></span>
                    <p>Here is some more information about this product that is only revealed once clicked on.</p>
                  </div>
                </div>
                <span>{ Year }</span>
              </li>
            </ul>
          </div>
<style>
  #aside {
    width:350px;
  }
</style>

  <script >
    var self = this;
    self.lastSearch = null;
    self.error = false;
    self.results = [];
    /**
     * Reset tag attributes to hide the errors and cleaning the results list
     */
    self.resetData = function() {
      self.results = [];
      self.error = false;
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

    self.on('unmount', function() {
      RiotControl.off('movies_changed', self.onMoviesChanged);
      RiotControl.off('movie_cache_result', self.onMovieCacheResult);

    });

    self.on('mount', function() {
      var self = this;
      RiotControl.on('movies_changed', self.onMoviesChanged);
      RiotControl.on('movie_cache_result', self.onMovieCacheResult);
      RiotControl.trigger('localstorage_get',{key:'moviesCache',trigger:'movie_cache_result'});
    });

    /**
     * Search callback
     */
    self.search = function(e) {
      var searchTerm = this.s.value

      if (searchTerm === undefined || !searchTerm) {
        self.resetData()
      } else if (this.lastSearch != searchTerm && searchTerm.length > 1)  {
        self.resetData()
        self.isLoading = true
        RiotControl.trigger('movies_search', { searchTerm: searchTerm });
   //     this.doApiRequest(searchTerm)
      }

      self.lastSearch = searchTerm
    }
    self.detailedSearch = function(imdbID) {
      var searchTerm = this.s.value

      if (searchTerm === undefined || !searchTerm) {

      } else if (this.lastSearch != searchTerm && searchTerm.length > 1)  {
        self.resetData()
        self.isLoading = true
        RiotControl.trigger('movie_fetch_detail', { imdbID: imdbID });
        //     this.doApiRequest(searchTerm)
      }

      self.lastSearch = searchTerm
    }
  </script>

</home>



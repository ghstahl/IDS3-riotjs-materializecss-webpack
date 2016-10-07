import 'whatwg-fetch';
import RiotControl from 'riotcontrol';

import Sortable from '../js/Sortable.min.js';
<home>
      <form onsubmit={ search }>
        <label>
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
          <table class="mdl-data-table mdl-js-data-table mdl-data-table--selectable mdl-shadow--2dp">
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
                <a href="#movie-detail?imdbID={imdbID}" class="btn-floating btn-small waves-effect waves-light red"><i class="material-icons">more</i></a>
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
    this.lastSearch = null;
    this.error = false;
    this.results = [];
    /**
     * Reset tag attributes to hide the errors and cleaning the results list
     */
    this.resetData = function() {
      this.results = [];
      this.error = false;
    }

    this.on('mount', function() {
      var self = this;
      RiotControl.on('movies_changed', function(movies) {
        self.results = movies;
        console.log('_handleMoviesChanged');
        console.log(self.results);
        self.update();
      });
      RiotControl.trigger('movies_localstorage');
    });

    /**
     * Search callback
     */
    this.search = function(e) {
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
    this.detailedSearch = function(imdbID) {
      var searchTerm = this.s.value

      if (searchTerm === undefined || !searchTerm) {
        this.resetData()
      } else if (this.lastSearch != searchTerm && searchTerm.length > 1)  {
        this.resetData()
        this.isLoading = true
        RiotControl.trigger('movie_fetch_detail', { imdbID: imdbID });
        //     this.doApiRequest(searchTerm)
      }

      this.lastSearch = searchTerm
    }
  </script>

</home>



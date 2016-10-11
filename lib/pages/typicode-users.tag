import 'whatwg-fetch';
import RiotControl from 'riotcontrol';

import Sortable from '../js/Sortable.min.js';

<typicode-users>
      <form onsubmit={ search }>
        <div if={ results.length }>
          <div class="card  ">
            <div class="card-content  ">
              <span class="card-title">Users</span>
          <table class=" ">
            <thead>
            <tr>
              <th class="mdl-data-table__cell--non-numeric">Name</th>
              <th>username</th>
              <th>email</th>
              <th>details</th>
            </tr>
            </thead>
            <tbody>
            <tr each={ this.results }>
              <td class="mdl-data-table__cell--non-numeric">{ this.name }</td>
              <td>{ this.username }</td>
              <td>{ this.email }</td>
              <td>
                <a href="#typicode-user-detail?id={id}" class="btn-floating btn-small waves-effect waves-light red"><i class="material-icons">more</i></a>
              </td>
            </tr>
            </tbody>
          </table>
        </div>
          </div>
        </div>


<style>
  #aside {
    width:350px;
  }
</style>

  <script >
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
      RiotControl.on('typicode_users_changed', function(result) {
        console.log('typicode_users_changed');
        self.results = result;
        console.log(self.results);
        self.update();
      });
      RiotControl.trigger('typicode_users_fetch');
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

</typicode-users>



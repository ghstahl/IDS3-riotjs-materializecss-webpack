import 'whatwg-fetch';
import RiotControl from 'riotcontrol';

import Sortable from '../js/Sortable.min.js';

<aspnet-users>
  <table class="highlight">
    <thead>
    <tr>
      <th>UserName</th>
      <th>Email</th>
      <th>details</th>
    </tr>
    </thead>
    <tbody>
    <tr each={ this.results.Records }>

      <td>{ UserName }</td>
      <td>{ Email }</td>
      <td>
        <a href="#aspnet-user-detail?id={Id}"
           class="btn-floating btn-small waves-effect waves-light red">
          <i class="material-icons">more</i></a>
      </td>
    </tr>
    </tbody>
  </table>


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
      RiotControl.on('aspnet_users_page_changed', function(result) {
        self.results = result;
        console.log('aspnet_users_page_changed:',self.results);
        self.update();
      });
      RiotControl.trigger('aspnet_users_page',{Page:9,PagingState:null});
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

</aspnet-users>



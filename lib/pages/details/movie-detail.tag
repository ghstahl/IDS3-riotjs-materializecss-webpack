import RiotControl from 'riotcontrol';

<movie-detail>

    <div id="aside" class="card">
        <div class="card-image waves-effect waves-block waves-light">
            <img class="activator" src="{result.Poster}">
        </div>
        <div class="card-content">
            <span class="card-title activator grey-text text-darken-4">{ result.Title }<i class="material-icons right">more_vert</i></span>
            <p><a href="http://www.imdb.com/title/{ result.imdbID }">IMDB</a></p>
        </div>
        <div class="card-reveal">
            <span class="card-title grey-text text-darken-4">{ result.Title }<i class="material-icons right">close</i></span>
            <p>{ result.Plot }</p>
        </div>
    </div>
<style>
    #aside {
             width:350px;
         }
</style>
    <script>
        this.result = {};
        this.on('mount', function() {
            var self = this;
            var q = riot.route.query();
            console.log('on mount: movie-detail',q);
            RiotControl.on('movie_detail', function(movie) {
                self.result = movie;
                console.log(self.result);
                self.update();
            });
            RiotControl.trigger('movie_fetch_detail', { imdbID: q.imdbID });
        });
    </script>
</movie-detail>
import '../layouts/sidebar-materializecss.tag';
import '../components/loading-indicator.tag';

<app>
    <loading-indicator></loading-indicator>
    <sidebar-materializecss title={this.title} menuItems = {this.menuItems}>
        <yield to="content">
            <div id="riot-subview"></div>
        </yield>
    </sidebar-materializecss>

    <script >
        this.on('mount', function(){

            console.log('app Mounted') // Succeeds, fires once (per mount)
        })
        this.title = "Developer"
        this.menuItems = [
            {name:'Typicode Users',href:'#typicode-users',view:'typicode-users'},
            {name:'AspNet Users',href:'#aspnet-users',view:'aspnet-users'},
            {name:'Movies',href:'#home',view : 'home',materialIcon:'toll'},
            {name:'Name 2',href:'#projects',view : 'projects'},
            {name:'Drag&Drop',href:'#drag-drop',view : 'drag-drop'},
            {name:'Drag&Drop2',href:'#drag-drop2',view : 'drag-drop2'},
            {name:'Movie Drag Drop',href:'#movie-drag-drop',view : 'movie-drag-drop'}



        ]
    </script>

</app>


import '../layouts/sidebar-materializecss.tag';
import '../components/loading-indicator.tag';
import RiotControl from 'riotcontrol';
<app>
    <loading-indicator></loading-indicator>
    <sidebar-materializecss title={this.title} menuItems = {this.menuItems}>
        <yield to="content">
            <div id="riot-subview"></div>
        </yield>
    </sidebar-materializecss>

    <script >
        var self = this;

        self.aspnetbaseurl = opts.aspnetbaseurl;
        self.typicodebaseurl = opts.typicodebaseurl;

        this.on('before-mount', function() {
            // before the tag is mounted
            console.log('app before-mount',self.aspnetbaseurl,self.typicodebaseurl) // Succeeds, fires once (per mount)
            RiotControl.trigger('aspnet-api-baseurl',self.aspnetbaseurl);
            RiotControl.trigger('typicode-baseurl',self.typicodebaseurl);
        })

        self.on('mount', function(){
            console.log('app mount') // Succeeds, fires once (per mount)
        })
        this.title = "Developer"
        this.menuItems = [
            {name:'Typicode Users',href:'#typicode-users',view:'typicode-users'},
            {name:'AspNet Users',href:'#aspnet-users',view:'aspnet-users'},
            {name:'AspNet Roles',href:'#aspnet-roles',view : 'aspnet-roles'},
            {name:'Movies',href:'#home',view : 'home',materialIcon:'toll'},
            {name:'Name 2',href:'#projects',view : 'projects'},
            {name:'Drag&Drop',href:'#drag-drop',view : 'drag-drop'},
            {name:'Drag&Drop2',href:'#drag-drop2',view : 'drag-drop2'},
            {name:'Movie Drag Drop',href:'#movie-drag-drop',view : 'movie-drag-drop'},
            {name:'ToDo:riotux',href:'#todo',view : 'todo'},
            {name:'roles',href:'#roles',view : 'roles'},
            {name:'Client Credentials',href:'#client-credentials',view : 'client-credentials'}

        ]
    </script>

</app>


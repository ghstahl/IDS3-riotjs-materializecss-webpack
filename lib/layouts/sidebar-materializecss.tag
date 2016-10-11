
import '../js/ba-tiny-pubsub.js';
<sidebar-materializecss>
    <header>
    <nav class="top-nav">

        <div class="container">

            <div class="nav-wrapper">
                <ul class="right">
                    <li><a href="/Identity/Logoff">Sign Out</a></li>
                </ul>
                <a class="page-title middle hide-on-med-and-down">{title}</a>
            </div>
        </div>
    </nav>
    <div class="container">
        <a href="#" data-activates="nav-mobile" class="button-collapse top-nav full hide-on-large-only">
            <i class="material-icons">menu</i>
        </a>
    </div>
    <ul id="nav-mobile" class="side-nav fixed">
        <li>
            <a href="/">Home</a>
        </li>
        <li each={ parent.menuItems }>
            <a href={this.href}>{ this.name }</a>
        </li>
    </ul>
    </header>
    <main>
        <div class="container">
            <div class="row">
                <div class="col s12 m9 l10">
                    <yield from="content"/>
                </div>
            </div>
        </div>
    </main>


    <style>
        header, main, footer {
            padding-left: 600px;
        }

        @media only screen and (max-width : 992px) {
            header, main, footer {
                padding-left: 0;
            }
        }
    </style>
    this.onRoute =()=>{
        return function(_, a, b) {
            // Skip the first argument (event object) but log the name and other args.
            $('.button-collapse').sideNav('hide');
        };
    }
    this.title = opts.title
    this.menuItems = opts.menuItems;

    this.on('mount', function() {
        $('.button-collapse').sideNav({
            menuWidth: 300, // Default is 240
         //   closeOnClick: true // Closes side-nav on <a> clicks, useful for Angular/Meteor
        });

        $.subscribe('route', this.onRoute());

    })


</sidebar-materializecss>
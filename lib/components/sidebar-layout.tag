import './loading-indicator.tag';
import './nav-bar.tag';
import './sidebar-layout.css';

<sidebar-layout>
    <loading-indicator></loading-indicator>

    <div id="wrapper" class="toggled">
        <!-- Sidebar -->
        <div id="sidebar-wrapper">
            <ul class="sidebar-nav">
                <li each={ parent.menuItems } >
                    <a href="{this.href}"
                       class={ active : parent.currentView === this.view}
                    >{ this.name }</a>
                </li>
            </ul>
        </div>
        <!-- /#sidebar-wrapper -->
        <nav-bar>
            <yield to="hamburger-li">
                <li><a href="#" onclick={parent.toggle}><span class="glyphicon glyphicon-menu-hamburger" aria-hidden="true"></span></a></li>
            </yield>
        </nav-bar>
        <!-- Page Content -->
        <div id="page-content-wrapper">

            <div class="container-fluid">
                <div class="row">

                    <div class="col-lg-12">
                        <yield from="content"/>

                    </div>
                </div>
            </div>
        </div>
        <!-- /#page-content-wrapper -->

    </div>
    <script>
        var self = this;
        self.title = opts.title
        self.menuItems = opts.menuItems;
        <!-- /#wrapper -->
        self.toggle = (e) => {
            e.preventDefault();
            $("#wrapper").toggleClass("toggled");
        }
        self.route = (evt) => {
            riot.route(evt.item.view)
        };
    </script>
</sidebar-layout>




/**
 * Created by Herb on 9/26/2016.
 */
import './pages/home.tag'
import './pages/projects.tag'
import './pages/details/movie-detail.tag'
import './pages/drag-drop.tag'
import './pages/drag-drop2.tag'
import './pages/typicode-users.tag'
import './pages/details/typicode-user-detail.tag'
import './pages/movie-drag-drop.tag'

import './pages/roles.tag'
import './pages/client-credentials.tag'
import './js/ba-tiny-pubsub.js';
import './pages/aspnet-users.tag'
import './pages/details/aspnet-user-detail.tag'
import './pages/aspnet-roles.tag'
import './pages/identity-server-scopes.tag'

// we need this to easily check the current route from every component
riot.routeState = {
    view : ''
};

class Router{

    constructor(){
        this._currentView = null;
        this._views = [
            'aspnet-users',
            'aspnet-user-detail',
            'aspnet-roles',
            'home',
            'projects',
            'movie-detail',
            'drag-drop',
            'drag-drop2',
            'movie-drag-drop',
            'typicode-users',
            'typicode-user-detail',

            'roles',
            'client-credentials',
            'identity-server-scopes'
        ];

        this._defaultView = 'home';

        riot.route(this._handleRoute.bind(this));
        riot.route.start(true);
        riot.observable(this)
    }

    _handleRoute(view){

        // load default view, if view is not in views list
        if(this._views.indexOf(view) === -1){
            return riot.route(this._defaultView);
        }

        this._loadView(view);
        $.publish('route', [1, 2]);

//
    }

    _loadView(view){
        if (this._currentView) {
            this._currentView.unmount(true);
        }

        riot.routeState.view = view;
        this._currentView = riot.mount('#riot-subview', view)[0];
    }

}

export default new Router();
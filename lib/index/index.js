
import RiotControl from 'riotcontrol';
import riotux from 'riotux';

import '../js/materialize.js';
import '../css/materialize.css';
import './app.tag';
import './index.scss';

import TodoStore from '../riotux/store.js';
import TodoAction from '../riotux/actions.js';

import MovieStore from '../stores/movie-store.js';
import ProgressStore from '../stores/progress-store.js';
import TypicodeUserStore from '../stores/typicode-user-store.js';
import FetchStore from '../stores/fetch-store.js';
import RoleStore from '../stores/role-store.js';
import ClientCredentialStore from '../stores/client-credential-store.js';
import LocalStorageStore from '../stores/localstorage-store.js';
import AspNetUserStore from '../stores/aspnet-user-store.js';



RiotControl.addStore(new ClientCredentialStore("client-credential"))
RiotControl.addStore(new ClientCredentialStore("role"))
RiotControl.addStore(new RoleStore())
RiotControl.addStore(new LocalStorageStore())
RiotControl.addStore(new ProgressStore())
RiotControl.addStore(new FetchStore())
RiotControl.addStore(new TypicodeUserStore())
RiotControl.addStore(new MovieStore())
RiotControl.addStore(new AspNetUserStore())

var todoStore = riotux.Store(new TodoStore());
var todoAction = riotux.Actions(new TodoAction());


riot.mount('app');
import '../router.js';
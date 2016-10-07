
import '../js/materialize.js';
import '../css/materialize.css';
import './app.tag';
import './index.scss';

import MovieStore from '../stores/movie-store.js';
import ProgressStore from '../stores/progress-store.js';
import TypicodeUserStore from '../stores/typicode-user-store.js';
import FetchStore from '../stores/fetch-store.js';
import AspNetUserStore from '../stores/aspnet-user-store.js';

import RiotControl from 'riotcontrol';

var progressStore = new ProgressStore(); // Create a store instance.
RiotControl.addStore(progressStore)

var fetchStore = new FetchStore(); // Create a store instance.
RiotControl.addStore(fetchStore)

var typicodeUserStore = new TypicodeUserStore(); // Create a store instance.
RiotControl.addStore(typicodeUserStore)

var movieStore = new MovieStore(); // Create a store instance.
RiotControl.addStore(movieStore)

var aspNetUserStore = new AspNetUserStore(); // Create a store instance.
RiotControl.addStore(aspNetUserStore)


riot.mount('app');
import '../router.js';
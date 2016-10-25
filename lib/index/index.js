// materialize-css css first, then js, then your riot stuff
import 'materialize-css/dist/css/materialize.css'
import 'materialize-css/dist/js/materialize.js'

//import '../css/materialize.css';
//import '../js/materialize.js';

import RiotControl from 'riotcontrol';
import './app.tag';
import './index.scss';

import OptsMixin                            from '../mixins/opts-mixin.js'
import TestMixin                            from '../mixins/test-mixin.js'
import RiotLifeCycleMixin                   from '../mixins/riot-lifecycle-mixin.js'
import RiotControlRegistrationMixin         from '../mixins/riotcontrol-registration-mixin.js'
import SharedObservableMixin                from '../mixins/shared-observable-mixin.js'
import StateInitMixin                       from '../mixins/state-init-mixin.js'


import TodoStore                            from '../riotux/store.js';
import TodoAction                           from '../riotux/actions.js';

import MovieStore                           from '../stores/movie-store.js';
import ProgressStore                        from '../stores/progress-store.js';
import TypicodeUserStore                    from '../stores/typicode-user-store.js';
import FetchStore                           from '../stores/fetch-store.js';
import RoleStore                            from '../stores/role-store.js';
import LocalStorageItemsStore               from '../stores/localstorage-items-store.js';
import LocalStorageStore                    from '../stores/localstorage-store.js';
import AspNetUserStore                      from '../stores/aspnet-user-store.js';
import IdentityServerAdminUsersStore        from '../stores/identityserver-admin-users-store.js';
import IdentityServerAdminScopesStore       from '../stores/identityserver-admin-scopes-store.js';
import IdentityServerAdminScopesUsersStore  from '../stores/identityserver-admin-scopes-users-store.js';


RiotControl.addStore(new LocalStorageItemsStore("client-credential"))
RiotControl.addStore(new LocalStorageItemsStore("role"))
RiotControl.addStore(new RoleStore())
RiotControl.addStore(new LocalStorageStore())
RiotControl.addStore(new ProgressStore())
RiotControl.addStore(new FetchStore())
RiotControl.addStore(new TypicodeUserStore())
RiotControl.addStore(new MovieStore())
RiotControl.addStore(new AspNetUserStore())
RiotControl.addStore(new IdentityServerAdminUsersStore())
RiotControl.addStore(new IdentityServerAdminScopesStore())
RiotControl.addStore(new IdentityServerAdminScopesUsersStore())


riot.mixin("opts-mixin",OptsMixin);
riot.mixin("test-mixin",TestMixin);
riot.mixin("riot-lifecycle-mixin",RiotLifeCycleMixin);
riot.mixin("riotcontrol-registration-mixin",RiotControlRegistrationMixin);
riot.mixin("shared-observable-mixin",SharedObservableMixin);
riot.mixin("state-init-mixin",StateInitMixin);


riot.mount('app');
import '../router.js';



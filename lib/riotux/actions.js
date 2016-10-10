function TodoAction() {

  var self = this

  self.add_todo = function ( store, todo ) {
    store.dispatch('add_todo', todo);
  }

  self.remove_task = function( store, task) {
    store.dispatch('remove_task', task);
  }
}
if (typeof(module) !== 'undefined') module.exports = TodoAction;

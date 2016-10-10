function TodoStore() {
  var self = this

  self.state = {todos: []};
  self.mutations= {
    add_todo: function ( state, todo ) {
      console.log('The state #todos are changed.');
      self.state.todos.push(todo);
    },
    remove_task: function ( state, index ) {
      console.log('The state #todos are changed.');
      var item = self.state.todos.indexOf(index);
      self.state.todos.splice(index, 1);
    }
  }
}
if (typeof(module) !== 'undefined') module.exports = TodoStore;

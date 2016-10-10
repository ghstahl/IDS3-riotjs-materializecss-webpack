import riotux from "riotux";


<todo>
    <div class="container">
        <h1> riotux Todo App </h1>
        <input type="text" placeholder="Add your task" class="input-add" name="task">
        <button class="btn-add" onclick={ add_task }>Add task</button>

        <div class="tasks-container" if = { todos.length > 0 }>
            <h3>Tasks:</h3>
            <ul class="list-tasks">
                <li each = { todos } onclick={ remove_task} class="task">
                    { name }
                </li>
            </ul>
        </div>
    </div>
    <script>
        var self = this;
        self.riotux = riotux;

        riotux.subscribe(self, ['todos'], function ( state_name, value ){
            self.update()
        });

        self.add_task = function ( ) {
            self.riotux.action('todos', 'add_todo', { name: self.task.value });
            self.task.value = "";
        };

        self.remove_task = function ( e ) {
            self.todos.forEach( function ( el, index ) {
                if (el.name === e.item.name) {
                    self.riotux.action('todos', 'remove_task', index);
                    return;
                }
            });
        };

        self.on('update', function ( ) {
            self.todos = self.riotux.get('todos');
        });
    </script>
</todo>
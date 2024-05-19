import { LightningElement, track } from 'lwc';

export default class TodoApp extends LightningElement {
    @track todos = [];
    todoInput = '';

    getLabel(){
        
    }

    handleInputChange(event) {
        this.todoInput = event.target.value;
    }

    handleAddTodo() {
        if (this.todoInput) {
            this.todos.push({
                id: new Date().getTime(),
                text: this.todoInput,
                completed: false
            });
            this.todoInput = '';
        }
    }

    handleToggleComplete(event) {
        const todoId = event.target.dataset.id;
        this.todos = this.todos.map(todo =>
            todo.id === todoId ? { ...todo, completed: !todo.completed } : todo
        );
    }

    handleRemoveTodo(event) {
        const todoId = event.target.dataset.id;
        this.todos = this.todos.filter(todo => todo.id !== todoId);
    }
}

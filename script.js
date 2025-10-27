function addTask() {
  const taskInput = document.getElementById('taskInput');
  const taskText = taskInput.value.trim();

  // Улучшенная валидация
  if (taskText === '') {
    showNotification('Введите текст задачи!', 'error');
    return;
  }

  if (taskText.length > 100) {
    showNotification('Задача не должна превышать 100 символов', 'warning');
    return;
  }

  // Создаём новый элемент списка
  const taskList = document.getElementById('taskList');
  const li = document.createElement('li');
  li.className = 'task-item';
  li.innerHTML = `
    <span class="task-text">${escapeHtml(taskText)}</span>
    <div class="task-actions">
      <button class="complete-btn" onclick="toggleComplete(this)">✓</button>
      <button class="delete-btn" onclick="deleteTask(this)">✕</button>
    </div>
  `;
  
  taskList.appendChild(li);

  // Очищаем поле ввода
  taskInput.value = '';
  taskInput.focus();
  
  // Сохраняем в localStorage
  saveTasks();
  
  showNotification('Задача добавлена!', 'success');
}

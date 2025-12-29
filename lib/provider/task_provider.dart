import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_api/data/api_service.dart';
import 'package:task_manager_api/data/task_model.dart';

class TaskNotifier extends StateNotifier<List<Task>> {
  final ApiService _apiService;

  TaskNotifier(this._apiService) : super([]) {
    loadTasks();
  }
  // LOAD ALL TASKS (GET)
  Future<void> loadTasks() async {
    try {
      final tasks = await _apiService.getTasks();
      state = tasks;
    } catch (e) {
      print('Error loading tasks: $e');
    }
  }

  // ADD TASK
  Future<void> addTask(String title, String description) async {
    try {
      final newTask = Task(
        id: '',
        title: title,
        description: description,
        createdAt: DateTime.now(),
        isCompleted: false,
      );

      final savedTask = await _apiService.addTask(newTask);
      state = [...state, savedTask];
    } catch (e) {
      print('Error adding task: $e');
      rethrow;
    }
  }

  // Check Box (PUT)
  Future<void> checkTaskStatus(Task task) async {
    try {
      final updateTask = task.copyWith(isCompleted: !task.isCompleted);

      state = [
        for (final t in state)
          if (t.id == task.id) updateTask else t,
      ];

      await _apiService.updateTask(updateTask);
    } catch (e) {
      loadTasks();
      print('Error checking task: $e');
    }
  }

  // DELETE TASK
  Future<void> deleteTask(String taskId) async {
    final previousState = state;
    try {
      state = state.where((t) => t.id != taskId).toList();

      await _apiService.deleteTask(taskId);
    } catch (e) {
      state = previousState;
      print('Error deleting task: $e');
    }
  }
}

// PROVIDER
final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  final apiService = ApiService();
  return TaskNotifier(apiService);
});

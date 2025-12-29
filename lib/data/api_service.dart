import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_manager_api/data/task_model.dart';

class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}

// GET
class ApiService {
  final String baseUrl =
      'https://695268073b3c518fca128b4a.mockapi.io/taskapi/tasks';

  Future<List<Task>> getTasks() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Task.fromJson(json)).toList();
      } else {
        throw ApiException('Failed to load tasks: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Error fetching tasks: $e');
    }
  }

  // POST
  Future<Task> addTask(Task task) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(task.toJson()),
      );

      if (response.statusCode == 201) {
        return Task.fromJson(json.decode(response.body));
      } else {
        throw ApiException('Failed to add task: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Error adding task: $e');
    }
  }

  // PUT
  Future<void> updateTask(Task task) async {
    try {
      final url = '$baseUrl/${task.id}';
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(task.toJson()),
      );

      if (response.statusCode != 200) {
        throw ApiException('Failed to update task: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Error updating task: $e');
    }
  }

  // DELETE
  Future<void> deleteTask(String id) async {
    try {
      final url = '$baseUrl/$id';
      final response = await http.delete(Uri.parse(url));

      if (response.statusCode != 200) {
        throw ApiException('Failed to delete task: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Error deleting task: $e');
    }
  }
}

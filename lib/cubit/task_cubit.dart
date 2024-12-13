import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fbase/repository/tasks_repository.dart';
import 'package:fbase/model/task_model.dart';
import 'package:fbase/cubit/task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TasksRepository _repository;

  TaskCubit(this._repository) : super(TaskInitial());

  void loadTasks() {
    emit(TaskLoading());
    _repository.getTasks().listen(
      (tasks) {
        emit(TaskLoaded(tasks));
      },
      onError: (error) {
        emit(TaskError('Ошибка загрузки задач: $error'));
      },
    );
  }
  Future<void> addTask(String title, String description) async {
    try {
      await _repository.addTask(title, description);
      loadTasks();
    } catch (e) {
      emit(TaskError('Не удалось добавить задачу: $e'));
    }
  }

  Future<void> toggleTaskCompletion(TaskModel task) async {
    try {
      final updatedTask = TaskModel(
        id: task.id,
        title: task.title,
        description: task.description,
        isCompleted: !task.isCompleted,
        createdAt: task.createdAt,
      );
      await _repository.updateTask(updatedTask);
    } catch (e) {
      emit(TaskError('Не удалось обновить задачу: $e'));
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _repository.deleteTask(taskId);
      loadTasks();
    } catch (e) {
      emit(TaskError('Не удалось удалить задачу: $e'));
    }
  }
}
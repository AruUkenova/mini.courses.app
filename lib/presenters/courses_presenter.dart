import 'package:flutter/material.dart';
import '../models/course.dart';
import '../repositories/courses_repository.dart';

class CoursesPresenter extends ChangeNotifier {
  final CoursesRepository repository;

  bool loading = false;
  String? error;
  List<Course> courses = [];

  CoursesPresenter(this.repository);

  Future<void> loadCourses() async {
    loading = true;
    notifyListeners();

    try {
      courses = await repository.getCourses();
    } catch (e) {
      error = "Courses load error";
    }

    loading = false;
    notifyListeners();
  }
}
import 'package:flutter/foundation.dart';
import '../models/course.dart';
import '../repositories/courses_repository.dart';

class CoursesVm {
  final bool loading;
  final String? error;
  final List<Course> courses;

  const CoursesVm({this.loading = false, this.error, this.courses = const []});

  CoursesVm copy({bool? loading, String? error, List<Course>? courses}) =>
      CoursesVm(
        loading: loading ?? this.loading,
        error: error,
        courses: courses ?? this.courses,
      );
}

class CoursesController extends ChangeNotifier {
  final CoursesRepository _repo;
  CoursesVm vm = const CoursesVm();

  CoursesController(this._repo);

  Future<void> load() async {
    vm = vm.copy(loading: true, error: null);
    notifyListeners();

    try {
      final list = await _repo.getCourses();
      vm = vm.copy(loading: false, courses: list);
    } catch (_) {
      vm = vm.copy(loading: false, error: "Курстар жүктелмеді");
    }

    notifyListeners();
  }
}
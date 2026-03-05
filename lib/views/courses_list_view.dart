import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/courses_controller.dart';
import '../repositories/auth_repository.dart';
import 'course_details_view.dart';

class CoursesListView extends StatefulWidget {
  const CoursesListView({super.key});

  @override
  State<CoursesListView> createState() => _CoursesListViewState();
}

class _CoursesListViewState extends State<CoursesListView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<CoursesController>().load());
  }

  @override
  Widget build(BuildContext context) {
    final c = context.watch<CoursesController>();
    final vm = c.vm;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Women Mini-Courses (MVC)"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => context.read<AuthRepository>().logout(),
          ),
        ],
      ),
      body: Builder(
        builder: (_) {
          if (vm.loading) return const Center(child: CircularProgressIndicator());
          if (vm.error != null) return Center(child: Text(vm.error!));
          if (vm.courses.isEmpty) return const Center(child: Text("Курс жоқ"));

          return ListView.separated(
            itemCount: vm.courses.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (_, i) {
              final course = vm.courses[i];
              return ListTile(
                title: Text(course.title),
                subtitle: Text(course.category),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CourseDetailsView(course: course)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
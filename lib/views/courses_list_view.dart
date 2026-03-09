import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../presenters/courses_presenter.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<CoursesPresenter>().loadCourses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final c = context.watch<CoursesPresenter>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Women Mini-Courses (MVP)"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => context.read<AuthRepository>().logout(),
          ),
        ],
      ),
      body: Builder(
        builder: (_) {
          if (c.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (c.error != null) {
            return Center(child: Text(c.error!));
          }

          if (c.courses.isEmpty) {
            return const Center(child: Text("Курс жоқ"));
          }

          return ListView.separated(
            itemCount: c.courses.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (_, i) {
              final course = c.courses[i];
              return ListTile(
                title: Text(course.title),
                subtitle: Text(course.category),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CourseDetailsView(course: course),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
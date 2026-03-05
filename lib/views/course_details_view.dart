import 'package:flutter/material.dart';
import '../models/course.dart';

class CourseDetailsView extends StatelessWidget {
  final Course course;
  const CourseDetailsView({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(course.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(course.category, style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            Text(course.description),
            const SizedBox(height: 16),
            const Text("Lessons (placeholder)", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text("Firestore қоссаң — осы жерге lessons list шығарамыз."),
          ],
        ),
      ),
    );
  }
}
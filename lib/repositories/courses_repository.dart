import '../models/course.dart';

class CoursesRepository {
  Future<List<Course>> getCourses() async {
    // имитация жүктеу
    await Future.delayed(const Duration(milliseconds: 200));

    return const [
      Course(
        id: "c1",
        title: "Self-care basics",
        category: "Wellness",
        description: "Ұйқы, стресс, энергияны басқарудың негіздері.",
      ),
      Course(
        id: "c2",
        title: "Financial basics",
        category: "Finance",
        description: "Бюджет, жинақ, мақсат қою, әдеттер.",
      ),
      Course(
        id: "c3",
        title: "Confidence & Communication",
        category: "Mindset",
        description: "Сенімділік, шекара қою, коммуникация.",
      ),
    ];
  }
}
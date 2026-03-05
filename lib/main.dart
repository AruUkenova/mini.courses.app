import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'services/firebase_auth_service.dart';
import 'repositories/auth_repository.dart';
import 'repositories/courses_repository.dart';

import 'controllers/login_controller.dart';
import 'controllers/register_controller.dart';
import 'controllers/courses_controller.dart';

import 'views/auth_gate.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Flutter қателерін консольге де шығару
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    debugPrint(details.exceptionAsString());
  };

  try {
    // 🔥 Firebase инициализация
    await Firebase.initializeApp();

    // ✅ Firebase OK болса — негізгі қосымша
    runApp(const MvcApp());
  } catch (e, st) {
    // ❌ Firebase init құласа — логотипте тұрмай,
    // қате мәтінін экранға шығарамыз
    debugPrint("Firebase initialize failed: $e");
    debugPrint(st.toString());

    runApp(FirebaseInitErrorApp(error: e.toString()));
  }
}

/// Firebase қосылмаса, экранға қате шығаратын уақытша app
class FirebaseInitErrorApp extends StatelessWidget {
  final String error;
  const FirebaseInitErrorApp({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("Firebase Init Error")),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: SingleChildScrollView(
              child: Text(
                "Firebase initialize error:\n\n$error\n\n"
                "Тексер:\n"
                "1) android/app/google-services.json бар ма?\n"
                "2) packageName == applicationId сәйкес пе?\n"
                "3) android/app/build.gradle ішінде google-services plugin қосылған ба?\n"
                "4) minSdkVersion 21 ме?\n",
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MvcApp extends StatelessWidget {
  const MvcApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// Firebase Auth сервис
    final authService = FirebaseAuthService(FirebaseAuth.instance);

    /// Repository
    final authRepository = AuthRepository(authService);

    /// Courses (әзірге mock/local data)
    final coursesRepository = CoursesRepository();

    return MultiProvider(
      providers: [
        /// repositories
        Provider<AuthRepository>.value(value: authRepository),
        Provider<CoursesRepository>.value(value: coursesRepository),

        /// controllers (MVC логикасы)
        ChangeNotifierProvider(create: (_) => LoginController(authRepository)),
        ChangeNotifierProvider(create: (_) => RegisterController(authRepository)),
        ChangeNotifierProvider(create: (_) => CoursesController(coursesRepository)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Women Mini Courses (MVC)',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.pink,
        ),
        /// Firebase auth state тексеру
        home: const AuthGate(),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'services/firebase_auth_service.dart';
import 'repositories/auth_repository.dart';
import 'repositories/courses_repository.dart';

import 'presenters/login_presenter.dart';
import 'presenters/register_presenter.dart';
import 'presenters/courses_presenter.dart';

import 'views/auth_gate.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MvpApp());
}

class MvpApp extends StatelessWidget {
  const MvpApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = FirebaseAuthService(FirebaseAuth.instance);

    final authRepository = AuthRepository(authService);
    final coursesRepository = CoursesRepository();

    return MultiProvider(
      providers: [
        Provider<AuthRepository>.value(value: authRepository),
        Provider<CoursesRepository>.value(value: coursesRepository),

        ChangeNotifierProvider(
          create: (_) => LoginPresenter(authRepository),
        ),

        ChangeNotifierProvider(
          create: (_) => RegisterPresenter(authRepository),
        ),

        ChangeNotifierProvider(
          create: (_) => CoursesPresenter(coursesRepository),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Women Mini Courses MVP",
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.pink,
        ),
        home: const AuthGate(),
      ),
    );
  }
}
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/firebase_options.dart';
import 'package:tic_tac_toe/route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        // 텍스트 폼 필드의 커서 색상 변경
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white, // 원하는 색상으로 변경
        ),
        // 텍스트 폼 필드의 최대 글자 수 색상 변경
        inputDecorationTheme: const InputDecorationTheme(
          counterStyle: TextStyle(color: Colors.white), // 원하는 색상으로 변경
        ),
      ),
      routerConfig: router,
    );
  }
}

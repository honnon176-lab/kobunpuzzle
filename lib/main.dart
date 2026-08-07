import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/selection_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  
  runApp(const FullKobunApp());
}

class FullKobunApp extends StatelessWidget {
  const FullKobunApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '古文助動詞 パズル',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF7F5EC),
      ),
      home: const SelectionScreen(),
    );
  }
}
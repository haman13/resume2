import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'custom_resume_page.dart';
import 'theme.dart';
import 'providers/project_provider.dart';
import 'services/supabase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // قفل کردن جهت صفحه به صورت عمودی
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // مقداردهی اولیه Supabase
  await SupabaseService.instance.initialize();
  
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProjectProvider(),
      child: MaterialApp(
        title: 'رزومه من',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
        home: CustomResumePage(
          onThemeToggle: _toggleTheme,
          isDarkMode: _isDarkMode,
        ),
      ),
    );
  }
}

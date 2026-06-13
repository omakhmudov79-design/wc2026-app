import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/home_screen.dart';
import 'providers/teams_provider.dart';
import 'providers/analysis_provider.dart';
import 'services/notification_service.dart';
import 'services/calendar_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Инициализация Hive
  await Hive.initFlutter();
  await Hive.openBox('analyses');
  await Hive.openBox('settings');
  
  // Инициализация уведомлений
  await NotificationService.init();
  
  // Инициализация календаря
  await CalendarService.init();
  
  runApp(const WC2026App());
}

class WC2026App extends StatelessWidget {
  const WC2026App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TeamsProvider()),
        ChangeNotifierProvider(create: (_) => AnalysisProvider()),
      ],
      child: MaterialApp(
        title: 'ЧМ 2026 — AI Аналитик',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF0a0e1a),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF111827),
            elevation: 0,
            centerTitle: true,
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

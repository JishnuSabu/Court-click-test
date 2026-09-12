import 'package:flutter/material.dart';
import 'core/routes/app_router.dart';
import 'screens/splash_screen.dart';
import 'utils/constants.dart';
import 'utils/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const CourtClickApp());
}

class CourtClickApp extends StatelessWidget {
  const CourtClickApp({super.key});

  @override
  Widget build(BuildContext context) {
    const String sfProDisplay = 'SF Pro Display';
    const List<String> fontFallbacks = [
      '.SF Pro Display',
      '.SF Pro Text',
      'SF Pro Text',
      'San Francisco',
      'Helvetica Neue',
      'Roboto',
      'sans-serif',
    ];

    return MaterialApp(
      title: 'CourtClick Movie Discovery',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        fontFamily: sfProDisplay,
        fontFamilyFallback: fontFallbacks,
        scaffoldBackgroundColor: AppColors.black,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.netflixRed,
          surface: AppColors.darkSurface,
          onSurface: AppColors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.black,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.white),
          titleTextStyle: TextStyle(
            fontFamily: sfProDisplay,
            fontFamilyFallback: fontFallbacks,
            color: AppColors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.black,
          selectedItemColor: AppColors.white,
          unselectedItemColor: AppColors.greyText,
          type: BottomNavigationBarType.fixed,
        ),
        cardTheme: const CardThemeData(color: AppColors.darkCard, elevation: 2),
      ),
      home: const SplashScreen(),
    );
  }
}

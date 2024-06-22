import 'package:e_books/screens/on_bording/on_bording_provider.dart';
import 'package:e_books/util/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:e_books/theme/theme_provider.dart';
import 'package:e_books/local_storage/local_storage_provider.dart';
import 'package:e_books/routes/routes.dart';
import 'package:e_books/theme/theme_modes.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppThemeProvider()),
        ChangeNotifierProvider(create: (context) => LocalStorageProvider()),
        ChangeNotifierProvider(create: (context) => OnBordingProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    final localDB = Provider.of<LocalStorageProvider>(context, listen: false);
    AppThemeProvider.initThemeMode(context, localDB);
    AppThemeProvider().addListener(() {
      setState(() {});
    });
    // initThemeMode();
  }
  // Future<void> initThemeMode()async{
  //   await AppThemeProvider.initThemeMode(context);
  // }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MaterialApp.router(
        color: context.theme.scaffoldBackgroundColor,
        scaffoldMessengerKey: scaffoldMessengerKey,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        theme: AppThemeProvider.lightTheme,
        darkTheme: AppThemeProvider.darkTheme,
        themeMode: AppThemeProvider.themeMode,
        themeAnimationCurve: Curves.ease,
      ),
    );
  }
}

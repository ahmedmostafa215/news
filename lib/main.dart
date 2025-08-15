import 'package:flutter/material.dart';
import 'package:news/ui/home/home_screen.dart';
import 'package:news/utils/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'l10n/app_localizations.dart';
import 'provider/app_language_provider.dart';
import 'provider/app_theme_provider.dart';
import 'utils/app_routes.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  timeago.setLocaleMessages('ar', timeago.ArMessages());
  timeago.setLocaleMessages('en', timeago.EnMessages());
  final languageProvider = AppLanguageProvider();
  await languageProvider.loadSavedLanguage();
  final themeProvider = AppThemeProvider();
  await themeProvider.loadSavedTheme();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppLanguageProvider()),
        ChangeNotifierProvider(create: (_) => AppThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.homeRouteName,
      routes: {
        AppRoutes.homeRouteName: (context) => HomeScreen(),
      },
      locale: Locale(languageProvider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      themeMode: themeProvider.appTheme,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
    );
  }
}

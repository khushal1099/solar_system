import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solar_system/controller/planet_provider.dart';
import 'package:solar_system/controller/theme_provider.dart';
import 'package:solar_system/view/detailpage.dart';
import 'package:solar_system/view/favoritepage.dart';
import 'package:solar_system/view/homepage.dart';
import 'package:solar_system/view/settingpage.dart';
import 'package:solar_system/view/splashscreen.dart';

late SharedPreferences prefs;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PlanetProvider(),
        ),
      ],
      builder: (context, child) {
        return Consumer<ThemeProvider>(
          builder: (context,tp,child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              themeMode: tp.isDark ? ThemeMode.dark : ThemeMode.light,
              initialRoute: "/",
              routes: {
                "/": (context) => SplashScreen(),
                "home": (context) => HomePage(),
                "detail": (context) => DetailsPage(),
                "favorite": (context) => FavoritePage(),
                "setting": (context) => SettingPage(),
              },
            );
          }
        );
      },
    );
  }
}

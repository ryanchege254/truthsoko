import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:truthsoko/Pages/Auth/loginPage.dart';
import 'package:truthsoko/Pages/home/home_screen.dart';
import 'Pages/welcomePage.dart';
import 'Utils/Auth/Auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
          bodyText1: GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const App(),
    );
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: UserRepository.instance(),
      child: Consumer(
        builder: (context, UserRepository user, _) {
          switch (user.status) {
            case Status.Uninitialized:
              return const WelcomePage();
            case Status.Unauthenticated:
              return const WelcomePage();
            case Status.Authenticating:
              return const HomeScreen();
            case Status.Authenticated:
              return const HomeScreen();
          }
        },
      ),
    );
  }
}

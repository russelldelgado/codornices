import 'package:codornices/pages/loginRegister/login_page.dart';
import 'package:codornices/repository/repobbdd.dart';
import 'package:codornices/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Repo.inicializador();

//indicamos que las barras de arriba son de color azul
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white, systemNavigationBarColor: Colors.white));

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AVIPRO',
      debugShowCheckedModeBanner: false,
      routes: getApplicationRoutes(),
      initialRoute: LoginPage.route,
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: scaffoldMessengerKey,
    );
  }
}

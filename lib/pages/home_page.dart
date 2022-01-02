import 'package:codornices/pages/loginRegister/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class HomePage extends StatefulWidget {
  static const String route = "home";
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

bool privacyPolicyValue = false;

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 80),

            //TODO ; TEXTO

            Container(
              child: Text('MENU',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  )),
            ),
            SizedBox(height: 30),

            //TODO : IMAGEN
            Container(
              child: Image(
                image: AssetImage('assets/codornis.png'),
              ),
            ),

            //TODO : METER LO QUE ES USUARIO

            //TODO : METER LO QUE ES CONTRASEÑA
            SizedBox(height: 30),

            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Colors.deepPurple,
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    child: Text(
                      'Registro diario',
                      style: TextStyle(color: Colors.white),
                    )),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'home');
                }),

            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Colors.deepPurple,
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    child: Text(
                      'Reportes',
                      style: TextStyle(color: Colors.white),
                    )),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'home');
                }),
          ],
        ),
      ),
    ));
  }
}

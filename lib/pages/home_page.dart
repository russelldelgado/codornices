import 'package:codornices/pages/loginRegister/login_page.dart';
import 'package:codornices/pages/registroDiario/registro_diario_page.dart';
import 'package:codornices/pages/reportesSemanal/reportes_semanal_page.dart';
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
        body: SafeArea(
      child: Container(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        disabledColor: Colors.grey,
                        elevation: 0,
                        color: Colors.deepPurple,
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            child: Text(
                              'Salir',
                              style: TextStyle(color: Colors.white),
                            )),
                        onPressed: () async {
                          Navigator.pushReplacementNamed(
                              context, LoginPage.route);
                        }),
                    SizedBox(width: 10),
                  ],
                ),
              ),
              SizedBox(height: 80),
              Container(
                child: Text('MENU',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    )),
              ),
              SizedBox(height: 30),
              Container(
                child: Image(
                  image: AssetImage('assets/codornis.png'),
                ),
              ),
              SizedBox(height: 30),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_box_rounded,
                      size: 50,
                      color: Colors.purple[900],
                    ),
                    MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        disabledColor: Colors.grey,
                        elevation: 0,
                        color: Colors.deepPurple,
                        child: Container(
                            width: 200,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            child: Text(
                              'Registro diario',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            )),
                        onPressed: () async {
                          Navigator.pushNamed(
                              context, RegistroDiarioPage.route);
                        }),
                    SizedBox(width: 10),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.report,
                      size: 50,
                      color: Colors.purple[900],
                    ),
                    MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        disabledColor: Colors.grey,
                        elevation: 0,
                        color: Colors.deepPurple,
                        child: Container(
                            width: 200,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            child: Text(
                              'Reportes',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            )),
                        onPressed: () async {
                          Navigator.pushNamed(
                              context, ReporteSemanalPage.route);
                        }),
                    SizedBox(width: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

import 'package:codornices/pages/home_page.dart';
import 'package:codornices/pages/loginRegister/login_page.dart';
import 'package:codornices/pages/loginRegister/register_page.dart';
import 'package:codornices/pages/registroDiario/registro_diario_page.dart';
import 'package:codornices/pages/reportesSemanal/reportes_semanal_page.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    HomePage.route: (BuildContext context) => const HomePage(),
    LoginPage.route: (BuildContext context) => LoginPage(),
    RegisterPage.route: (BuildContext context) => RegisterPage(),
    RegistroDiarioPage.route: (BuildContext context) => RegistroDiarioPage(),
    ReporteSemanalPage.route: (BuildContext context) => ReporteSemanalPage(),
  };
}

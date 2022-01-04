import 'package:codornices/models/usuario_model.dart';
import 'package:codornices/pages/home_page.dart';
import 'package:codornices/pages/loginRegister/register_page.dart';
import 'package:codornices/services/sqflite/dbGanvapp.dart';
import 'package:codornices/shared_preferences/preferencias_usuario.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const String route = "login";

  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Usuario usuario;
  late bool cargando;
  late GlobalKey<FormState> _formKey;
  final bool isProduction = bool.fromEnvironment('dart.vm.product');

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    usuario = Usuario();
    cargando = false;
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

            //TODO : IMAGEN
            Container(
              child: Image(
                image: AssetImage('assets/codornis.png'),
              ),
            ),

            //TODO ; TEXTO
            SizedBox(height: 30),

            Container(
              child: Text("Crianza y control de las codornices",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  )),
            ),
            //TODO : METER LO QUE ES USUARIO

            //TODO : METER LO QUE ES CONTRASEÑA
            SizedBox(height: 30),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    TextFormField(
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecorations.authInputDecoration(
                          hintText: isProduction
                              ? 'produccion.produccion@gmail.com'
                              : 'debug.debug@gmail.com',
                          labelText: 'Ingrese usuario',
                          prefixIcon: Icons.alternate_email_rounded),
                      onChanged: (value) => usuario.user = value,
                      validator: (value) {
                        String pattern =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regExp = new RegExp(pattern);

                        return regExp.hasMatch(value ?? '')
                            ? null
                            : 'El valor ingresado no luce como un correo';
                      },
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      autocorrect: false,
                      obscureText: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecorations.authInputDecoration(
                          hintText: '*****',
                          labelText: 'Ingrese contraseña',
                          prefixIcon: Icons.lock_outline),
                      onChanged: (value) => usuario.password = value,
                      validator: (value) {
                        return (value != null && value.length >= 6)
                            ? null
                            : 'La contraseña debe de ser de 6 caracteres';
                      },
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),

            //TODO : BOTON LOGIN

            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Colors.deepPurple,
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    child: Text(
                      cargando ? 'Espere' : 'Ingresar',
                      style: TextStyle(color: Colors.white),
                    )),
                onPressed: cargando
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();
                        if (!(_formKey.currentState?.validate() ?? false)) {
                          return;
                        }
                        _formKey.currentState!.save();

                        cargando = true;

                        //TODO : CONECTO A LA BASE DE DATOS Y TRAIGO EL USUARIO LE PASO EL USUARIO Y LA CONTRASEÑA
                        Usuario? usuarioRecuperado = await DBAVIPRO
                            .recuperarUsuarioLogin(usuario: usuario);
                        print('usuario para login');
                        print(usuarioRecuperado);

                        if (usuarioRecuperado == null) {
                          ScaffoldMessenger.of(context)..removeCurrentSnackBar()..showSnackBar(SnackBar(
                              content: Text("Usuario o contraseña invalido")));
                          cargando = false;
                        } else {
                          usuario = usuarioRecuperado;
                          print(usuario);
                          Preferencias().userIdgetSet = usuarioRecuperado.id!;
                          Navigator.pushReplacementNamed(
                              context, HomePage.route);
                        }
                        setState(() {
                          cargando = false;
                        });
                      }),

            //TODO : BOTON REGISTRE

            TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, RegisterPage.route),
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                        Colors.indigo.withOpacity(0.1)),
                    shape: MaterialStateProperty.all(StadiumBorder())),
                child: const Text(
                  'Crear una nueva cuenta',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                )),
          ],
        ),
      ),
    ));
  }
}

class InputDecorations {
  static InputDecoration authInputDecoration(
      {required String hintText,
      required String labelText,
      IconData? prefixIcon}) {
    return InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurple),
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple, width: 2)),
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: Colors.deepPurple)
            : null);
  }
}

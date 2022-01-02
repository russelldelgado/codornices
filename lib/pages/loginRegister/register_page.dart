import 'package:codornices/pages/home_page.dart';
import 'package:codornices/pages/loginRegister/login_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  static const String route = "register";

  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late String user;
  late String password;
  late bool cargando;

  @override
  void initState() {
    super.initState();
    user = '';
    password = '';
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
              child: Text('AGREGAR USUARIO',
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    TextFormField(
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecorations.authInputDecoration(
                          hintText: 'duvan.duvan@gmail.com',
                          labelText: 'Ingrese usuario',
                          prefixIcon: Icons.alternate_email_rounded),
                      onChanged: (value) => user = value,
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
                      onChanged: (value) => password = value,
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
                      cargando ? 'Espere' : 'GUARDAR',
                      style: TextStyle(color: Colors.white),
                    )),
                onPressed: cargando
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();

                        //TODO : CONECTO A LA BASE DE DATOS Y TRAIGO EL USUARIO LE PASO EL USUARIO Y LA CONTRASEÑA
                        // const usuario = DBAVIPRO().recuperarUsuario(id)

                        cargando = true;

                        //TODO  : COMPROVAMOS QUE EL USAURIO Y LA CONTRASEÑA SEAN CORRECTOS Y SI ES ASI LO LLEVAMOS A LA HOME PAGE

                        const error = null;

                        if (error == null) {
                          Navigator.pushReplacementNamed(
                              context, HomePage.route);
                        } else {
                          // TODO: mostrar error en pantalla
                          // print( errorMessage );
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Usuario o contraseña invalido")));
                          cargando = false;
                        }
                      }),

            //TODO : BOTON login

            TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, LoginPage.route),
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                        Colors.indigo.withOpacity(0.1)),
                    shape: MaterialStateProperty.all(StadiumBorder())),
                child: const Text(
                  '¿Ya tienes una cuenta?',
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

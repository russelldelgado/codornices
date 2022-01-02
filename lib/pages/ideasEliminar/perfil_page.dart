// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';

// class PerfilPage extends StatefulWidget {
//   static final String route = 'perfilPage';
//   CocheV2? cocheV2;

//   PerfilPage({
//     Key? key,
//     this.cocheV2,
//   }) : super(key: key);

//   @override
//   _PerfilPageState createState() => _PerfilPageState();
// }

// class _PerfilPageState extends State<PerfilPage> {
//   Preferencias prefs = Preferencias();
//   late bool privacyPolicyValue;
//   Usuario? usuario;
//   late bool enviarCorreo;
//   late bool _isButtonDisabled;
//   late bool enable;
//   late GlobalKey<FormState> _formKey;
//   late TextEditingController _nombreControlador;
//   late TextEditingController _emailControlador;
//   late TextEditingController _telefonoControlador;
//   late TextEditingController _codigoPostalControlador;

//   @override
//   void initState() {
//     _formKey = GlobalKey<FormState>();
//     _isButtonDisabled = false;
//     privacyPolicyValue = false;
//     enable = true;
//     enviarCorreo = false;
//     privacyPolicyValue = Preferencias().aceptarPoliticasDePrivacidad;
//     _nombreControlador = TextEditingController();
//     _emailControlador = TextEditingController();
//     _telefonoControlador = TextEditingController();
//     _codigoPostalControlador = TextEditingController();

//     UserApiService.getUser().then((value) {
//       _nombreControlador.text = value?.nombre ?? '';
//       _emailControlador.text = value?.email ?? '';
//       _telefonoControlador.text = value?.telefono ?? '';
//       _codigoPostalControlador.text = value?.codigoPostal ?? '';
//       if (value == null) {
//         usuario = Usuario();
//         usuario?.tokenUsuario = PushNotificationServicesV2.token;
//       } else {
//         usuario = value;
//       }
//       setState(() {});
//     });

//     super.initState();
//   }

//   @override
//   void dispose() {
//     _nombreControlador.dispose();
//     _emailControlador.dispose();
//     _telefonoControlador.dispose();
//     _codigoPostalControlador.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
// //Cuando vengamos de otra pantalla para recibir las ofertas  enviaremos esta información para indicar al usuario que ya tenemos todo lo anterior realizado
// //que ahora solo tiene que enviar el correo de que ya queremos recibir notifiaciones
//     final enviarCorreoDeRecibirOfertas =
//         ModalRoute.of(context)!.settings.arguments;

//     if (enviarCorreoDeRecibirOfertas != null) {
//       enviarCorreo = enviarCorreoDeRecibirOfertas as bool;
//     }

//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           iconTheme: IconThemeData(color: CustomTheme.white),
//           centerTitle: true,
//           backgroundColor: CustomTheme.blue,
//           title: Text(
//             "Mis datos de contacto",
//             style: TextStyle(
//               color: CustomTheme.white,
//               fontFamily: TypografiaPersonalizada.DIN,
//             ),
//           ),
//           actions: [
//             Padding(
//               padding:
//                   const EdgeInsets.only(right: 10.0, top: 4.0, bottom: 4.0),
//               child: Image(
//                 image: AssetImage('assets/g-ganvam-logo-new.png'),
//               ),
//             ),
//           ],
//         ),
//         body: usuario == null
//             ? Center(child: CircularProgressIndicator())
//             : Container(
//                 margin: EdgeInsets.symmetric(horizontal: 20),
//                 child: SingleChildScrollView(
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         _crearFormulario(
//                           enable: enable,
//                           controller: _nombreControlador,
//                           dato: "Nombre",
//                           onSave: (value) => usuario?.nombre = value,
//                         ),
//                         _crearFormulario(
//                           enable: enable,
//                           controller: _emailControlador,
//                           dato: "Correo electrónico",
//                           tipoTeclado: TextInputType.emailAddress,
//                           onSave: (value) => usuario?.email = value,
//                           validator: (value) {
//                             return validarCorreoElectronico(valor: value!);
//                           },
//                         ),
//                         _crearFormulario(
//                             enable: enable,
//                             controller: _telefonoControlador,
//                             dato: "Teléfono",
//                             onSave: (value) => usuario?.telefono = value,
//                             validator: (value) {
//                               return validarTelefono(valor: value!);
//                             }),
//                         SizedBox(
//                           height: 4,
//                         ),
//                         Text(
//                           'Esta información será utilizada únicamente para facilitar el contacto con GANVAPP si fuera necesario',
//                           style: TextStyle(
//                             color: Colors.grey,
//                             fontSize: 12,
//                             fontFamily: TypografiaPersonalizada.DIN,
//                           ),
//                           textAlign: TextAlign.justify,
//                         ),
//                         _crearFormulario(
//                           enable: enable,
//                           controller: _codigoPostalControlador,
//                           tipoTeclado: TextInputType.number,
//                           maxLength: 5,
//                           dato: "Código postal",
//                           onSave: (value) => usuario?.codigoPostal = value,
//                           validator: (value) {
//                             return validarCodigoPostal(valor: value!);
//                           },
//                         ),
//                         SizedBox(
//                           height: 4,
//                         ),
//                         Text(
//                           'Es importante conocer esta información para poder ofrecerte las mejores ofertas más cercanas a ti',
//                           style: TextStyle(
//                             fontFamily: TypografiaPersonalizada.DIN,
//                             color: Colors.grey,
//                             fontSize: 12,
//                           ),
//                           textAlign: TextAlign.justify,
//                         ),
//                         SizedBox(
//                           height: !Preferencias().aceptarPoliticasDePrivacidad
//                               ? MediaQuery.of(context).size.height * 0.17
//                               : MediaQuery.of(context).size.height * 0.30,
//                         ),
//                         if (!Preferencias().aceptarPoliticasDePrivacidad)
//                           CheckboxListTile(
//                             title: RichText(
//                                 text: TextSpan(children: [
//                               TextSpan(
//                                   text:
//                                       "Acepto la política de privacidad (Si acepta el tratamiento de sus datos con esa finalidad marque esta casilla.)   ",
//                                   style: TextStyle(
//                                     color: Colors.grey,
//                                     fontSize: 12,
//                                     fontFamily: TypografiaPersonalizada.DIN,
//                                   )),
//                             ])),
//                             value: privacyPolicyValue,
//                             onChanged: (newValue) {
//                               FocusScope.of(context).unfocus();
//                               setState(() {
//                                 privacyPolicyValue = newValue!;
//                               });
//                             },
//                             controlAffinity: ListTileControlAffinity
//                                 .leading, //  <-- leading Checkbox
//                           ),
//                         if (!Preferencias().aceptarPoliticasDePrivacidad)
//                           Container(
//                             child: RichText(
//                               text: TextSpan(
//                                   text: "Política de privacidad",
//                                   style: new TextStyle(
//                                       fontFamily: TypografiaPersonalizada.DIN,
//                                       color: CustomTheme.blue,
//                                       decoration: TextDecoration.underline,
//                                       decorationColor: CustomTheme.blue),
//                                   recognizer: new TapGestureRecognizer()
//                                     ..onTap = () {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (_) => PrivacyPage()));
//                                     }),
//                             ),
//                           ),
//                         SizedBox(
//                           height: 8.0,
//                         ),
//                         Container(
//                           child: ConstrainedBox(
//                             constraints: BoxConstraints.tightFor(
//                                 width: MediaQuery.of(context).size.width * 0.8,
//                                 height: 50.0),
//                             child: ElevatedButton(
//                               child: Text(
//                                 _isButtonDisabled ? "Espere" : "Guardar datos",
//                                 style: TextStyle(
//                                   fontFamily: TypografiaPersonalizada.DIN,
//                                   fontSize: 23,
//                                 ),
//                               ),
//                               onPressed:
//                                   _isButtonDisabled ? null : _guardarMisDatos,
//                               style: ElevatedButton.styleFrom(
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(20.0)),
//                                 elevation: 20,
//                                 primary: CustomTheme.callToActionPrimary,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }

//   Widget _crearFormulario(
//       {bool? enable,
//       TextEditingController? controller,
//       String? initialValue,
//       int? maxLength,
//       required String dato,
//       TextInputType? tipoTeclado,
//       Function(String)? onChanged,
//       VoidCallback? onTap,
//       String? Function(String?)? validator,
//       void Function(String?)? onSave}) {
//     return TextFormField(
//       enabled: enable,
//       controller: controller,
//       initialValue: initialValue,
//       onSaved: onSave,
//       maxLength: maxLength,
//       validator: validator,
//       onChanged: onChanged,
//       onTap: onTap,
//       keyboardType: tipoTeclado ?? TextInputType.name,
//       decoration: InputDecoration(
//         labelText: dato,
//         hintText: dato,
//       ),
//     );
//   }

//   _guardarMisDatos() async {
//     FocusScope.of(context).unfocus();
//     if (!privacyPolicyValue) {
//       ScaffoldMessenger.of(context)
//         ..removeCurrentSnackBar()
//         ..showSnackBar(SnackBar(
//             content:
//                 Text('Acepte las políticas de privacidad para poder continuar',
//                     style: TextStyle(
//                       fontFamily: TypografiaPersonalizada.DIN,
//                     ))));
//       return;
//     }

//     if (!(_formKey.currentState?.validate() ?? false)) {
//       return;
//     }

//     setState(() {
//       _isButtonDisabled = true;
//       enable = false;
//     });

//     _formKey.currentState!.save();
//     if (usuario?.id == null) {
//       ///guardo los datos de mi usuario en el backend
//       var responseBack = await UserApiService().sendUser(usuario!);
//       print(
//           "guardados los datos de mi backen en mi backen creando la respuesta es");
//       print(responseBack);

//       if (responseBack == null) {
//         setState(() {
//           _isButtonDisabled = false;
//           enable = true;
//         });
//         ScaffoldMessenger.of(context)
//           ..removeCurrentSnackBar()
//           ..showSnackBar(SnackBar(
//               content: Text('comprueba tu conexión a internet',
//                   style: TextStyle(
//                     fontFamily: TypografiaPersonalizada.DIN,
//                   ))));
//         return;
//       }

//       if (!responseBack) {
//         setState(() {
//           _isButtonDisabled = false;
//           enable = true;
//         });
//         ScaffoldMessenger.of(context)
//           ..removeCurrentSnackBar()
//           ..showSnackBar(SnackBar(
//               content: Text('Datos ya registrados por otro usuario',
//                   style: TextStyle(
//                     fontFamily: TypografiaPersonalizada.DIN,
//                   ))));

//         return;
//       }
//     } else {
//       ///se actualiza el usuario en el backend
//       var responseBack = await UserApiService().udpateUser(usuario!);

//       if (responseBack == null) {
//         setState(() {
//           _isButtonDisabled = false;
//           enable = true;
//         });
//         ScaffoldMessenger.of(context)
//           ..removeCurrentSnackBar()
//           ..showSnackBar(SnackBar(
//               content: Text('comprueba tu conexión a internet',
//                   style: TextStyle(
//                     fontFamily: TypografiaPersonalizada.DIN,
//                   ))));
//         return;
//       }

//       if (!responseBack) {
//         setState(() {
//           _isButtonDisabled = false;
//           enable = true;
//         });
//         ScaffoldMessenger.of(context)
//           ..removeCurrentSnackBar()
//           ..showSnackBar(SnackBar(
//               content: Text('Datos ya registrados por otro usuario',
//                   style: TextStyle(
//                     fontFamily: TypografiaPersonalizada.DIN,
//                   ))));

//         return;
//       }
//     }

//     Preferencias().codigopostal = usuario!.codigoPostal!;
//     Preferencias().aceptarPoliticasDePrivacidad = true;

//     if (enviarCorreo) {
//       // SMTPpersonalizado mensaje = SMTPpersonalizado(context: context);
//       // final respuesta = await mensaje.enviarSolicitarOferta();
//       //TODO : TENEMOS QUE VALIDAR ESTO POR QUE DA ERROR EN ESTE PUNTO NO PODEMOS ENVIAR LA OFERTA DE VENTA POR QUE NO LA TENEOS ALAMACENADA EN LA BASE DE DATOS
//       var respuesta =
//           await OfertasVentaApiService().sendOfertaVenta(widget.cocheV2!);

//       if (respuesta) {
//         //solo si se envia el correo entonces cambiamos la vision del usuario e indicamos que ya puede recibir ofertas
//         Preferencias().ofertas = true;
//       }
//       setState(() {
//         enable = true;
//       });
//       Navigator.pop(context);
//     } else {
//       Navigator.pop(context);
//     }
//   }
// }

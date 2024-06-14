import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/utils.dart';

import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey();

  Widget _email() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Email', style: kTLoginLabelStyle),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kTBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(
                color: kTIconColorTextBoxLogin,
                fontFamily: 'OpenSans',
                fontSize: 14.0,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.email, color: kTIconColorTextBoxLogin),
                hintText: 'ingresa tu email',
                hintStyle: kTHintTextStyle,
                errorStyle: kTLoginTextFieldErrorStyle,
              ),
              keyboardType: TextInputType.emailAddress,
              validator: Utilidades.isValidEmailRequired,
              controller: _emailController,
              onSaved: (value) {
                controller.email = value ?? '';
              }),
        ),
      ],
    );
  }

  Widget _password() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Contraseña', style: kTLoginLabelStyle),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kTBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
              obscureText: true,
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(
                color: kTIconColorTextBoxLogin,
                fontFamily: 'OpenSans',
                fontSize: 14.0,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.lock, color: kTIconColorTextBoxLogin),
                hintText: 'ingresa tu contraseña',
                hintStyle: kTHintTextStyle,
                errorStyle: kTLoginTextFieldErrorStyle,
              ),
              validator: (val) =>
                  (val ?? '').length < 6 ? '     Mínimo 6 caracteres ' : null,
              controller: _passwordController,
              onSaved: (value) {
                controller.password = value ?? '';
              }),
        ),
      ],
    );
  }

  Widget _olvideMiContrasenia() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => Get.toNamed(AppRoutes.rPasswordRecovery),
        child: const Text('Olvidé mi contraseña', style: kTLoginLabelStyle),
      ),
    );
  }

  Widget _btnLogin() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(kTBackgroundColorBtnIngresarLogin),
              elevation: MaterialStateProperty.all(15.0),
              padding: MaterialStateProperty.all(const EdgeInsets.all(15.0)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)))),
          child: const Text(
            'INGRESAR',
            style: TextStyle(
              color: kTLabelColorBtnIngresarLogin,
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
          onPressed: () async {
            if (_key.currentState!.validate()) {
              //-- Este save() es el que pasa los valores de las cajas de texto al controller!
              _key.currentState!.save();
              controller.autenticar();
            } else {
              Get.snackbar(
                "ATENCION",
                "Alguno de los datos ingresados no son válidos.\n\nPor favor verifica!",
                snackPosition: SnackPosition.TOP,
                icon: const Icon(Icons.error, color: Colors.white),
                backgroundColor: kTRedColor,
                colorText: Colors.white,
                borderRadius: 0.0,
                margin: const EdgeInsets.all(0),
              );
            }
          }),
    );
  }

  Widget _btnShowMantenimiento() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(kTLightPrimaryColor2),
              elevation: MaterialStateProperty.all(15.0),
              padding: MaterialStateProperty.all(const EdgeInsets.all(15.0)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)))),
          child: const Text(
            'Información Extra',
            style: TextStyle(
              color: Colors.white70,
              letterSpacing: 1.5,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
          onPressed: () => Get.toNamed(AppRoutes.rMantenimiento)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _key,
      child: Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            onTap: () {
              controller.tapCount++;
              FocusScope.of(context).unfocus();
            },
            child: Stack(
              children: <Widget>[
                kTBackgroundContainer,
                SafeArea(
                  child: SizedBox(
                    height: double.infinity,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40.0,
                        //vertical: 40.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage(Constants.kLogoLogin),
                              )),
                            ),
                          ),
                          _email(),
                          const SizedBox(height: 30.0),
                          _password(),
                          _olvideMiContrasenia(),
                          _btnLogin(),
                          Obx(() => Visibility(
                              visible: controller.tapCount > 10,
                              child: _btnShowMantenimiento())),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

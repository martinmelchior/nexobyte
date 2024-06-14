import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/theme/app_theme.dart';

import 'password_change_controller.dart';


class PasswordChangePage extends GetView<PasswordChangeController> { 
  
  PasswordChangePage({Key? key}) : super(key: key);

  final TextEditingController _passwordController1 = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {

    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _key,
        child: Scaffold(
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
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
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget> [
                            AspectRatio(
                              aspectRatio: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: AssetImage(Constants.kLogoEmpresaIcon),
                                )),
                              ),
                            ),
                            const Text('Cambia tu CONTRASEÑA', style: TextStyle(color: kTAllLabelsColor,  fontWeight: FontWeight.bold,  fontFamily: 'OpenSans', fontSize: 20.0)),
                            const SizedBox(height: 30.0),
                            _password(),
                            const SizedBox(height: 30.0),
                            _passwordConfirm(),
                            const SizedBox(height: 50.0),
                            _btnPasswordChange(),
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


  Widget _password() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Nueva contraseña',style: kTLoginLabelStyle),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kTBoxDecorationStyle,
          height: 60.0,
            child: TextFormField(
              obscureText: true,
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
                fontSize: 14.0,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.lock, color: Colors.white38),
                hintText: 'ingresa tu contraseña',
                hintStyle: kTHintTextStyle,
                errorStyle: kTLoginTextFieldErrorStyle,
              ),
              validator: (val) {
                if ((val ?? '').length < 6) return 'Mínimo 6 caracteres';
                if (_passwordController1.text != _passwordController2.text) return 'Las contraseñas no son iguales!';
                return null;
              },
              controller: _passwordController1,
            ),
        ),
      ],
    );
  }

  Widget _passwordConfirm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Confirma la contraseña anterior',style: kTLoginLabelStyle),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kTBoxDecorationStyle,
          height: 60.0,
            child: TextFormField(
              obscureText: true,
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
                fontSize: 14.0,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.lock, color: Colors.white38),
                hintText: 'Confirma tu contraseña',
                hintStyle: kTHintTextStyle,
                errorStyle: kTLoginTextFieldErrorStyle,
              ),
              validator: (val) {
                if ((val ?? '').length < 6) return 'Mínimo 6 caracteres';
                if (_passwordController1.text != _passwordController2.text) return 'Las contraseñas no son iguales!';
                return null;
              },
              controller: _passwordController2,
            ),
        ),
      ],
    );
  }

  Widget _btnPasswordChange() {
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
        child: const Text('CAMBIAR  CONTRASEÑA',
          style: TextStyle(
            color: Colors.white70,
            letterSpacing: 1.5,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        onPressed: () async {
          if (_key.currentState!.validate()) 
          {
            //-- Este save() es el que pasa los valores de las cajas de texto al controller!
            _key.currentState!.save();
            controller.cambiarPassword(_passwordController1.text);
          } 
        }
      ),
      
    );
  }


}

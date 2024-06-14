

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/theme/app_theme.dart';

import 'enviar_feedback_controller.dart';

class EnviarFeedBackPage extends GetView<EnviarFeedbackController> {

  EnviarFeedBackPage({Key? key}) : super(key: key);
  final GlobalKey<FormState> _key = GlobalKey();

  final TextStyle _labelStyle = const TextStyle(color: kTLightPrimaryColor, fontSize: 18);
  final OutlineInputBorder _enabledBorder = const OutlineInputBorder(borderSide: BorderSide(color: kTLightPrimaryColor, width: 0.2));
  final OutlineInputBorder _focusedBorder = const OutlineInputBorder(borderSide: BorderSide(color: kTLightPrimaryColor, width: 0.2));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          elevation: 10,
          child: const Icon(Icons.send),
          backgroundColor: kTBackgroundColorBtnIngresarLogin,
          foregroundColor: Colors.white,
          //onPressed: null,
          onPressed: () async {
              if (_key.currentState!.validate()) {
                await controller.enviarFeedback();
                Get.snackbar(
                  "GRACIAS",
                  "Hemos recibido tu comentario !",
                  snackPosition: SnackPosition.BOTTOM,
                  icon: const Icon(Icons.error, color: Colors.white),
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  borderRadius: 0.0,
                  margin: const EdgeInsets.all(0),
                  duration: const Duration(seconds: 5),
                );
                
              } 
              else 
              {
                Get.snackbar(
                  "ATENCION",
                  "Ingresa el tipo y comentario antes de intentar el envío del mismo!",
                  snackPosition: SnackPosition.TOP,
                  icon: const Icon(Icons.error, color: Colors.white),
                  backgroundColor: kErrorBackColor,
                  colorText: Colors.white,
                  borderRadius: 0.0,
                  margin: const EdgeInsets.all(0),
                );
              }
            },

        ),
        backgroundColor: Colors.white.withOpacity(0.95),
        appBar: AppBar(
          flexibleSpace: kTflexibleSpace,
          elevation: 10.0,
          backgroundColor: kTLightPrimaryColor,
          iconTheme: const IconThemeData(
            color: kTIconColor, //change your color here
          ),
          title: const Text("Contacta al desarrollador", style: TextStyle(fontSize: 17.0, color: kTAllLabelsColor)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _key, 
            child:  Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    RichText(
                      textAlign: TextAlign.start,
                      text: const TextSpan( 
                        style: TextStyle(fontSize: 18.0, color: Colors.black54),
                        children: <TextSpan>
                          [
                            TextSpan(text: 'Si necesitas contactarnos por algún '),
                            TextSpan(text: 'PROBLEMA, SUGERENCIA o INQUIETUD', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: ', este es el lugar indicado!\n\n'),
                            TextSpan(text: 'Envíanos un comentario y te responderemos a tu email a la brevedad.'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Column(
                        children: [
                          tipo(),
                          const SizedBox(height: 30),
                          TextFormField(
                            minLines: 2,
                            maxLines: 10,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              labelText: 'Comentario',
                              errorBorder: _enabledBorder,
                              focusedBorder: _focusedBorder,
                              focusedErrorBorder: _focusedBorder,
                              disabledBorder: _enabledBorder,
                              enabledBorder: _enabledBorder,
                              labelStyle: _labelStyle,
                              //border: _focusedBorder,
                            ),
                            controller: controller.mensajeController,
                            validator: (value) => value == null || value.isEmpty ? 'Por favor ingresa un comentario' : null,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
          ),
        )
    );
  }

  //*------------------------------------------------------------------------------------------------------ LOTES
  Widget tipo() {
    return DropdownSearch<String>(
      mode: Mode.MENU,
      showSelectedItems: true,
      items: const ["Tengo un problema", "Sugiero una mejora", "Otro"],
      dropdownSearchDecoration: InputDecoration(
        labelText: 'Tipo de comentario',
        enabledBorder: _enabledBorder,
        focusedBorder: _focusedBorder,
        labelStyle: _labelStyle,
        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
      ),
      onChanged: print,
      validator: (value) {
        if (value == null || value.isEmpty)
        {
          return 'Selecciona un tipo de comentario';
        }
        controller.tipo = value;
        return null;
      },
    );
  }
  
}
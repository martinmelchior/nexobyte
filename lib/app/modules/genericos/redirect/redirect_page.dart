
//import 'package:intercampo_app/app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'redirect_controller.dart';


class RedirectPage extends StatelessWidget {


  final RedirectController controller = Get.find<RedirectController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  RedirectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            kTBackgroundContainer,
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: kTCpi,
                  ),
                ],
              ),
            )
          ]
        )
      )
    );
  }
}
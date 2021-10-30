import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:test_app/controller/login_controller.dart';
import 'package:test_app/utills/sharedPrefUtills.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(''),
            SizedBox(height: 15),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
              ),
              onPressed: () {
                showAlertDialog(context, controller);
              },
              child: Text(
                'Retrieve user login token',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, LoginController controller) {
    Widget okButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
          },
        child: Text('ok'));
    AlertDialog alertDialog = AlertDialog(
      title: Text('Your login token', style: TextStyle(
        fontSize: 20.0,
        color: Colors.lightBlue,
      ),),
      content: Text('${Get.find<LoginController>().token.value}'),
      actions: [okButton,],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }
}

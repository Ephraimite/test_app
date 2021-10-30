import 'dart:convert';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/model/response_data.dart';
import 'package:test_app/screens/dashboard.dart';
import 'package:test_app/utills/sharedPrefUtills.dart';

Pref sharedPref = Pref();

Future<void> getLoginResponse(String email, String password, BuildContext context) async {
  final response = await http.post(Uri.parse('https://reqres.in/api/login'),
      body: ({"email": email, "password": password}));

  final progressBar = ProgressHUD.of((context));

  if (response.statusCode == 200) {

    // If the server did return a 200 OK response,
    // then parse the JSON.
    Map<String, dynamic> map = jsonDecode(response.body.toString());
    TokenModel userToken = TokenModel.fromJson(map);
    print('my response ${userToken.token}');

    Fluttertoast.showToast(msg: "Login successful");
    sharedPref
        .saveStr('userToken', userToken.token!)
        .then((value) => Get.to(() => Dashboard(), transition: Transition.downToUp));

    progressBar!.dismiss();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    Fluttertoast.showToast(msg: response.body.toString());
    progressBar!.dismiss();
  }
}

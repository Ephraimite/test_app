
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:test_app/services/api_service.dart';
import 'package:test_app/utills/sharedPrefUtills.dart';

class LoginController extends GetxController{

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  late TextEditingController emailController, passwordController;

  RxString token = ''.obs;


  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    getUserToken();

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }

  String? validateEmail(String email){
    if(!GetUtils.isEmail(email)){
      return 'Provide a valid email';
    }
    return null;
  }
  String? validatePassword(String password){
    if(password.isEmpty){
      return 'input password';
    }
    return null;
  }

  checkUserLogin(BuildContext context){
    final isValid = loginFormKey.currentState!.validate();
    if(!isValid){
      return;
    }else{
      loginFormKey.currentState!.save();
      getLoginResponse(emailController.text, passwordController.text, context);

    }
  }

  Future getUserToken() async {
    token.value = await Pref.readPrefStr('userToken');
    update();
    print('this is the user token $token');
  }

}
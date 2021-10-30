
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/instance_manager.dart';
import 'package:test_app/controller/login_controller.dart';

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final LoginController c = Get.put(LoginController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
        centerTitle: true,
      ),
      body: ProgressHUD(
        backgroundColor: Colors.lightBlue  ,
        child: SingleChildScrollView(
            child: Form(
              key: c.loginFormKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 60.0),
                child: Center(
                  child: Container(
                    width: 200,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Image.asset('assets/images/login icon.png'),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(top: 25, left: 15, right: 15),
                child: TextFormField(
                  controller: c.emailController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value){
                    return c.validateEmail(value!);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Email',
                  ),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: TextFormField(
                  controller: c.passwordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value){
                    return c.validatePassword(value!);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 10),
              Builder(
                builder: (context) {
                  return TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                    ),
                    onPressed: (){
                      final progressBar = ProgressHUD.of((context));
                      progressBar!.showWithText("Authenticating pls wait....");
                      c.checkUserLogin(context);
                    } , child: Text('Login', style: TextStyle(
                    color: Colors.white,
                  ),),);
                }
              ),
            ],
          ),
        )),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:monitoring/widgets/my_password_field.dart';
import 'package:monitoring/widgets/my_text_field.dart';
import 'package:monitoring/widgets/my_text_button.dart';
import 'package:monitoring/Home.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  TextEditingController controllerUsername = new TextEditingController();
  TextEditingController controllerPassword = new TextEditingController();
  bool isPasswordVisible = true;

  void initState() {
    super.initState();
  }

  void prosesLogin() async {
    // make view to route
    setState(() {
      _isLoading = true;
    });
    if (controllerUsername.text == "" || controllerPassword.text == "") {
      EasyLoading.showError('Username dan Password tidak boleh kosong');
    } else {
      if (controllerUsername.text == "admin" &&
          controllerPassword.text == "admin") {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
      } else {
        EasyLoading.showError('Username dan Password salah');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 238, 238, 1),
      body: SafeArea(
        //to make page scrollable
        child: CustomScrollView(
          reverse: true,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Image(
                              image: NetworkImage(
                                  'https://disperin.kalselprov.go.id/assets/images/login.png'),
                              width: 150,
                              height: 150,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Center(
                            child: Text(
                              "Selamat datang.",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Center(
                            child: Text(
                              "mari kita monitoring listrik!",
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          MyTextField(
                            hintText: 'Username',
                            inputType: TextInputType.text,
                            controllerText: controllerUsername,
                          ),
                          MyPasswordField(
                            isPasswordVisible: isPasswordVisible,
                            controllerText: controllerPassword,
                            onTap: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Jika ada masalah hubungi admin? ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextButton(
                      buttonName: 'Sign In',
                      onTap: () => {prosesLogin()},
                      bgColor: Colors.black,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

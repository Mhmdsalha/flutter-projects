import 'package:flutter/material.dart';
import 'package:login_screen/shered/network/components/components.dart';

void main() {
  runApp(MyApp());
}

var emailtext = TextEditingController();
var passwordtext = TextEditingController();
bool isObscure = true;
var formkey = GlobalKey<FormState>();

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Login Screen',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                print('menu');
              },
              icon: Icon(
                Icons.menu,
                size: 30,
              ),
            ),
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsetsDirectional.all(10),
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    defultTextfield(
                      validator: (value) {
                        if (value == "") {
                          return 'Enter your Email Address';
                        }
                        return null;
                      },
                      controller: emailtext,
                      keyboardType: TextInputType.emailAddress,
                      labelText: 'Eamil Adress',
                      prefixIcon: Icons.email,
                    ),
                    defultTextfield(
                        validator: (value) {
                          if (value == "") {
                            return 'Enter your Password';
                          }
                          return null;
                        },
                        controller: passwordtext,
                        keyboardType: TextInputType.visiblePassword,
                        labelText: 'Password',
                        prefixIcon: Icons.lock,
                        suffixIcon:
                            isObscure ? Icons.visibility : Icons.visibility_off,
                        isPassword: isObscure,
                        suffixIconpressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        }),
                    defultbutton(
                        buttontext: 'Login',
                        function: () {
                          if (formkey.currentState!.validate()) {
                            print(emailtext.text);
                            print(passwordtext.text);
                          }
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsetsDirectional.only(
                            top: 15,
                          ),
                          child: Text(
                            'Don\'t you have an account ? ',
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsetsDirectional.only(
                            top: 15,
                          ),
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Register Now',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_final_fields, unused_field

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ila/API/api_services.dart.dart';
import 'package:ila/Models/account.dart';
import 'package:ila/Utils/staticvalue.dart';
import 'package:ila/src/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Login());
}

class Login extends StatelessWidget {
  const Login({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch(backgroundColor: Colors.white)),
      home: const LoginPage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({super.key, required this.title});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ScrollController verticalController = ScrollController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String? _username;
  String? _password;
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = false;
  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Scrollbar(
            thickness: 0,
            thumbVisibility: true,
            controller: verticalController,
            child: SingleChildScrollView(
              controller: verticalController,
              scrollDirection: Axis.vertical,
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 300,
                        width: double.infinity,
                        child: Image.asset('images/assets/iLA.png',
                            fit: BoxFit.cover),
                      ),
                      const SizedBox(height: 80),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 350,
                            child: TextFormField(
                                onChanged: (value) {
                                  _username = value;
                                },
                               
                                validator: (value) {
                                  if (value != null && value.isEmpty) {
                                    return 'Username is required please enter';
                                  }
                                  return null;
                                },
                                controller: _usernameController,
                                onTapOutside: (event) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                decoration: InputDecoration(
                                  errorStyle: const TextStyle(
                                      color: Colors.red, fontSize: 15),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Image.asset(
                                      'images/assets/icon/5097947.png',
                                      color: Colors.black,
                                      width: 10,
                                      height: 10,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  hintText: 'Username',
                                  hintStyle:
                                      const TextStyle(color: Colors.black26),
                                )),
                          )
                        ],
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          SizedBox(
                            width: 350,
                            child: TextFormField(
                                onChanged: (value) {
                                  _password = value;
                                },
                                
                                validator: (value) {
                                  if (value != null && value.isEmpty) {
                                    return 'Password is required please enter';
                                  }
                                  return null;
                                },
                                controller: _passwordController,
                                obscureText: passwordVisible,
                                onTapOutside: (event) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                decoration: InputDecoration(
                                  errorStyle: const TextStyle(
                                      color: Colors.red, fontSize: 15),
                                  prefixIcon: const Icon(Icons.lock,
                                      color: Colors.black),
                                  suffixIcon: IconButton(
                                    icon: Icon(passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(
                                        () {
                                          passwordVisible = !passwordVisible;
                                        },
                                      );
                                    },
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  hintText: 'Password',
                                  hintStyle:
                                      const TextStyle(color: Colors.black26),
                                )),
                          )
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          SizedBox(
                            width: 120,
                            height: 60,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 199, 161, 122)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                )),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    Future<Account> userAcc = APIServices()
                                        .userLogin(_usernameController.text.trim(),
                                            _passwordController.text.trim());
                                    userAcc.then((data) {
                                      if (data.flagLogin == true) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Home()));
                                        StaticValue.idAccount = data.id;
                                        if (data.avatar == 'NoImage') {
                                          StaticValue.userAvatar = 'https://kennyleeholmes.com/wp-content/uploads/2017/09/no-image-available.png';
                                        } else{
                                          StaticValue.userAvatar = data.avatar;
                                        }
                                        
                                        StaticValue.userFullName = data.name;
                                        StaticValue.userPhone = data.phone;

                                        _usernameController.clear();
                                        _passwordController.clear();
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              Future.delayed(
                                                  const Duration(seconds: 2),
                                                  () {
                                                Navigator.of(context).pop(true);
                                              });
                                              return Dialog(
                                                backgroundColor:
                                                    Colors.transparent,
                                                insetPadding:
                                                    const EdgeInsets.all(10),
                                                child: Container(
                                                    width: 100,
                                                    height: 150,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors.white70),
                                                    padding: const EdgeInsets
                                                        .fromLTRB(
                                                        20, 20, 20, 20),
                                                    child: Column(
                                                      children: [
                                                        Image.asset(
                                                          'images/assets/icon/1651334.png',
                                                          width: 50,
                                                          height: 50,
                                                          fit: BoxFit.cover,
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        const Text(
                                                            "Username or password is incorrect, please try again",
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .black),
                                                            textAlign: TextAlign
                                                                .center),
                                                      ],
                                                    )),
                                              );
                                            });
                                      }
                                    });
                                  });
                                }
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25.0),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
            )));
  }
}

import 'package:flutter/material.dart';
import 'package:pet_adoption_app/data/models/user.dart';
import 'package:pet_adoption_app/presentation/pages/controller_page.dart';

import '../../data/datasource/local_datasource/user_local_datasource.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  GlobalKey<FormState> key = GlobalKey();

  TextEditingController name = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          'Login Page ',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
          future: UserDataImp().hasSignedUp().then((value) {
            if (value == true) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ControllerPage()));
            }
          }),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              return Form(
                  key: key,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            controller: name,
                            decoration: const InputDecoration(
                              hintText: 'Name',
                              border: OutlineInputBorder(),
                            ),
                            validator: (text) {
                              if (text!.isEmpty) {
                                return 'field can not be null';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            controller: email,
                            decoration: const InputDecoration(
                              hintText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                            validator: (text) {
                              if (text!.isEmpty) {
                                return 'field can not be null';
                              }
                              if (text.length < 6 ||
                                  !text.contains('@') ||
                                  !text.endsWith('.com') ||
                                  text.startsWith('@')) {
                                return 'Wrong data ';
                              } else
                                return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            controller: password,
                            decoration: const InputDecoration(
                              hintText: 'Password',
                              border: OutlineInputBorder(),
                            ),
                            validator: (text) {
                              if (text!.isEmpty) {
                                return 'field can not be null';
                              }
                              if (text.length < 8) {
                                return 'password must be strong';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              if (key.currentState!.validate()) {
                                User user = User(
                                    name: name.text,
                                    email: email.text,
                                    password: password.text);
                                await UserDataImp().setUserData(user);
                                await UserDataImp()
                                    .getUserData()
                                    .then((value) => print(value));
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ControllerPage()));
                              }
                            },
                            child: const Text('Login')),
                      ],
                    ),
                  ));
            }
          }),
    );
  }
}

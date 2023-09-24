import 'package:flutter/material.dart';
import 'package:pet_adoption_app/presentation/pages/pets_page.dart';
import 'package:pet_adoption_app/presentation/pages/switch_page.dart';

class FormPage extends StatefulWidget {
  FormPage({Key? key}) : super(key: key);

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
      ),
      body: Form(
        key: key,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (text) {
                    if (text!.isEmpty) {
                      return 'field can not be null';
                    } else
                      return null;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: email,
                  decoration: InputDecoration(
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
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: password,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  validator: (text) {
                    if (text!.isEmpty) {
                      return 'field can not be null';
                    }
                    if (text.length < 8) {
                      return 'password must be strong';
                    } else
                      return null;
                  },
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (key.currentState!.validate()) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SwitchPage()));
                    }
                  },
                  child: Text('add')),
            ],
          ),
        ),
      ),
    );
  }
}

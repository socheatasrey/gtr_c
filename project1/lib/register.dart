import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Register());
}

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const RegisterPage(title: 'Register Form'),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.title});

  final String title;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool is_password_visible = false;
  bool is_verify_password_visible = false;

  String username = "";
  String password = "";
  String verify_password = "";

  TextEditingController controller_username = TextEditingController();
  TextEditingController controller_password = TextEditingController();
  TextEditingController controller_verify_password = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                Spacer(),
                Container(
                  width: 120,
                  alignment: Alignment.centerRight,
                  child: Text("Username: "),
                ),
                SizedBox(
                  width: 300,
                  child: TextField(controller: controller_username),
                ),
                Spacer(),
              ],
            ),

            Row(
              children: [
                Spacer(),
                Container(
                  width: 120,
                  alignment: Alignment.centerRight,
                  child: Text("Password: "),
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: controller_password,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          is_password_visible = !is_password_visible;
                          setState(() {});
                        },
                        icon: Icon(
                          is_password_visible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                    obscureText: !is_password_visible,
                  ),
                ),
                Spacer(),
              ],
            ),

            Row(
              children: [
                Spacer(),
                Container(
                  width: 120,
                  alignment: Alignment.centerRight,
                  child: Text("Verify Password: "),
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: controller_verify_password,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          is_verify_password_visible =
                              !is_verify_password_visible;
                          setState(() {});
                        },
                        icon: Icon(
                          is_verify_password_visible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                    obscureText: !is_verify_password_visible,
                  ),
                ),
                Spacer(),
              ],
            ),

            SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                username = controller_username.text;
                password = controller_password.text;
                verify_password = controller_verify_password.text;

                if (username.length < 5) {
                  print("usename shorter than 5 characters");
                  return;
                }

                if (verify_password != password) {
                  print("verify password incorrect");
                  return;
                }

                db.collection("collection_credential").add({
                  "username": username,
                  "password": password,
                });

                print("Register successful.");
              },
              child: Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}

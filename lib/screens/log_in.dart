import 'package:flutter/material.dart';

import '../webService/products_api.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final formkey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isNotVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Log in"), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Form(
            key: formkey,
            child: Column(
              spacing: 20,
              children: [
                Text(
                  'Log in',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),

                TextFormField(
                  controller: username,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please, Enter your Full name";
                    }
                    return null;
                  },
                  style: TextStyle(fontSize: 20),
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    labelText: 'Full name',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff4A249D),
                        width: 2.0,
                      ),
                    ),
                  ),
                ),

                TextFormField(
                  controller: password,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please, Enter your password";
                    }
                    if (value.length < 6) {
                      return "please, should be at least 6 char";
                    }
                    return null;
                  },
                  style: TextStyle(fontSize: 20),
                  textInputAction: TextInputAction.search,
                  obscureText: isNotVisible,

                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        ChangePasswordVisiable(!isNotVisible);
                        setState(() {});
                      },
                      icon: Icon(
                        isNotVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff4A249D),
                        width: 2.0,
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    if (formkey.currentState!.validate()) {
                      ProductsApi().userLogIn(username: username.text, password: password.text)
                          .then((data) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Login successful"),
                            content: Text("Welcome ${data['username']}"),
                          ),
                        );
                      }).catchError((error) {
                        showDialog(
                          context: context,
                          builder: (context) => const AlertDialog(
                            title: Text("Login unsuccessful"),
                          ),
                        );
                      });



                    }
                  },
                  child: Container(
                    height: 65,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Center(
                      child: Text(
                        'Log in',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(fontSize: 20),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Log in now',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void ChangePasswordVisiable(bool visible) {
    if (isNotVisible == visible) {
      return;
    } else
      isNotVisible = visible;
  }
}

import 'package:easemester_app/views/widget_tree.dart';
import 'package:flutter/material.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 180,
                  width: double.infinity,
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 150,
                      width: 150,
                    ),
                  ),
                ),
                Container(
                  height: 480,
                  width: double.infinity,
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      //sign in label
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      TextField(
                        //email
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        //password
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                      const SizedBox(height: 15),
                      //sign in btn
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                              return WidgetTree();
                                },
                              ),
                            );
                          },
                          child: const Text('Sign in'),
                        ),
                      ),
                      // or divider
                      const Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: Text("or"),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      //google sign in btn
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          color: Colors.white,
                          child: Center(
                            child: Image.asset(
                              'assets/images/g_logo.png',
                              height: 24,
                              width: 24,
                            ),
                          ),
                        ),
                      ),
                      //register phrase
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Don't have an account? Register",
                          style: TextStyle(fontSize: 14),
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
}


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/components/custom_btn.dart';
import 'package:todo_app/pages/MainPage.dart';
import 'package:todo_app/utils/GoogleSignIn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignInProvider _googleSignInProvider = GoogleSignInProvider();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String emailError = '';
  String passwordError = '';
  bool obscure = true;

  Future<void> login(BuildContext context) async {
    setState(() {
      emailError = '';
      passwordError = '';
    });

    if (email.text.isEmpty) {
      setState(() {
        emailError = 'Email cannot be empty';
      });
      return;
    }

    if (password.text.isEmpty) {
      setState(() {
        passwordError = 'Password cannot be empty';
      });
      return;
    }

    // if (email.text == password.text) {
    //   _saveCrential();
    //   Navigator.of(context)
    //       .push(MaterialPageRoute(builder: (context) => const HomePage()));
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('Invalid Credentials'),
    //       duration: Duration(seconds: 2), // Optional duration
    //     ),
    //   );
    // }
  }

  // void _saveCrential() async {
  //   await SharedPref.saveUser(email.text);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Center(
                  child: Image.network(
                "https://logomaster.ai/hubfs/gallery002.png",
                height: 200,
              )),
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Welcome Back!\nYou're missed",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: email,
                decoration: InputDecoration(
                  errorText: emailError.isNotEmpty ? emailError : null,

                  prefixIcon: const Icon(Icons.email),
                  border:
                      const OutlineInputBorder(), // Creates an outline border
                  focusedBorder: const OutlineInputBorder(
                    // Border when the field is focused
                    borderSide: BorderSide(
                      color: Colors.blue, // Adjust color as needed
                      width: 2.0, // Adjust border width as needed
                    ),
                  ),
                  labelText: "Email", // Placeholder text
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 10.0,
                  ), // Adjust height as needed
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: password,
                decoration: InputDecoration(
                  errorText: passwordError.isNotEmpty ? passwordError : null,
                  prefixIcon: const Icon(Icons.lock),
                  border:
                      const OutlineInputBorder(), // Creates an outline border
                  focusedBorder: const OutlineInputBorder(
                    // Border when the field is focused
                    borderSide: BorderSide(
                      color: Colors.blue, // Adjust color as needed
                      width: 2.0, // Adjust border width as needed
                    ),
                  ),
                  labelText: "Password", // Placeholder text
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 10.0,
                  ), // Adjust height as needed
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                    icon:
                        Icon(obscure ? Icons.visibility_off : Icons.visibility),
                  ),
                ),
                obscureText: obscure,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomBtn(text: "Login", onPressed: () => login(context)),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey[400],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'OR',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sign Up Using",
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon(Icons.g_mobiledata),
                  GestureDetector(
                    onTap: () async {
                      final User? user =
                          await _googleSignInProvider.signInWithGoogle();
                          print("Login");
                      if (user != null) {
                        print("Succedd");
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const MainPage()));
                      }
                      else{
                        print("Unable to authenticate");
                      }
                    },
                    child: Image.network(
                      "https://static-00.iconduck.com/assets.00/google-icon-2048x2048-tmg5cp5v.png",
                      height: 50,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Image.network(
                    "https://static.vecteezy.com/system/resources/thumbnails/018/910/719/small/facebook-logo-facebook-icon-free-free-vector.jpg",
                    height: 50,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Image.network(
                    "https://cdn-icons-png.flaticon.com/512/25/25231.png",
                    height: 40,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "By continuing, you agreee to our Terms of Use and Privacy Policy and Content Policies",
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}

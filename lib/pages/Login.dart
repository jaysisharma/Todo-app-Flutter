import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/components/custom_btn.dart';
import 'package:todo_app/pages/MainPage.dart';
import 'package:todo_app/pages/SignUpPage.dart';
import 'package:todo_app/utils/GoogleSignIn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignInProvider _googleSignInProvider = GoogleSignInProvider();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  String emailError = '';
  String passwordError = '';
  bool obscure = true;
  bool _isLoading = false; // Loading state variable

  Future<void> login(BuildContext context) async {
    setState(() {
      emailError = '';
      passwordError = '';
      _isLoading = true; // Show loader
    });

    final emailText = email.text.trim();
    final passwordText = password.text;

    if (emailText.isEmpty) {
      setState(() {
        emailError = 'Email cannot be empty';
        _isLoading = false; // Hide loader
      });
      return;
    }

    if (!RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailText)) {
      setState(() {
        emailError = 'Invalid email format';
        _isLoading = false; // Hide loader
      });
      return;
    }

    if (passwordText.isEmpty) {
      setState(() {
        passwordError = 'Password cannot be empty';
        _isLoading = false; // Hide loader
      });
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailText,
        password: passwordText,
      );
      if (userCredential.user != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainPage()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          duration: const Duration(seconds: 2),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false; // Hide loader
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Center(
                    child: Image.network(
                      "https://logomaster.ai/hubfs/gallery002.png",
                      height: 200,
                    ),
                  ),
                  const SizedBox(height: 50),
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
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                      labelText: "Email",
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10.0),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: password,
                    decoration: InputDecoration(
                      errorText: passwordError.isNotEmpty ? passwordError : null,
                      prefixIcon: const Icon(Icons.lock),
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                      labelText: "Password",
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10.0),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscure = !obscure;
                          });
                        },
                        icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
                      ),
                    ),
                    obscureText: obscure,
                  ),
                  const SizedBox(height: 20),
                  CustomBtn(text: "Login", onPressed: () => login(context)),
                  const SizedBox(height: 40),
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
                  const SizedBox(height: 40),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Sign Up Using"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final User? user = await _googleSignInProvider.signInWithGoogle();
                          if (user != null) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => const MainPage()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Unable to authenticate with Google'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        child: Image.network(
                          "https://static-00.iconduck.com/assets.00/google-icon-2048x2048-tmg5cp5v.png",
                          height: 50,
                        ),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          // Implement Facebook sign-in logic here
                        },
                        child: Image.network(
                          "https://static.vecteezy.com/system/resources/thumbnails/018/910/719/small/facebook-logo-facebook-icon-free-free-vector.jpg",
                          height: 50,
                        ),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          // Implement GitHub sign-in logic here
                        },
                        child: Image.network(
                          "https://cdn-icons-png.flaticon.com/512/25/25231.png",
                          height: 40,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "By continuing, you agree to our Terms of Use and Privacy Policy and Content Policies",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(color: Colors.grey),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const SignupPage()),
                          );
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}

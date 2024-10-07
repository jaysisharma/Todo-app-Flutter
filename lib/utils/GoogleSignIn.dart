import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_app/utils/Shared_Pref.dart';

class GoogleSignInProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        
        // Save login status
        await SharedPref.setLoginStatus(true);

        return userCredential.user;
      }
    } catch (e) {
      print('Error during Google sign-in: ${e.toString()}');
    }
    return null;
  }

  Future<void> signOutGoogle() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      
      // Optionally clear the login status
      await SharedPref.setLoginStatus(false);
    } catch (e) {
      print('Error during Google sign-out: ${e.toString()}');
    }
  }
}

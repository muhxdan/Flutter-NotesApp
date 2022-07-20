import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:note/app/modules/login/views/login_view.dart';

class AuthService {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  signIn() async {
    final _new = await _googleSignIn.signIn();
    final _googleAuth = await _new!.authentication;
    final _credential = GoogleAuthProvider.credential(
      accessToken: _googleAuth.accessToken,
      idToken: _googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(_credential);
  }

  signOut() async {
    await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
    Get.offAll(() => LoginView());
  }
}

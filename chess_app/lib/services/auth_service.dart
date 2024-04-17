import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken
    );


    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void signOut() async {
    FirebaseAuth.instance.signOut();
  }

  Stream<User?> get stream => FirebaseAuth.instance.authStateChanges().asBroadcastStream();

  Stream<bool> get loggedInStream => stream.map((user)=> user != null);
} 
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  //-----attributes------
  final FirebaseAuth _firebaseAuth =
      FirebaseAuth.instance; //Creates a FirebaseAuth.instance

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // final FacebookAuth facebookAuth = FacebookAuth.instance;

  // currentUser getter
  User? get currentUser => _firebaseAuth.currentUser;
  String? get displayName => _firebaseAuth.currentUser?.displayName;

  // authStateChanges getter
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  //check if user has verified email
  bool isEmailVerified() {
    return _firebaseAuth.currentUser!.emailVerified;
  }

  //reload to fetch latest data from firebase
  Future<void> reloadUser() async {
    await _firebaseAuth.currentUser?.reload();
  }

  //Sign's a User In
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  //Register User
  Future<String> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    final user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    return user.user!.uid;
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Sign in to Firebase with the Google user credentials
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        return userCredential.user;
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  // Future<User?> signInWithFacebook() async {
  //   try {
  //     // Trigger the sign-in flow
  //     final LoginResult loginResult = await facebookAuth.login();

  //     // Check if the login was successful
  //     if (loginResult.status == LoginStatus.success) {
  //       // Create a credential from the access token
  //       final OAuthCredential facebookAuthCredential =
  //           FacebookAuthProvider.credential(
  //               loginResult.accessToken!.tokenString);

  //       // Once signed in, return the UserCredential
  //       final UserCredential userCredential = await FirebaseAuth.instance
  //           .signInWithCredential(facebookAuthCredential);
  //       return userCredential.user;
  //     } else {
  //       // If the login wasn't successful, return null
  //       print(
  //           "Facebook sign-in failed: ${loginResult.status} - ${loginResult.message}");
  //       return null;
  //     }
  //   } catch (e) {
  //     // If an error occurs, log it and return null
  //     print("Error during Facebook sign-in: $e");
  //     return null;
  //   }
  // }

  // Get claims of the user
  Future<Map<String, dynamic>?> getUserClaims() async {
    final idTokenResult =
        await _firebaseAuth.currentUser!.getIdTokenResult(true);
    return idTokenResult.claims;
  }

  //User Sign Out Method
  Future<void> signUserOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }

  //save new user info
  Future<void> saveUserInfo() async {}

  // Future<UserCredential> signInWithGoogle() async {
  //   final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

  //   if (googleUser != null) {
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;

  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     return await _firebaseAuth.signInWithCredential(credential);
  //   }

  //   throw FirebaseAuthException(
  //     code: 'ERROR_ABORTED_BY_USER',
  //     message: 'Sign in aborted by user',
  //   );
  // }

  // Future<UserCredential> signInWithApple() async {
  //   final appleCredential = await SignInWithApple.getAppleIDCredential(
  //     scopes: [
  //       AppleIDAuthorizationScopes.email,
  //       AppleIDAuthorizationScopes.fullName,
  //     ],
  //   );

  //   final oauthCredential = OAuthProvider('apple.com').credential(
  //     idToken: appleCredential.identityToken,
  //     accessToken: appleCredential.authorizationCode,
  //   );

  //   final userCredential =
  //       await FirebaseAuth.instance.signInWithCredential(oauthCredential);

  //   return userCredential;
  // }

  //send verification email
  Future<void> sendVerificationEmail() async {
    await _firebaseAuth.currentUser!.sendEmailVerification();
  }
}

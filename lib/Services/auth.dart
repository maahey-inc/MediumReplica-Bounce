import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mediumreplica/Models/user.dart';
import 'db.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn gSignin = GoogleSignIn();

  //create user obj based on firebase
  Users? userFromFirebaseUser(User? user) {
    return user != null ? Users(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<Users?> get user {
    return auth.authStateChanges().asyncMap(userFromFirebaseUser);
    // .map(userFromFirebaseUser);
  }

  //get current user
  Future getCurrentUser() async {
    return auth.currentUser;
  }

  //sign in with email and password
  Future signInWithEmailandPassword(String email, String password) async {
    try {
      // AuthResult
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      return userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerWithEmailandPassword(
      String email, String password, String name) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;

      String img =
          'https://firebasestorage.googleapis.com/v0/b/bounce-e813b.appspot.com/o/dp.jpg?alt=media&token=965a7492-3392-4308-aded-885906194994';

      auth.currentUser?.updateDisplayName(name);
      auth.currentUser?.updatePhotoURL(img);

      await DatabaseService(uid: user.uid).updateUserData(email, name);

      return userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future googlesignin() async {
    try {
      GoogleSignInAccount? account = await gSignin.signIn();
      GoogleSignInAuthentication gAuth = await account!.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
          idToken: gAuth.idToken, accessToken: gAuth.accessToken);

      final UserCredential authResult =
          await auth.signInWithCredential(credential);
      final User? user = authResult.user;

      await DatabaseService(uid: user!.uid)
          .updateUserData(user.email!, user.displayName!);

      // userFromFirebaseUser(user);

      return userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }

    //
  }

  Future signInWithFacebook() async {
    try {
      final facebookLoginResult = await FacebookAuth.instance.login();

      if (facebookLoginResult != null) {
        final AuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(
                facebookLoginResult.accessToken!.token);

        final authResult =
            await auth.signInWithCredential(facebookAuthCredential);

        print('Result of user ${authResult.user}');
        final User? user = authResult.user;

        await DatabaseService(uid: user!.uid)
            .updateUserData(user.email!, user.displayName!);

        return userFromFirebaseUser(user);
      } else {
        throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign In aborted by user',
        );
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

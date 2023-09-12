import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends ChangeNotifier {
  //instance of auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //instance of firestore
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //sign in user
  Future<UserCredential?> signInWithEmailAndPassworddd(
      String email, String password, BuildContext context) async {
    try {
      //sign in
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      //add a new document for the user in users colleciton it if doesn't already exists
      _firebaseFirestore.collection('users').doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,
        "email": email,
      }, SetOptions(merge: true));

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No user found for that email.')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Wrong password provided for that user.')));
      }
    }
    return null;
  }

  //create a new user in email
  Future<UserCredential?> createUserEmailAndPass(
      String email, String password, BuildContext context) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      //after creating the user, create a new documnet for the user in the user collection
      _firebaseFirestore.collection('users').doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,
        "email": email,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Güçsüz şifre')));
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Kullanıcı mevcut')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Hata tekrar deneyiniz')));
      }
    }
    return null;
    //not notifyListeners(), because return UserCredential.
  }

  //sign user out
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      //await GoogleSignIn().signOut();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
    notifyListeners(); //simple
  }

  Future<User?> signInWithGoogle() async {
    try {
      // Google Sign-In için GoogleSignIn objesi oluşturun.
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // GoogleSign-In başarısız olduysa veya iptal edildiyse null döner.
      if (googleUser == null) return null;

      // GoogleSignInAccount objesini AuthCredential objesine dönüştürün.
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // AuthCredential kullanarak Firebase kullanıcısını oluşturun veya mevcut bir kullanıcıya bağlayın.
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      _firebaseFirestore.collection('users').doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,
        "email": userCredential.user!.email,
      });

      saveToUserName(userCredential.user!.uid,
          userCredential.user!.email ?? 'Empty user Name');
      // Firebase kullanıcısını döndürün.
      return userCredential.user;
    } catch (e) {
      // Hata durumunda null döndürün veya hata işleyin.
      throw Exception(e);
      //return null;
    }
  }

  void saveToUserName(String uid, String email) {
    try {
      _firebaseFirestore.collection('users').doc(uid).set({
        'userName': email.split('@')[0],
        'bio': 'Empty bio.',
      }, SetOptions(merge: true));
    } catch (e) {
      print('object');
    }
    notifyListeners();
  }
}

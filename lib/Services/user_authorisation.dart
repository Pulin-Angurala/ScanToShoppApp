import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/Models/app_user.dart';

class UserAuthorisation {
  final FirebaseAuth authenticator = FirebaseAuth.instance;

  //Create user object based on FirebaseUser
  AppUser? _userFromFirebaseUser (User? user){
    return user != null ? AppUser(userId: user.uid) : null;
  }

  // auth change user stream
  Stream<AppUser?> get user{
    return authenticator.authStateChanges().map((User? user)
    => _userFromFirebaseUser(user!));
  }

  Future signInWithEmailAndPass(String email, String password) async{
    try{
      UserCredential response = await authenticator.createUserWithEmailAndPassword(email: email, password: password);
      User? user = response.user;
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  Future logInWithEmailAndPass(String email, String password) async{
    try{
      UserCredential response = await authenticator.signInWithEmailAndPassword(email: email, password: password);
      User? user = response.user;
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  Future signOut() async{
    try{
      return await authenticator.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
}
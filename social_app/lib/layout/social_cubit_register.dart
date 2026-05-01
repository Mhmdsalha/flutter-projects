import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shop/layout/social_app_states.dart';
import 'package:shop/models/usermodel.dart';

class social_cubit_Register extends Cubit<social_app_states> {
  social_cubit_Register() : super(initialstate());

  static social_cubit_Register get(context) => BlocProvider.of(context);

  bool isObscure = true;
  void suffixIconpressed() {
    isObscure = !isObscure;
    emit(isObscure_state());
  }

  void userRegister(
      {required String email,
      required String name,
      required String phone,
      required String password}) {
    emit(register_loading());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      userCreate(
        Uid: value.user!.uid,
        name: name,
        email: email,
        phone: phone,
        token: await FirebaseMessaging.instance.getToken(),
      );
    }).catchError((error) {
      emit(error_register_state(error.toString()));
    });
  }

  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String Uid,
    required String? token,
  }) async {
    emit(createuser_loading());

    usermodel model = usermodel(
      token: token,
      email: email,
      name: name,
      phone: phone,
      uid: Uid,
      bio: 'bio...',
      profilephoto:
          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png',
      cover:
          'https://img.freepik.com/free-vector/character-illustration-people-holding-user-account-icons_53876-66068.jpg?w=1380&t=st=1657217097~exp=1657217697~hmac=b1a4c719bcbc904060d2cc29edd80263f60506bbabede4039d28a6dab5f3d329',
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(Uid)
        .set(model.tomap())
        .then((value) {
      emit(createuser_success(Uid, token.toString()));
    }).catchError((error) {
      emit(error_createuser_state(error.toString()));
    });
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> SignIn() async {
    GoogleSignInAccount? account = await googleSignIn.signIn();
    GoogleSignInAuthentication? authentication = await account?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: authentication?.accessToken,
      idToken: authentication?.idToken,
    );
    UserCredential authresult = await _auth.signInWithCredential(credential);
    User? user = authresult.user;
    if (user == null) {
      userCreate(
        Uid: '${user?.uid}',
        name: '${user?.displayName}',
        email: '${user?.email}',
        phone: '${user?.phoneNumber}',
        token: await FirebaseMessaging.instance.getToken(),
      );
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path/path.dart';
import 'package:shop/layout/social_app_states.dart';
import 'package:shop/layout/social_cubit_register.dart';
import 'package:shop/shered/Network/remote/dio_helper.dart';
import 'package:shop/shered/Network/remote/endpoint.dart';
import 'package:shop/shered/components/constants.dart';

class social_cubit_login extends Cubit<social_app_states> {
  social_cubit_login() : super(initialstate());

  static social_cubit_login get(context) => BlocProvider.of(context);

  bool isObscure = true;
  void suffixIconpressed() {
    isObscure = !isObscure;
    emit(isObscure_state());
  }

  void userlogin({
    required String email,
    required String password,
  }) {
    emit(login_loading());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(login_success(value.user!.uid));
    }).catchError((error) {
      emit(error_login_state(error.toString()));
    });
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> SignIn(context) async {
    GoogleSignInAccount? account = await googleSignIn.signIn();
    GoogleSignInAuthentication? authentication = await account?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: authentication?.accessToken,
      idToken: authentication?.idToken,
    );
    UserCredential authresult = await _auth.signInWithCredential(credential);
    User? user = authresult.user;
    emit(login_success('${user?.uid}'));
  }
}

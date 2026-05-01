import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop/layout/social_app_states.dart';
import 'package:shop/layout/social_cubit_home.dart';
import 'package:shop/models/post_model.dart';
import 'package:shop/models/usermodel.dart';
import 'package:shop/modules/feeds.dart';
import 'package:shop/modules/profile.dart';
import 'package:shop/modules/settings.dart';
import 'package:shop/modules/users.dart';
import 'package:shop/shered/Network/local/cache_helper.dart';
import 'package:shop/shered/components/constants.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class social_cubit_profile extends Cubit<social_app_states> {
  social_cubit_profile() : super(initialstate());

  static social_cubit_profile get(context) => BlocProvider.of(context);

  File? profileimage;
  final profileimagepicker = ImagePicker();

  Future<void> getprofileimage() async {
    final pickedFile =
        await profileimagepicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileimage = File(pickedFile.path);
      emit(getProfileimagestateSuccess());
    } else {
      print('No Image Selected');
      emit(getProfileimagestateErorr());
    }
  }

  File? coverimage;
  final coverimagepicker = ImagePicker();

  Future<void> getcoverimage() async {
    final pickedFile =
        await coverimagepicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverimage = File(pickedFile.path);
      emit(getCcoverimagestateSuccess());
    } else {
      print('No Image Selected');
      emit(getCcoverimagestateErorr());
    }
  }

  void uploadProfileimage({
    required BuildContext context,
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(uploadProfileimagestate_loading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileimage!.path).pathSegments.last}')
        .putFile(profileimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateuserdata(
          context: context,
          name: name,
          phone: phone,
          bio: bio,
          cover: social_cubit_home.get(context).usermodel_object!.cover!,
          profileimage: value,
        );
        PostModel? PostModel_object;
        PostModel_object?.updateprofileimage(value);

        emit(uploadProfileimagestateSuccess());
      }).catchError((error) {
        emit(uploadProfileimagestateErorr());
      });
    }).catchError((error) {
      emit(uploadProfileimagestateErorr());
    });
  }

  void uploadCoverimage({
    required BuildContext context,
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(uploadCcoverimagestate_loading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverimage!.path).pathSegments.last}')
        .putFile(coverimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateuserdata(
          context: context,
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
          profileimage:
              social_cubit_home.get(context).usermodel_object!.profilephoto!,
        );
        emit(uploadCcoverimagestateSuccess());
      }).catchError((error) {
        emit(uploadCcoverimagestateErorr());
      });
    }).catchError((error) {
      emit(uploadCcoverimagestateErorr());
    });
  }

  void updateuserdata({
    required BuildContext context,
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? profileimage,
  }) {
    emit(updatauserData_loading());
    usermodel model = usermodel(
        name: name,
        phone: phone,
        uid: Uid,
        bio: bio,
        email: social_cubit_home.get(context).usermodel_object?.email,
        profilephoto: profileimage,
        cover: cover,
        isEmailVerified: false);

    FirebaseFirestore.instance
        .collection('users')
        .doc(Uid)
        .update(model.tomap())
        .then((value) {
      emit(updatauserData_success());
      social_cubit_home.get(context).getUserData();
    }).catchError((error) {
      emit(updatauserData_error());
    });
  }
}

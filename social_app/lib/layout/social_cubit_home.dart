// ignore_for_file: unrelated_type_equality_checks

import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop/layout/social_app_states.dart';
import 'package:shop/models/comment_model.dart';
import 'package:shop/models/friendsmodel.dart';
import 'package:shop/models/friendsmodel2.dart';
import 'package:shop/models/massage_model.dart';
import 'package:shop/models/notifications_model.dart';
import 'package:shop/models/post_model.dart';
import 'package:shop/models/usermodel.dart';
import 'package:shop/models/usermodel_update.dart';
import 'package:shop/modules/Usreschat.dart';
import 'package:shop/modules/feeds.dart';
import 'package:shop/modules/profile.dart';
import 'package:shop/modules/settings.dart';
import 'package:shop/modules/users.dart';
import 'package:shop/shered/Network/local/cache_helper.dart';
import 'package:shop/shered/Network/remote/dio_helper.dart';
import 'package:shop/shered/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:shop/models/notifications_model.dart';
import 'package:shop/styles/textstyle.dart';
import 'package:shop/layout/main_cubit.dart';

class social_cubit_home extends Cubit<social_app_states> {
  social_cubit_home() : super(initialstate());

  static social_cubit_home get(context) => BlocProvider.of(context);

  var Usersprofilemodel;

  List<Widget> Screens = [
    feeds_screen(),
    Usreschat(),
    users_screen(),
    users_screen(),
    profile_screen(),
  ];
  List<String> appBarTitelEng = [
    'Home',
    'Chats',
    'Users',
    'Users',
    'Profile',
  ];
  List<String> appBarTitelArb = [
    'الصفحة الرئيسية',
    'المحادثات',
    'المستخدمين',
    'المستخدمين',
    'الملف الشخصي',
  ];

  int Currentindex = 0;

  void currentindex(int index) {
    if (index == 0) {
      usermodel_object = null;
      getUserData();
      getPosts();
      getmyfriends();
    }
    if (index == 1) {
      getmyfriends();
    }
    if (index == 2) {
      emit(addNewPostState());
    } else {
      Currentindex = index;
      emit(BNBstate());
    }

    if (index == 4) {
      usermodel_object = null;
      getUserData();
      getallusersPosts(Uid);
    }
  }

  usermodel? usermodel_object;
  usermodel_update? usermodel_update_object;

  void getUserData() {
    emit(getuser_loading());
    FirebaseFirestore.instance.collection('users').doc(Uid).get().then((value) {
      usermodel_object = usermodel.fromJson(value.data()!);
      usermodel_update_object = usermodel_update.fromJson(value.data()!);
      print(value.data()!);
      emit(getuser_success());
    }).catchError((error) {
      emit(error_getuser_state(error.toString()));
    });
  }

  File? postimage;
  final postimagepicker = ImagePicker();

  Future<void> getpostimage() async {
    final pickedFile =
        await postimagepicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postimage = File(pickedFile.path);
      emit(getPostimagestateSuccess());
    } else {
      print('No Image Selected');
      emit(getPostimagestateErorr());
    }
  }

  void UplodePost({
    required BuildContext context,
    required String postText,
  }) {
    emit(uploadPostimagestate_loading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postimage!.path).pathSegments.last}')
        .putFile(postimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        CreatePost(context: context, postImage: value, postText: postText);
        emit(uploadPostimagestateSuccess());
      }).catchError((error) {
        emit(uploadPostimagestateErorr());
      });
    }).catchError((error) {
      emit(uploadPostimagestateErorr());
    });
  }

  void CreatePost({
    required BuildContext context,
    String? postImage,
    required String postText,
  }) {
    emit(createPostloading());
    PostModel model = PostModel(
      token: usermodel_object?.token,
      name: usermodel_object?.name,
      uid: Uid,
      profilephoto: usermodel_object?.profilephoto,
      postDateTime: Timestamp.fromMillisecondsSinceEpoch(
          DateTime.now().millisecondsSinceEpoch),
      postText: postText,
      postImage: postImage,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.tomap())
        .then((value) {
      emit(createPostSuccess());
    }).catchError((error) {
      emit(createPostErorr());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(Uid)
        .collection('posts')
        .add(model.tomap())
        .then((value) {
      emit(createPostSuccess());
    }).catchError((error) {
      emit(createPostErorr());
    });
  }

  void deletePostImage() {
    postimage = null;
    emit(deletePostImagestate());
  }

  PostModel? PostModel_object;
  List<PostModel> myfriendspostsList = [];
  List<String> myfriendspostsListid = [];
  List<PostModel> allUsersPostsList = [];
  Map<String, List<PostModel>>? allUsersPosts = {};
  Map<String, int>? allUsersfriendsnum = {};
  List<String> postsId = [];
  Map<String, int> likes = {};
  List<comment_model> commentsList = [];
  Map<String, int> comments = {};
  Map<String, Map<String, dynamic>>? userputlike = {};
  Map<String, int> postsnum = {};
  Map<String, String> postdatauid = {};
  Map<String, String> postdatatoken = {};
  String postId = '';
  List<String> myfriendsid = [];

  void getPosts() {
    emit(getPosts_loading());
    FirebaseFirestore.instance
        .collection("posts")
        .orderBy('postDateTime', descending: true)
        .snapshots()
        .listen((event) {
      postdatauid = {};
      postdatatoken = {};
      myfriendspostsList = [];
      myfriendspostsListid = [];
      getmyfriends();
      event.docs.forEach((element) {
        if (element.data()['uid'] == Uid ||
            myfriendsid.contains(element.data()['uid'])) {
          myfriendspostsList.add(PostModel.fromJson(element.data()));
          myfriendspostsListid.add(element.id);
          postdatauid.addAll({element.id: element.data()['uid']});
          postdatatoken.addAll({element.id: element.data()['token']});
        }
        element.reference.collection('likes').get().then((value) {
          likes.addAll({element.id: value.docs.length});
          emit(getlikes_success());
          element.reference.collection('comments').get().then((value) {
            comments.addAll({element.id: value.docs.length});
            emit(getcomments_success());
          });
          FirebaseFirestore.instance
              .collection('posts')
              .doc(element.id)
              .collection('likes')
              .doc(Uid)
              .get()
              .then((value) {
            userputlike?.addAll({
              element.id: {Uid!: value.data()?['like']}
            });
            emit(getlikes_success());
          });
          emit(getPosts_success());
        });
        emit(getPosts_success());
      });
      emit(getPosts_success());
    });
  }

  void getallusersPosts(String? uid) {
    emit(getPosts_loading());
    FirebaseFirestore.instance
        .collection("posts")
        .orderBy('postDateTime', descending: true)
        .where('uid', isEqualTo: uid)
        .snapshots()
        .listen((event) {
      allUsersPostsList = [];
      postsId = [];
      event.docs.forEach((element) {
        allUsersPostsList.add(PostModel.fromJson(element.data()));
        postsId.add(element.id);
      });
      allUsersPosts?.addAll({uid!: allUsersPostsList});
      emit(getPosts_success());
    });
    emit(getPosts_success());
  }

  void getallusersfriendsnum(String? uid) {
    emit(getPosts_loading());
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("friends")
        .snapshots()
        .listen((event) {
      allUsersfriendsnum?.addAll({uid!: event.docs.length});
      emit(getallusersfriendsnum_success());
    });
    emit(getallusersfriendsnum_error());
  }

  void addlike(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(Uid)
        .set({'like': true}).then((value) {
      userputlike?.addAll({
        postId: {Uid!: true},
      });
      if (postdatauid[postId] != Uid) {
        SendNotifications(
          receivername: '',
          sendername: '',
          friendsRequest: false,
          title: '${usermodel_object?.name} put like to your post',
          body: '',
          token: '${postdatatoken[postId]}',
          receiveruid: '${postdatauid[postId]}',
          senderuid: '',
          senderprofileimage: '${usermodel_object?.profilephoto}',
          receiverprofileimage: '',
        );
      }
      getPosts();
      emit(likesPosts_success());
    });
  }

  void removelike(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(Uid)
        .delete()
        .then((value) {
      userputlike?.addAll({
        postId: {Uid!: false}
      });
      getPosts();
      emit(deletelikesPosts_success());
    });
  }

  CreateComment({
    required BuildContext context,
    required String commentText,
    required String postId,
  }) {
    comment_model model = comment_model(
      commentDateTime: Timestamp.fromMillisecondsSinceEpoch(
          DateTime.now().millisecondsSinceEpoch),
      name: usermodel_object?.name,
      uid: Uid,
      profilephoto: usermodel_object?.profilephoto,
      commentText: commentText,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(model.tomap())
        .then((value) {
      if (postdatauid[postId] != Uid) {
        SendNotifications(
          friendsRequest: false,
          title: '${usermodel_object?.name} add comment to your post',
          body: '',
          token: '${postdatatoken[postId]}',
          receiveruid: '${postdatauid[postId]}',
          senderuid: '${Uid}',
          senderprofileimage: '${usermodel_object?.profilephoto}',
          receiverprofileimage: '',
        );
      }
      emit(comments_success());

      getPosts();
    }).catchError((error) {
      emit(comments_error());
    });
  }

  void getcomments(String postId) {
    this.postId = postId;
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy('commentDateTime', descending: false)
        .snapshots()
        .listen((value) {
      commentsList = [];
      value.docs.forEach((element) {
        commentsList.add(comment_model.fromJson(element.data()));
      });
      emit(getcomments_success());
    });
  }

  List<usermodel> alluserlist = [];

  void getAllUsers() {
    if (alluserlist.isEmpty) {
      emit(getAlluser_loading());
      FirebaseFirestore.instance
          .collection('users')
          .snapshots()
          .listen((value) {
        alluserlist = [];
        value.docs.forEach((element) {
          if (element.data()['uid'] != Uid) {
            alluserlist.add(usermodel.fromJson(element.data()));
            emit(getAlluser_success());
          }
        });
      }).onError((error) {
        emit(error_getAlluser_state(error.toString()));
      });
    }
  }

  File? messageimage;
  final messageimagepicker = ImagePicker();

  Future<void> getmessageimage() async {
    final pickedFile =
        await messageimagepicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      messageimage = File(pickedFile.path);
      emit(getmessageimagestateSuccess());
    } else {
      print('No Image Selected');
      emit(getmessageimagestateErorr());
    }
  }

  void deletemessageimage() {
    messageimage = null;
    emit(deletemessageimagestate());
  }

  void Uplodemessage({
    required BuildContext context,
    required String? receiverId,
    required String? token,
  }) {
    emit(uploadmessageimagstate_loading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('messageimage/${Uri.file(messageimage!.path).pathSegments.last}')
        .putFile(messageimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        sendMassage(receiverId: receiverId, image: value, token: token);
        emit(uploadmessageimagstateSuccess());
      }).catchError((error) {
        emit(uploadmessageimagstateErorr());
      });
    }).catchError((error) {
      emit(uploadmessageimagstateErorr());
    });
  }

  void sendMassage({
    required String? receiverId,
    required String? token,
    String? massageText,
    String? image,
    String? replayedmassageText,
  }) {
    massage_model model = massage_model(
      token: token,
      replayedmassageText: replayedmassageText,
      massageText: massageText,
      senderId: Uid,
      receiverId: receiverId,
      DateTimemessage: FieldValue.serverTimestamp(),
      image: image,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(Uid)
        .collection('chats')
        .doc(receiverId)
        .collection('massage')
        .add(model.tomap())
        .then((value) async {
      emit(sendMassage_success());
    }).catchError((erorr) {
      emit(sendMassage_error());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(Uid)
        .collection('massage')
        .add(model.tomap())
        .then((value) async {
      emit(sendMassage_success());
      SendNotifications(
          title: messageimage == null
              ? '${usermodel_object?.name}  Sent you a message'
              : '${usermodel_object?.name}  Sent you a image',
          body: chattext.text,
          token: '${token}',
          receiveruid: '${receiverId}',
          senderuid: '${Uid}',
          senderprofileimage: '${usermodel_object?.profilephoto}',
          friendsRequest: false);
    }).catchError((erorr) {
      emit(sendMassage_error());
    });
  }

  List<massage_model> messageList = [];

  void getmessages(String receiverId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(Uid)
        .collection('chats')
        .doc(receiverId)
        .collection('massage')
        .orderBy('DateTimemessage', descending: false)
        .snapshots()
        .listen((event) {
      messageList = [];
      event.docs.reversed.forEach((element) {
        messageList.add(massage_model.fromJson(element.data()));
      });
      emit(getMassage_success());
      print('send');
    });
  }

  void SendNotifications(
      {required String title,
      String? receivername,
      String? sendername,
      String? body,
      required bool friendsRequest,
      required String token,
      required String senderuid,
      required String receiveruid,
      String? receiverprofileimage,
      required String senderprofileimage}) async {
    dio_helper.postdata(url: 'https://fcm.googleapis.com/fcm/send', data: {
      "to": "${token}",
      "notification": {
        "title": '$title',
        "body": body,
      },
      "android": {
        "importance": "Importance.max",
        "priority": "HIGH",
        "notification": {
          "notification_priority": "PRIORITY_MAX",
          "sound": "default",
          "default_sound": true,
          "default_vibrate_timings": true,
          "default_light_settings": true
        }
      },
      "data": {
        "type": "order",
        "id": "87",
        "click_action": "FLUTTER_NOTIFICATION_CLICK"
      }
    })?.then((value) {
      emit(SendMessageSuccessState());
      sendNotificationstoFirebase(
          token: token,
          receivername: receivername ?? '',
          sendername: sendername ?? '',
          friendsRequest: friendsRequest,
          title: title,
          senderuid: senderuid,
          receiveruid: receiveruid,
          body: body,
          receiverprofileimage: receiverprofileimage ?? '',
          senderprofileimage: senderprofileimage);
    });
  }

  void sendNotificationstoFirebase(
      {required String title,
      required String sendername,
      required String receivername,
      String? body,
      required String senderuid,
      required String token,
      required String receiveruid,
      required bool friendsRequest,
      required String receiverprofileimage,
      required String senderprofileimage}) {
    notifications_model model = notifications_model(
      token: token,
      sendername: sendername,
      receivername: receivername,
      receiveruid: receiveruid,
      senderuid: senderuid,
      senderprofileimage: senderprofileimage,
      receiverprofileimage: receiverprofileimage,
      friendsRequest: friendsRequest,
      title: '$title',
      body: body,
      notificationsDateTime: Timestamp.fromMillisecondsSinceEpoch(
          DateTime.now().millisecondsSinceEpoch),
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiveruid)
        .collection('Notifications')
        .add(model.tomap())
        .then((value) {
      emit(sendNotificationtoFB_SUCCESS());
    });
  }

  List<notifications_model> Notificationslist = [];
  List<String> Notificationslistid = [];
  Map<String, int> Notificationsnum = {};

  void getNotificationstoFirebase() {
    emit(getNotifications_loading());
    FirebaseFirestore.instance
        .collection('users')
        .doc(Uid)
        .collection('Notifications')
        .orderBy('notificationsDateTime', descending: true)
        .snapshots()
        .listen((event) {
      Notificationslist = [];
      Notificationslistid = [];
      Notificationsnum.addAll({Uid!: event.docs.length});
      event.docs.forEach((element) {
        Notificationslist.add(notifications_model.fromJson(element.data()));
        Notificationslistid.add(element.id);
        print(Notificationslistid);
      });
      emit(getNotifications_success());
    });
    emit(getNotifications_success());
  }

  void deleteNotificationstoFirebase() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(Uid)
        .collection('Notifications')
        .get()
        .then((event) {
      for (DocumentSnapshot doc in event.docs) {
        doc.reference.delete();
      }
      Notificationslist = [];
      emit(deleteNotifications());
    });
  }

  List<usermodel> searchuserslist = [];
  void searchusers(String username) {
    emit(getAlluser_loading());
    FirebaseFirestore.instance
        .collection('users')
        .where('name'.toLowerCase(), isEqualTo: username)
        .snapshots()
        .listen((value) {
      searchuserslist = [];
      value.docs.forEach((element) {
        if (element.data()['uid'] != Uid) {
          searchuserslist.add(usermodel.fromJson(element.data()));
          emit(getAlluser_success());
        }
      });
    }).onError((error) {
      emit(error_getAlluser_state(error.toString()));
    });
  }

  void sendFriendsRequest(String receiveruid) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiveruid)
        .collection('friendsRequest')
        .doc(Uid)
        .set({
      'name': usermodel_object?.name,
      'senderId': Uid,
    }).then((value) {
      emit(sendfriendsRequest_success());
    });
  }

  void deleteFriendsRequest(String receiveruid) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiveruid)
        .collection('friendsRequest')
        .doc(Uid)
        .delete()
        .then((value) {
      emit(sendfriendsRequest_success());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(Uid)
        .collection('friendsRequest')
        .doc(receiveruid)
        .delete()
        .then((value) {
      emit(sendfriendsRequest_success());
    });
  }

  void addFriends({
    required String myfriendname,
    required String myfrienduid,
    required String myfriendprofileimage,
    required String token,
  }) {
    friendsmodel model1 = friendsmodel(
        name: myfriendname,
        uid: myfrienduid,
        token: token,
        profileimage: myfriendprofileimage);
    friendsmodel2 model2 = friendsmodel2(
        name: usermodel_object?.name,
        uid: Uid,
        token: Token,
        profileimage: usermodel_object?.profilephoto);

    FirebaseFirestore.instance
        .collection('users')
        .doc(Uid)
        .collection('friends')
        .doc(myfrienduid)
        .set(model1.tomap())
        .then((value) {
      deleteFriendsRequest(Uid!);
      emit(addfriend_success());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(myfrienduid)
        .collection('friends')
        .doc(Uid)
        .set(model2.tomap())
        .then((value) {
      deleteFriendsRequest(Uid!);
      emit(addfriend_success());
    });
  }

  List<friendsmodel> myfriendslist = [];

  void getmyfriends() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(Uid)
        .collection('friends')
        .snapshots()
        .listen((event) {
      myfriendslist = [];
      myfriendsid = [];
      event.docs.forEach((element) {
        myfriendslist.add(friendsmodel.fromJson(element.data()));
        myfriendsid.add(element.id);
      });
      emit(getmyfriends_success());
    });
  }

  String replayedmessage = '';
  String receiverId = '';
  var formkey = GlobalKey<FormState>();
  var chattext = TextEditingController();
  bool replay = false;
  ScrollController listScrollController = ScrollController();

  void open_bottom_sheet(
    context,
    String? receiverId,
    String? token,
  ) {
    this.receiverId = receiverId!;
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 16.0,
                  bottom: 16.0,
                ),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      textstyle(
                          context: context,
                          arabicText: '${replayedmessage}',
                          englishText: '${replayedmessage}',
                          fontsize: 20,
                          TextAlign: TextAlign.start,
                          color: Colors.deepOrange),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: AlignmentDirectional.bottomCenter,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Cannot send empty message';
                                  } else
                                    KeyboardLockMode;
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                controller: chattext,
                                textDirection: main_cubit.get(context).isArabic
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: main_cubit.get(context).isArabic
                                      ? 'Tajawal'
                                      : 'Opificio_Bold_rounded',
                                ),
                                decoration: const InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.deepOrange, width: 1),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.deepOrange, width: 1),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                      ),
                                    ),
                                    hintText: 'Massage',
                                    fillColor: Colors.deepOrange,
                                    filled: true,
                                    border: InputBorder.none),
                              ),
                            ),
                            Container(
                              height: 60,
                              decoration: const BoxDecoration(
                                  color: Colors.deepOrange,
                                  borderRadius: BorderRadiusDirectional.only(
                                      topEnd: Radius.circular(15),
                                      bottomEnd: Radius.circular(15))),
                              child: Row(
                                children: [
                                  MaterialButton(
                                    onPressed: () {
                                      if (formkey.currentState!.validate()) {
                                        KeyboardLockMode;
                                        social_cubit_home
                                            .get(context)
                                            .sendMassage(
                                              receiverId: '${receiverId}',
                                              token: '${token}',
                                              replayedmassageText:
                                                  '${replayedmessage}',
                                              massageText: chattext.text,
                                            );
                                        replayedmessage = '';
                                        chattext.text = '';
                                        Navigator.pop(context);
                                        messageList = [];
                                        if (listScrollController.hasClients) {
                                          final position = listScrollController
                                              .position.minScrollExtent;
                                          listScrollController.jumpTo(position);
                                          listScrollController.animateTo(
                                            position,
                                            duration: Duration(seconds: 4),
                                            curve: Curves.bounceOut,
                                          );
                                        }
                                      }
                                      ;
                                    },
                                    minWidth: 1,
                                    child: const Icon(
                                      IconlyBroken.send,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }

  void sendreplaymessages() {
    emit(sendreplayedmessage_success());
  }

  void Emailaddressverification() {
    FirebaseAuth.instance.currentUser?.sendEmailVerification().then((value) {
      if (FirebaseAuth.instance.currentUser?.emailVerified == true) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(Uid)
            .update({'isEmailVerified': true});
      }
    });
    emit(sendEmailVerificationstate());
  }
}

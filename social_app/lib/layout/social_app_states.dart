import 'package:shop/models/usermodel.dart';

abstract class social_app_states {}

class initialstate extends social_app_states {}

class BNBstate extends social_app_states {}

class BSstate extends social_app_states {}

class isObscure_state extends social_app_states {}

class login_loading extends social_app_states {}

class login_success extends social_app_states {
  final String Uid;
  login_success(this.Uid);
}

class error_login_state extends social_app_states {
  final String error;
  error_login_state(this.error);
}

class register_loading extends social_app_states {}

class register_success extends social_app_states {}

class error_register_state extends social_app_states {
  final String error;
  error_register_state(this.error);
}

class createuser_loading extends social_app_states {}

class updatauserData_error extends social_app_states {}

class updatauserData_loading extends social_app_states {}

class updatauserData_success extends social_app_states {}

class createuser_success extends social_app_states {
  final String Uid;
  final String token;
  createuser_success(this.Uid, this.token);
}

class error_createuser_state extends social_app_states {
  final String error;
  error_createuser_state(this.error);
}

class getuser_loading extends social_app_states {}

class getuser_success extends social_app_states {}

class error_getuser_state extends social_app_states {
  final String error;
  error_getuser_state(this.error);
}

class getAlluser_loading extends social_app_states {}

class getAlluser_success extends social_app_states {}

class error_getAlluser_state extends social_app_states {
  final String error;
  error_getAlluser_state(this.error);
}

class addNewPostState extends social_app_states {}

class getProfileimagestateSuccess extends social_app_states {}

class getProfileimagestateErorr extends social_app_states {}

class uploadProfileimagestateSuccess extends social_app_states {}

class uploadProfileimagestate_loading extends social_app_states {}

class uploadProfileimagestateErorr extends social_app_states {}

class getCcoverimagestateSuccess extends social_app_states {}

class getCcoverimagestateErorr extends social_app_states {}

class uploadCcoverimagestateSuccess extends social_app_states {}

class uploadCcoverimagestate_loading extends social_app_states {}

class uploadCcoverimagestateErorr extends social_app_states {}

class createPostSuccess extends social_app_states {}

class deleteePostSuccess extends social_app_states {}

class createPostloading extends social_app_states {}

class createPostErorr extends social_app_states {}

class deletePostErorr extends social_app_states {}

class getPostimagestateSuccess extends social_app_states {}

class getmessageimagestateSuccess extends social_app_states {}

class getPostimagestateErorr extends social_app_states {}

class getmessageimagestateErorr extends social_app_states {}

class uploadmessageimagstateSuccess extends social_app_states {}

class uploadPostimagestateSuccess extends social_app_states {}

class uploadPostimagestate_loading extends social_app_states {}

class uploadmessageimagstate_loading extends social_app_states {}

class uploadPostimagestateErorr extends social_app_states {}

class uploadmessageimagstateErorr extends social_app_states {}

class deletePostImagestate extends social_app_states {}

class deletemessageimagestate extends social_app_states {}

class getPosts_loading extends social_app_states {}

class getPosts_success extends social_app_states {}

class getPosts_error extends social_app_states {}

class updatePosts_success extends social_app_states {}

class updatePosts_error extends social_app_states {}

class likesPosts_success extends social_app_states {}

class likesPosts_error extends social_app_states {}

class deletelikesPosts_success extends social_app_states {}

class deletelikesPosts_error extends social_app_states {}

class comments_success extends social_app_states {}

class comments_error extends social_app_states {}

class updatelikesState extends social_app_states {}

class updatepostsnum extends social_app_states {}

class updatelikesState_error extends social_app_states {}

class getcomments_loading extends social_app_states {}

class getNotifications_loading extends social_app_states {}

class getcomments_success extends social_app_states {}

class getcomments_error extends social_app_states {}

class sendMassage_success extends social_app_states {}

class sendMassage_error extends social_app_states {}

class getMassage_success extends social_app_states {}

class getreplayedmessage_success extends social_app_states {}

class sendreplayedmessage_success extends social_app_states {}

class getNotifications_success extends social_app_states {}

class getlikes_success extends social_app_states {}

class getmyfriends_success extends social_app_states {}

class getallusersfriendsnum_success extends social_app_states {}

class getmyfriends_error extends social_app_states {}

class getallusersfriendsnum_error extends social_app_states {}

class getMassage_error extends social_app_states {}

class SendMessageSuccessState extends social_app_states {}

class sendNotificationtoFB_SUCCESS extends social_app_states {}

class sendNotificationtoFB_ERORR extends social_app_states {}

class sendfriendsRequest_success extends social_app_states {}

class sendEmailVerificationstate extends social_app_states {}

class addfriend_success extends social_app_states {}

class updateNotificationNum extends social_app_states {}

class deleteNotifications extends social_app_states {}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:shop/layout/main_cubit.dart';
import 'package:shop/layout/social_app_states.dart';
import 'package:shop/layout/social_cubit_home.dart';
import 'package:shop/layout/social_cubit_profile.dart';
import 'package:shop/models/post_model.dart';
import 'package:shop/models/usermodel.dart';
import 'package:shop/modules/home_screen.dart';
import 'package:shop/shered/components/components.dart';
import 'package:shop/shered/components/constants.dart';
import 'package:shop/styles/Adaptive.dart';
import 'package:shop/styles/textstyle.dart';

class updateprofile_screen extends StatelessWidget {
  var nametext = TextEditingController();
  var biotext = TextEditingController();
  var phonetext = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<social_cubit_profile, social_app_states>(
      listener: (context, state) {
        if (state is updatauserData_success ||
            state is uploadProfileimagestateSuccess ||
            state is uploadCcoverimagestateSuccess) {
          toastbuilder(
              main_cubit.get(context).isArabic
                  ? 'تم التعديل بنجاح'
                  : 'Edited successfully',
              context);
          social_cubit_profile.get(context).coverimage = null;
          social_cubit_profile.get(context).profileimage = null;
        }
      },
      builder: (context, state) {
        var cubit = social_cubit_profile.get(context);
        var model = social_cubit_home.get(context).usermodel_object;
        var model2 = social_cubit_home.get(context).usermodel_update_object;
        nametext.text = model2!.name!;
        biotext.text = model2.bio!;
        phonetext.text = model2.phone!;

        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(IconlyBroken.arrow_left),
                  onPressed: () {
                    model = null;
                    social_cubit_home.get(context).getUserData();
                    social_cubit_home.get(context).currentindex(4);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => home_screen()),
                        (Route<dynamic> route) => false);
                    social_cubit_home.get(context).getUserData();
                  }),
              actions: [
                textbutton(
                    buttontextArabic: 'حفط',
                    buttontextEnglish: 'SAVE',
                    Color: Colors.deepOrange,
                    context: context,
                    function: () {
                      if (cubit.profileimage == null &&
                          cubit.coverimage == null) {
                        print('no image update');
                        cubit.updateuserdata(
                            context: context,
                            name: nametext.text == ''
                                ? model!.name!
                                : nametext.text,
                            phone: phonetext.text == ''
                                ? model!.phone!
                                : phonetext.text,
                            bio:
                                biotext.text == '' ? model!.bio! : biotext.text,
                            cover: model?.cover,
                            profileimage: model?.profilephoto);
                      } else if (cubit.profileimage != null &&
                          cubit.coverimage == null) {
                        print('profile image update');
                        cubit.uploadProfileimage(
                          context: context,
                          name: nametext.text == ''
                              ? model!.name!
                              : nametext.text,
                          phone: phonetext.text == ''
                              ? model!.phone!
                              : phonetext.text,
                          bio: biotext.text == '' ? model!.bio! : biotext.text,
                        );
                      } else if (cubit.profileimage == null &&
                          cubit.coverimage != null) {
                        print('cover image update');
                        cubit.uploadCoverimage(
                          context: context,
                          name: nametext.text == ''
                              ? model!.name!
                              : nametext.text,
                          phone: phonetext.text == ''
                              ? model!.phone!
                              : phonetext.text,
                          bio: biotext.text == '' ? model!.bio! : biotext.text,
                        );
                      } else {
                        print('cover and profile image update');
                        cubit.uploadProfileimage(
                          context: context,
                          name: nametext.text == ''
                              ? model!.name!
                              : nametext.text,
                          phone: phonetext.text == ''
                              ? model!.phone!
                              : phonetext.text,
                          bio: biotext.text == '' ? model!.bio! : biotext.text,
                        );
                        cubit.uploadCoverimage(
                          context: context,
                          name: nametext.text == ''
                              ? model!.name!
                              : nametext.text,
                          phone: phonetext.text == ''
                              ? model!.phone!
                              : phonetext.text,
                          bio: biotext.text == '' ? model!.bio! : biotext.text,
                        );
                      }
                    })
              ],
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Center(
                      child: Directionality(
                    textDirection: main_cubit.get(context).isArabic
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 225,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Card(
                                      margin: EdgeInsets.zero,
                                      child: Image(
                                        image: social_cubit_profile
                                                    .get(context)
                                                    .coverimage ==
                                                null
                                            ? NetworkImage('${model?.cover}')
                                            : FileImage(social_cubit_profile
                                                .get(context)
                                                .coverimage!) as ImageProvider,
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 170,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.deepOrange,
                                        child: IconButton(
                                            onPressed: () {
                                              social_cubit_profile
                                                  .get(context)
                                                  .getcoverimage();
                                            },
                                            icon: Icon(
                                              IconlyBroken.camera,
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CircleAvatar(
                                    radius: 55,
                                    backgroundColor: Colors.white,
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blue),
                                      child: CircleAvatar(
                                          backgroundImage: social_cubit_profile
                                                      .get(context)
                                                      .profileimage ==
                                                  null
                                              ? NetworkImage(
                                                  '${model?.profilephoto}')
                                              : FileImage(social_cubit_profile
                                                      .get(context)
                                                      .profileimage!)
                                                  as ImageProvider),
                                    ),
                                  ),
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.deepOrange,
                                    child: IconButton(
                                        onPressed: () {
                                          social_cubit_profile
                                              .get(context)
                                              .getprofileimage();
                                        },
                                        icon: Icon(
                                          IconlyBroken.camera,
                                          size: 18,
                                        )),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        divider2(context),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textstyle(
                                  context: context,
                                  arabicText: 'الاسم',
                                  englishText: 'Name',
                                  fontsize: 20,
                                  TextAlign: TextAlign.center,
                                  color: Colors.deepOrange),
                              defultTextfield(
                                  EdgeInsetsGeometry:
                                      EdgeInsetsDirectional.only(
                                    top: 20,
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                  onSubmitted: ((value) {
                                    model2.name = value;

                                    KeyboardLockMode;
                                  }),
                                  controller: nametext,
                                  keyboardType: TextInputType.text,
                                  labelText: 'Edit Your Name',
                                  prefixIcon: IconlyBroken.profile,
                                  context: context)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textstyle(
                                  context: context,
                                  arabicText: 'السيرة الذاتية',
                                  englishText: 'Bio',
                                  fontsize: 20,
                                  TextAlign: TextAlign.center,
                                  color: Colors.deepOrange),
                              defultTextfield(
                                  maxLines: 2,
                                  EdgeInsetsGeometry:
                                      EdgeInsetsDirectional.only(
                                    top: 20,
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                  onSubmitted: ((value) {
                                    model2.bio = value;

                                    KeyboardLockMode;
                                  }),
                                  controller: biotext,
                                  keyboardType: TextInputType.text,
                                  labelText: 'Bio',
                                  prefixIcon: IconlyBroken.profile,
                                  context: context)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textstyle(
                                  context: context,
                                  arabicText: 'رقم الهاتف',
                                  englishText: 'Phone',
                                  fontsize: 20,
                                  TextAlign: TextAlign.center,
                                  color: Colors.deepOrange),
                              defultTextfield(
                                  EdgeInsetsGeometry:
                                      EdgeInsetsDirectional.only(
                                    top: 20,
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                  onSubmitted: ((value) {
                                    model2.phone = value;
                                    KeyboardLockMode;
                                  }),
                                  controller: phonetext,
                                  keyboardType: TextInputType.text,
                                  labelText: 'Phone',
                                  prefixIcon: IconlyBroken.profile,
                                  context: context)
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
                ),
                if (state is updatauserData_loading ||
                    state is uploadProfileimagestate_loading ||
                    state is uploadCcoverimagestate_loading)
                  Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Color.fromARGB(61, 255, 255, 255),
                      child: Center(child: adaptive(os: getos())))
              ],
            ));
      },
    );
  }
}

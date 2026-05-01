import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shop/layout/main_cubit.dart';
import 'package:shop/modules/Register_screen.dart';
import 'package:shop/modules/login.dart';
import 'package:shop/shered/components/components.dart';
import 'package:shop/shered/components/constants.dart';
import 'package:shop/styles/textstyle.dart';
import 'package:shop/shered/Network/local/cache_helper.dart';

class welcome_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width / 0.5,
                  image: const AssetImage(
                      'lib/assets/images/vecteezy_online-marketing-ideas-grow-your-social-media-followers_5611706 [Converted].png')),
              const SizedBox(
                height: 30,
              ),
              textstyle(
                  color: Colors.deepOrange,
                  TextAlign: TextAlign.center,
                  context: context,
                  arabicText: 'مرحبا بك',
                  englishText: 'Hey! Welcome',
                  fontsize: 30),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.05,
                child: textstyle(
                    color: main_cubit.get(context).light
                        ? Color.fromRGBO(97, 97, 97, 1)
                        : Colors.grey,
                    TextAlign: TextAlign.center,
                    maxline: 3,
                    context: context,
                    arabicText:
                        ' اكتشف العالم و تتواصل مع الاصدقاء بسهولة و شارك يومك معهم  ',
                    englishText:
                        ' Discover the world, communicate with friends easily and share your day with them  ',
                    fontsize: 15),
              ),
              defultbutton(
                  width: MediaQuery.of(context).size.width / 1.1,
                  context: context,
                  Color: Colors.deepOrange,
                  function: () {
                    cache_helper
                        .savedata(key: 'skipwelcomeScreen', value: true)
                        .then((value) {
                      skipwelcomeScreen = true;
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Register_screen()),
                          (Route<dynamic> route) => false);
                    });
                  },
                  buttontextArabic: 'انضم الينا الان',
                  buttontextEnglish: 'Get Started'),
              const SizedBox(
                height: 10,
              ),
              textbutton(
                  context: context,
                  buttontextArabic: 'انا امتلك حساب بالفعل',
                  buttontextEnglish: 'I already have an account',
                  Color: main_cubit.get(context).light
                      ? Color.fromRGBO(97, 97, 97, 1)
                      : Colors.grey,
                  function: () {
                    cache_helper
                        .savedata(key: 'skipwelcomeScreen', value: true)
                        .then((value) {
                      skipwelcomeScreen = true;
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => login_screen()),
                          (Route<dynamic> route) => false);
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}

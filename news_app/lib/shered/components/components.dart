import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/layout/main_cubit.dart';
import 'package:news_app/layout/news_cubit.dart';
import 'package:news_app/modules/WebView.dart';

Widget newsbuild(Map model, context) {
  DateTime now = DateTime.parse('${model['publishedAt']}');
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => webview_screen(model['url'])));
    },
    child: Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 8,
        bottom: 10,
        top: 10,
      ),
      child: Expanded(
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage('${model['urlToImage']}'),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(
              width: 25,
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.topRight,
                        margin: const EdgeInsetsDirectional.only(
                          end: 10,
                        ),
                        child: Text('${model['title']}',
                            textAlign: TextAlign.start,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyText1),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsetsDirectional.only(top: 5),
                      child: Text(DateFormat.yMMMEd().format(now),
                          style: Theme.of(context).textTheme.bodyText2),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget newslistbuilder({required List list}) {
  return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => newsbuild(list[index], context),
      separatorBuilder: (context, index) => divider(),
      itemCount: list.length);
}

Widget divider() {
  return Container(
    height: 1,
    color: Colors.grey.withOpacity(0.2),
  );
}

Widget defultTextfield(
        {required final FormFieldValidator<String>? validator,
        required TextEditingController controller,
        required TextInputType keyboardType,
        required Color Color,
        required String labelText,
        required IconData prefixIcon,
        void Function(String)? onchange,
        IconData? suffixIcon,
        void Function()? suffixIconpressed,
        bool isPassword = false}) =>
    Container(
      margin: const EdgeInsetsDirectional.only(
        top: 20,
      ),
      child: TextFormField(
        obscureText: isPassword,
        validator: validator,
        controller: controller,
        style: TextStyle(
          color: Color,
          fontWeight: FontWeight.bold,
          fontFamily: 'Tajawal',
        ),
        keyboardType: keyboardType,
        onChanged: onchange,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Color, width: 2),
            ),
            labelStyle: TextStyle(color: Color),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Color, width: 2),
            ),
            labelText: labelText,
            prefixIcon: Icon(
              prefixIcon,
              color: Color,
            ),
            suffixIcon: suffixIcon != null
                ? IconButton(
                    onPressed: suffixIconpressed, icon: Icon(suffixIcon))
                : null),
      ),
    );

void changelanguage(context) {
  main_cubit.get(context).isarabic();
  news_cubit.get(context).lang = main_cubit.get(context).isArabic;
  news_cubit.get(context).Business = [];
  news_cubit.get(context).sports = [];
  news_cubit.get(context).science = [];
  news_cubit.get(context).getBusiness();
  news_cubit.get(context).getsports();
  news_cubit.get(context).getscience();
}

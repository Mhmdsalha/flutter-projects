import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/layout/main_cubit.dart';
import 'package:shop/layout/shop_cubit_update_profile.dart';
import 'package:shop/models/search_model.dart';
import 'package:shop/modules/shop_screen.dart';
import 'package:shop/shered/Network/local/cache_helper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shop/layout/shop_home_cubit.dart';
import 'package:shop/models/cart_Screen_model.dart';
import 'package:shop/models/category_model.dart';
import 'package:shop/models/favorite_Screen_model.dart';
import 'package:shop/models/home_model.dart';
import 'package:shop/models/profile_model.dart';
import 'package:shop/modules/login.dart';
import 'package:shop/modules/update_profile.dart';
import 'package:shop/shered/components/constants.dart';

Widget categorybuilderlist({
  required context,
  required categorymodel model,
}) {
  return ListView.separated(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) =>
          category_list_builder(model.data.datalist[index], context),
      separatorBuilder: (context, index) => const SizedBox(
            width: 4,
          ),
      itemCount: model.data.datalist.length);
}

Widget categorybuilder_screen({
  required context,
  required categorymodel model,
}) {
  return ListView.separated(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => Directionality(
            textDirection: main_cubit.get(context).isArabic
                ? TextDirection.rtl
                : TextDirection.ltr,
            child: category_screen_builder(model.data.datalist[index], context),
          ),
      separatorBuilder: (context, index) => const SizedBox(
            width: 4,
          ),
      itemCount: model.data.datalist.length);
}

Widget favorites_screen(
    {required context, required favorite_Screen_model model}) {
  return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) =>
          favorite_screen_builder(context, model.data!.data![index]),
      separatorBuilder: (context, index) => const SizedBox(
            width: 4,
          ),
      itemCount: model.data!.data!.length);
}

Widget search_screen({required context, required search_model model}) {
  return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) =>
          search_screen_builder(context, model.data.data[index]),
      separatorBuilder: (context, index) => const SizedBox(
            width: 4,
          ),
      itemCount: model.data.data.length);
}

Widget cart_screen({required context, required cart_Screen_model model}) {
  return ListView.separated(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) =>
          cart_screen_bilder(context, model.data!.data![index]),
      separatorBuilder: (context, index) => const SizedBox(
            width: 4,
          ),
      itemCount: model.data!.data!.length);
}

Widget defultbutton(
        {double width = double.infinity,
        required Color Color,
        required void Function() function,
        required String buttontext,
        context}) =>
    Container(
      decoration:
          BoxDecoration(color: Color, borderRadius: BorderRadius.circular(20)),
      width: width,
      height: 50,
      margin: const EdgeInsetsDirectional.only(top: 30),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          buttontext.toUpperCase(),
          style: TextStyle(
            fontFamily: main_cubit.get(context).isArabic
                ? 'Tajawal'
                : 'Opificio_Bold_rounded',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: main_cubit.get(context).light
                ? Theme.of(context).cardColor
                : Theme.of(context).primaryColor,
          ),
        ),
      ),
    );

Widget textbutton({
  required String text,
  required Color Color,
  context,
  required void Function() function,
  double size = 15,
}) {
  return Container(
    margin: const EdgeInsetsDirectional.only(
      top: 15,
    ),
    child: TextButton(
      onPressed: function,
      child: Text(
        text,
        style: TextStyle(
          fontFamily: main_cubit.get(context).isArabic
              ? 'Tajawal'
              : 'Opificio_Bold_rounded',
          color: Color,
          fontSize: size,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget divider() {
  return Container(
    height: 1,
    color: Colors.grey.withOpacity(0.2),
  );
}

Widget defultTextfield(
        {final FormFieldValidator<String>? validator,
        required TextEditingController controller,
        required TextInputType keyboardType,
        required Color Color,
        required String labelText,
        required IconData prefixIcon,
        void Function(String)? onchange,
        IconData? suffixIcon,
        void Function()? suffixIconpressed,
        void Function(String)? onSubmitted,
        required TextDirection textdirection,
        context,
        bool isPassword = false}) =>
    Container(
      margin: const EdgeInsetsDirectional.only(
        top: 20,
      ),
      child: TextFormField(
        obscureText: isPassword,
        validator: validator,
        onFieldSubmitted: onSubmitted,
        controller: controller,
        style: TextStyle(
          color: Color,
          fontWeight: FontWeight.bold,
          fontFamily: main_cubit.get(context).isArabic
              ? 'Tajawal'
              : 'Opificio_Bold_rounded',
        ),
        keyboardType: keyboardType,
        onChanged: onchange,
        decoration: InputDecoration(
            labelStyle: TextStyle(color: Color),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color, width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            labelText: labelText,
            prefixIcon: Icon(
              prefixIcon,
              color: Color,
            ),
            suffixIcon: suffixIcon != null
                ? IconButton(
                    onPressed: suffixIconpressed,
                    icon: Icon(
                      suffixIcon,
                      color: Color,
                    ))
                : null),
      ),
    );

Widget productsbuilder({
  required context,
  required homemodel? model,
  required categorymodel model_2,
}) {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              alignment: main_cubit.get(context).isArabic
                  ? Alignment.bottomRight
                  : Alignment.bottomLeft,
              child: Text(
                main_cubit.get(context).isArabic
                    ? ' مرحبا,  ${name}'
                    : 'Welcome, ${name}',
                textDirection: main_cubit.get(context).isArabic
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: main_cubit.get(context).isArabic
                      ? 'Tajawal'
                      : 'Opificio_Bold_rounded',
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 0.8,
            decoration: BoxDecoration(
              color: main_cubit.get(context).light
                  ? Theme.of(context).cardColor
                  : Theme.of(context).primaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(2, 3), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(30),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: CarouselSlider(
                options: CarouselOptions(
                    height: MediaQuery.of(context).size.height / 4.5,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(seconds: 2),
                    autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                    viewportFraction: 1),
                items: model!.data!.bannerslist
                    ?.map((e) => Image(
                          image: e.image != null
                              ? NetworkImage('${e.image}')
                              : const NetworkImage(
                                  'https://freedesignfile.com/upload/2020/07/Online-Shopping-Banner-Mobile-App-Vector.jpg'),
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ))
                    .toList()),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            alignment: main_cubit.get(context).isArabic
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Text(
              main_cubit.get(context).isArabic ? 'الاصناف' : 'Categories',
              style: TextStyle(
                  fontFamily: main_cubit.get(context).isArabic
                      ? 'Tajawal'
                      : 'Opificio_Bold_rounded',
                  fontSize: 25,
                  color: main_cubit.get(context).light
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).cardColor),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 170,
            child: Directionality(
                textDirection: main_cubit.get(context).isArabic
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: categorybuilderlist(
                  context: context,
                  model: model_2,
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            alignment: main_cubit.get(context).isArabic
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Text(
              main_cubit.get(context).isArabic
                  ? 'المنتجات الجديدة'
                  : 'New Products',
              style: TextStyle(
                  fontFamily: main_cubit.get(context).isArabic
                      ? 'Tajawal'
                      : 'Opificio_Bold_rounded',
                  fontSize: 25,
                  color: main_cubit.get(context).light
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).cardColor),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Directionality(
            textDirection: TextDirection.ltr,
            child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 3,
                mainAxisSpacing: 1,
                childAspectRatio: 1 / 1.65,
                children: List.generate(
                    model.data!.productslist!.length,
                    (index) => Column(
                          children: [
                            product_grid_builder(
                                model.data!.productslist![index], context)
                          ],
                        ))),
          )
        ]),
      ),
    ),
  );
}

Widget product_grid_builder(productsmodel model, context) {
  return Stack(
    alignment: AlignmentDirectional.bottomEnd,
    children: [
      Container(
        margin: const EdgeInsetsDirectional.all(5),
        height: MediaQuery.of(context).size.height / 3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(2, 1), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model.image),
                    height: 135,
                    width: 150,
                  ),
                  if (model.discount != 0)
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5)),
                      alignment: Alignment.center,
                      height: 20,
                      width: 70,
                      child: const Text(
                        ' DISCOUNT ',
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 150,
                child: Text(
                  model.name,
                  textDirection: main_cubit.get(context).isArabic
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: main_cubit.get(context).isArabic
                      ? TextAlign.right
                      : TextAlign.left,
                  style: TextStyle(
                    height: 1.5,
                    fontFamily: main_cubit.get(context).isArabic
                        ? 'Tajawal'
                        : 'Opificio_Bold_rounded',
                    color: Theme.of(context).primaryColor,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                alignment: Alignment.bottomLeft,
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        '${model.price.round()} EGP',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldprice.round()}',
                        //textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.lineThrough,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
              onPressed: () {
                shop_cubit_home.get(context).changefavorites(model.id);
                shop_cubit_home.get(context).get_favorites_data();
              },
              icon: Icon(Icons.favorite,
                  size: 30,
                  color:
                      shop_cubit_home.get(context).favorites_list[model.id] ==
                              true
                          ? Colors.red
                          : Colors.grey)),
          IconButton(
              onPressed: () {
                shop_cubit_home.get(context).add_to_cart(model.id);
                shop_cubit_home.get(context).get_cart_data();
              },
              icon: shop_cubit_home.get(context).cart_list[model.id] == true
                  ? Icon(
                      Icons.shopping_cart_checkout,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    )
                  : Icon(Icons.add_shopping_cart_sharp,
                      size: 30, color: Theme.of(context).primaryColor)),
        ],
      )
    ],
  );
}

Widget category_list_builder(data_model model, context) {
  return SizedBox(
    width: 110,
    child: Column(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: NetworkImage(model.image!), fit: BoxFit.fill),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          model.name!,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 15,
            fontFamily: main_cubit.get(context).isArabic
                ? 'Tajawal'
                : 'Opificio_Bold_rounded',
          ),
        ),
      ],
    ),
  );
}

Widget category_screen_builder(data_model model, context) {
  return Row(
    children: [
      Container(
        margin: const EdgeInsetsDirectional.only(start: 10, top: 10),
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: NetworkImage(model.image!), fit: BoxFit.fill),
        ),
      ),
      Container(
        margin: const EdgeInsetsDirectional.only(start: 10),
        child: Text(
          model.name!,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 15,
            color: main_cubit.get(context).light
                ? Theme.of(context).primaryColor
                : Theme.of(context).cardColor,
          ),
        ),
      ),
      const Spacer(),
      IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_forward_ios,
            color: main_cubit.get(context).light
                ? Theme.of(context).primaryColor
                : Theme.of(context).cardColor,
          ))
    ],
  );
}

Widget favorite_screen_builder(context, favoritesdata? model) {
  return Stack(
    alignment: main_cubit.get(context).isArabic
        ? Alignment.bottomLeft
        : Alignment.bottomRight,
    children: [
      Container(
        margin: const EdgeInsetsDirectional.all(10),
        height: 130,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(2, 1), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
            padding: const EdgeInsets.all(5),
            child: Directionality(
              textDirection: main_cubit.get(context).isArabic
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        Image(
                          image: NetworkImage(model!.product.image),
                          height: 120,
                          width: 120,
                        ),
                        if (model.product.discount != 0)
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(5)),
                            alignment: Alignment.center,
                            height: 20,
                            width: 70,
                            child: const Text(
                              'DISCOUNT',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            ),
                          )
                      ],
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      margin: const EdgeInsetsDirectional.only(top: 15),
                      width: MediaQuery.of(context).size.width / 1.76,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.product.name,
                            textAlign: main_cubit.get(context).isArabic
                                ? TextAlign.right
                                : TextAlign.left,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: main_cubit.get(context).isArabic
                                  ? 'Tajawal'
                                  : 'Opificio_Bold_rounded',
                              color: Theme.of(context).primaryColor,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                child: Text(
                                  '${model.product.price!} EGP',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              if (model.product.discount != 0)
                                Text(
                                  '${model.product.oldPrice}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    decoration: TextDecoration.lineThrough,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
      Container(
        margin:
            const EdgeInsetsDirectional.only(end: 15, bottom: 15, start: 10),
        child: IconButton(
            onPressed: () {
              shop_cubit_home.get(context).changefavorites(model.product.id);
              shop_cubit_home.get(context).favorite_Screen_model_object = null;
            },
            icon: Icon(
              Icons.favorite,
              color: shop_cubit_home
                          .get(context)
                          .favorites_list[model.product.id] ==
                      true
                  ? Colors.red
                  : Colors.grey,
              size: 35,
            )),
      )
    ],
  );
}

Widget search_screen_builder(context, search_data model) {
  return Container(
    margin: const EdgeInsetsDirectional.only(top: 10, start: 10, end: 10),
    height: 130,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          spreadRadius: 1,
          blurRadius: 3,
          offset: const Offset(2, 1), // changes position of shadow
        ),
      ],
    ),
    child: Padding(
        padding: const EdgeInsets.all(5),
        child: Directionality(
          textDirection: main_cubit.get(context).isArabic
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  height: 120,
                  width: 120,
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  margin: const EdgeInsetsDirectional.only(top: 15),
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.name,
                        textAlign: main_cubit.get(context).isArabic
                            ? TextAlign.right
                            : TextAlign.left,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: main_cubit.get(context).isArabic
                              ? 'Tajawal'
                              : 'Opificio_Bold_rounded',
                          color: Theme.of(context).primaryColor,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            '${model.price} EGP',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
  );
}

Widget cart_screen_bilder(context, CartItems model) {
  return Stack(
    alignment: main_cubit.get(context).isArabic
        ? Alignment.bottomLeft
        : Alignment.bottomRight,
    children: [
      Container(
          margin: const EdgeInsetsDirectional.all(10),
          height: 130,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(2, 1), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Directionality(
              textDirection: main_cubit.get(context).isArabic
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        Image(
                          image: NetworkImage(model.product.image!),
                          height: 120,
                          width: 120,
                        ),
                        if (model.product.discount != 0)
                          Container(
                            color: Colors.red,
                            child: const Text(
                              'DISCOUNT',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            ),
                          )
                      ],
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      margin: const EdgeInsetsDirectional.only(top: 15),
                      width: 220,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.product.name!,
                            textAlign: main_cubit.get(context).isArabic
                                ? TextAlign.right
                                : TextAlign.left,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: main_cubit.get(context).isArabic
                                  ? 'Tajawal'
                                  : 'Opificio_Bold_rounded',
                              color: Theme.of(context).primaryColor,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Container(
                                child: Text(
                                  '${model.product.price} EGP',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              if (model.product.discount != 0)
                                Text(
                                  '${model.product.oldPrice!}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    decoration: TextDecoration.lineThrough,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
      Container(
        margin:
            const EdgeInsetsDirectional.only(end: 15, bottom: 15, start: 10),
        child: IconButton(
            onPressed: () {
              shop_cubit_home.get(context).add_to_cart(model.product.id);
              shop_cubit_home.get(context).cart_Screen_model_object = null;
            },
            icon: Icon(
              Icons.delete,
              color: Theme.of(context).primaryColor,
              size: 35,
            )),
      ),
    ],
  );
}

Widget profilebuilder(context, profile_model? model) {
  return Center(
      child: Padding(
    padding: const EdgeInsets.all(10),
    child: Directionality(
      textDirection: main_cubit.get(context).isArabic
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsetsDirectional.all(5),
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(2, 1), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 55,
                  backgroundImage: NetworkImage(
                      'https://www.pinclipart.com/picdir/middle/355-3553881_stockvader-predicted-adig-user-profile-icon-png-clipart.png'),
                ),
                const SizedBox(
                  width: 5,
                ),
                SizedBox(
                  width: 210,
                  child: Text(
                    model!.data!.name,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 15, color: Theme.of(context).primaryColor),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Container(
              margin: const EdgeInsetsDirectional.only(start: 10),
              child: Row(
                children: [
                  Icon(
                    Icons.phone,
                    color: main_cubit.get(context).light
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).cardColor,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    model.data!.phone,
                    style: TextStyle(
                        color: main_cubit.get(context).light
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).cardColor),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 17,
          ),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Container(
              margin: const EdgeInsetsDirectional.only(start: 10),
              child: Row(
                children: [
                  Icon(
                    Icons.email,
                    color: main_cubit.get(context).light
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).cardColor,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    model.data!.email,
                    style: TextStyle(
                        color: main_cubit.get(context).light
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).cardColor,
                        fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Icon(
                Icons.language,
                color: main_cubit.get(context).light
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).cardColor,
                size: 30,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                main_cubit.get(context).isArabic
                    ? 'تغيير اللغة'
                    : 'Change Language',
                style: TextStyle(
                    fontFamily: main_cubit.get(context).isArabic
                        ? 'Tajawal'
                        : 'Opificio_Bold_rounded',
                    color: main_cubit.get(context).light
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).cardColor,
                    fontSize: 22),
              ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: main_cubit.get(context).light
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).cardColor,
                  size: 25,
                ),
                onPressed: () {
                  main_cubit.get(context).isarabic();
                  changelanguage(context);
                },
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Icon(
                Icons.dark_mode_outlined,
                color: main_cubit.get(context).light
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).cardColor,
                size: 30,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                  main_cubit.get(context).isArabic
                      ? 'الوضع الليلي'
                      : 'Dark Mode',
                  style: TextStyle(
                      fontFamily: main_cubit.get(context).isArabic
                          ? 'Tajawal'
                          : 'Opificio_Bold_rounded',
                      color: main_cubit.get(context).light
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).cardColor,
                      fontSize: 22)),
              const Spacer(),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: main_cubit.get(context).light
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).cardColor,
                  size: 25,
                ),
                onPressed: () {
                  main_cubit.get(context).Islight();
                },
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Icon(
                Icons.account_box,
                color: main_cubit.get(context).light
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).cardColor,
                size: 30,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                  main_cubit.get(context).isArabic
                      ? 'تعديل معلومات الحساب'
                      : 'Update Profile',
                  style: TextStyle(
                      fontFamily: main_cubit.get(context).isArabic
                          ? 'Tajawal'
                          : 'Opificio_Bold_rounded',
                      color: main_cubit.get(context).light
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).cardColor,
                      fontSize: 18)),
              const Spacer(),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: main_cubit.get(context).light
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).cardColor,
                  size: 25,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => update_profile()));
                },
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Icon(
                Icons.logout,
                color: main_cubit.get(context).light
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).cardColor,
                size: 30,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                  main_cubit.get(context).isArabic ? 'تسجيل الخروج' : 'Log Out',
                  style: TextStyle(
                      fontFamily: main_cubit.get(context).isArabic
                          ? 'Tajawal'
                          : 'Opificio_Bold_rounded',
                      color: main_cubit.get(context).light
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).cardColor,
                      fontSize: 22)),
              const Spacer(),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: main_cubit.get(context).light
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).cardColor,
                  size: 25,
                ),
                onPressed: () {
                  cache_helper.removedata(key: 'token');
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => login_screen()),
                      (Route<dynamic> route) => false);
                },
              ),
            ],
          ),
        ],
      ),
    ),
  ));
}

void changelanguage(context) {
  shop_cubit_update_profile.get(context).lang =
      main_cubit.get(context).isArabic;
  shop_cubit_home.get(context).home_model_object = null;
  shop_cubit_home.get(context).get_category_data();
  shop_cubit_home.get(context).favorite_Screen_model_object = null;
  shop_cubit_home.get(context).cart_Screen_model_object = null;
  shop_cubit_home.get(context).profile_model_object = null;
  shop_cubit_home.get(context).currentindex(0);
}

Future<bool?> toastbuilder(String msg, context) {
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: main_cubit.get(context).light
          ? Theme.of(context).cardColor
          : Theme.of(context).primaryColor,
      textColor: main_cubit.get(context).light
          ? Theme.of(context).primaryColor
          : Theme.of(context).cardColor,
      fontSize: 16.0);
}

Widget SPLASHSCREEN(Widget Next, context) {
  return Scaffold(
    body: EasySplashScreen(
      logo: const Image(
        image: AssetImage('lib/assets/images/appstore.png'),
      ),
      logoSize: 60,
      loaderColor: Color.fromRGBO(221, 223, 201, 1),
      backgroundColor: Color.fromARGB(255, 18, 18, 19),
      showLoader: true,
      loadingText: Text(
        main_cubit.get(context).isArabic ? 'جاري التحميل ..' : 'Loading .. ',
        textDirection: main_cubit.get(context).isArabic
            ? TextDirection.rtl
            : TextDirection.ltr,
        style: TextStyle(
          fontFamily: main_cubit.get(context).isArabic
              ? 'Tajawal'
              : 'Opificio_Bold_rounded',
        ),
      ),
      navigator: Directionality(
          textDirection: main_cubit.get(context).isArabic
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: Next),
      durationInSeconds: 5,
    ),
  );
}

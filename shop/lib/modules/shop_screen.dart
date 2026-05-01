import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shop/layout/main_cubit.dart';
import 'package:shop/layout/shop_home_cubit.dart';
import 'package:shop/layout/shop_states.dart';
import 'package:shop/modules/cart.dart';
import 'package:shop/modules/search.dart';

import '../shered/components/components.dart';

class home_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shop_cubit_home, shop_states>(
      listener: (context, state) {
        if (state is favorites_success) {
          toastbuilder(state.favoritessuccess.message, context);
        }
        if (state is cart_success) {
          toastbuilder(state.cartsuccess.message, context);
        }
      },
      builder: (context, state) {
        var cubit = shop_cubit_home.get(context);
        var cubit2 = main_cubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Directionality(
                textDirection: main_cubit.get(context).isArabic
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: Row(
                  children: [
                    Text(
                        main_cubit.get(context).isArabic
                            ? 'ســــلة'
                            : 'S A L L A',
                        style: TextStyle(
                            fontFamily: main_cubit.get(context).isArabic
                                ? 'Tajawal'
                                : 'Opificio_Bold_rounded',
                            color: main_cubit.get(context).light
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).cardColor,
                            fontSize: 30)),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => search()));
                        },
                        icon: const Icon(
                          Icons.search,
                          size: 30,
                        )),
                    IconButton(
                        onPressed: () {
                          cubit.get_cart_data();
                          cubit.cart_Screen_model_object = null;

                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => cart()));
                        },
                        icon: const Icon(
                          Icons.shopping_cart,
                          size: 30,
                        )),
                  ],
                )),
          ),
          bottomNavigationBar: Directionality(
            textDirection: main_cubit.get(context).isArabic
                ? TextDirection.rtl
                : TextDirection.ltr,
            child: GNav(
              activeColor: main_cubit.get(context).light
                  ? Theme.of(context).cardColor
                  : Theme.of(context).primaryColor,
              tabMargin: const EdgeInsets.all(5),
              curve: Curves.fastOutSlowIn,
              textStyle: Theme.of(context).textTheme.bodyText1,
              iconSize: 30,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              duration: const Duration(milliseconds: 200),
              tabBackgroundColor: main_cubit.get(context).light
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).cardColor,
              color: main_cubit.get(context).light
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).cardColor,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: ' Home',
                ),
                GButton(
                  icon: Icons.apps,
                  text: ' Cateogries',
                ),
                GButton(
                  icon: Icons.favorite,
                  text: ' Favorites',
                ),
                GButton(
                  icon: Icons.person,
                  text: ' Profile',
                ),
              ],
              selectedIndex: cubit.Currentindex,
              onTabChange: (index) {
                cubit.currentindex(index);
              },
            ),
          ),
          body: cubit.Screens[cubit.Currentindex],
        );
      },
    );
  }
}

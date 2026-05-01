import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey,
            leading: Icon(Icons.arrow_back),
            title: Text('MY App'),
            actions: [
              IconButton(
                onPressed: () {
                  print('menu is clicked');
                },
                icon: Icon(Icons.menu),
                iconSize: 30.0,
              ),
              IconButton(
                onPressed: () {
                  print('search is clicked');
                },
                icon: Icon(Icons.search),
                iconSize: 30.0,
                color: Colors.black,
              ),
            ],
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: const EdgeInsetsDirectional.only(
                    top: 2,
                    start: 5,
                    end: 5,
                  ),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        height: 200,
                        child: Image(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              'https://www.mindinventory.com/blog/wp-content/uploads/2022/05/flutter-3.png'),
                        ),
                      ),
                      Container(
                          color: Colors.blue,
                          width: double.infinity,
                          child: Text(
                            'Flutter 1',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          )),
                    ],
                  ),
                ),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: const EdgeInsetsDirectional.only(
                    top: 2,
                    end: 5,
                  ),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        height: 200,
                        child: Image(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              'https://www.mindinventory.com/blog/wp-content/uploads/2022/05/flutter-3.png'),
                        ),
                      ),
                      Container(
                          color: Colors.blue,
                          width: double.infinity,
                          child: Text(
                            'Flutter 1',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          )),
                    ],
                  ),
                ),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: const EdgeInsetsDirectional.only(
                    top: 2,
                    end: 5,
                  ),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        height: 200,
                        child: Image(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              'https://www.mindinventory.com/blog/wp-content/uploads/2022/05/flutter-3.png'),
                        ),
                      ),
                      Container(
                          color: Colors.blue,
                          width: double.infinity,
                          child: Text(
                            'Flutter 1',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          )),
                    ],
                  ),
                ),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: const EdgeInsetsDirectional.only(
                    top: 2,
                    end: 5,
                  ),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        height: 200,
                        child: Image(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              'https://www.mindinventory.com/blog/wp-content/uploads/2022/05/flutter-3.png'),
                        ),
                      ),
                      Container(
                          color: Colors.blue,
                          width: double.infinity,
                          child: Text(
                            'Flutter 1',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

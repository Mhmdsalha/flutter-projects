import 'package:flutter/material.dart';

class usermodeldata {
  final int id;
  final String name;
  final String phone;

  usermodeldata({required this.id, required this.name, required this.phone});
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  List<usermodeldata> users = [
    usermodeldata(id: 1, name: 'Mohammed Salha1', phone: '+970569383482'),
    usermodeldata(id: 2, name: 'Mohammed mohammed', phone: '+900000000000'),
    usermodeldata(id: 3, name: 'MOhammed Salha3', phone: '+888888888888'),
    usermodeldata(id: 4, name: 'MOhammed Salha4', phone: '+777777777777'),
    usermodeldata(id: 5, name: 'MOhammed Salha5', phone: '+666666666666'),
    usermodeldata(id: 6, name: 'MOhammed Salha6', phone: '+999999999999'),
    usermodeldata(id: 7, name: 'Mohammed Salha1', phone: '+970569383482'),
    usermodeldata(id: 8, name: 'Mohammed Salha2', phone: '+900000000000'),
    usermodeldata(id: 9, name: 'MOhammed Salha3', phone: '+888888888888'),
    usermodeldata(id: 10, name: 'MOhammed Salha4', phone: '+777777777777'),
    usermodeldata(id: 11, name: 'MOhammed Salha5', phone: '+666666666666'),
    usermodeldata(id: 13, name: 'MOhammed Salha6', phone: '+999999999999'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Users'),
        ),
        body: ListView.separated(
            itemBuilder: (context, index) => builduser(users[index]),
            separatorBuilder: (context, index) => Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                ),
            itemCount: users.length),
      ),
    );
  }

  Widget builduser(usermodeldata user) => Container(
        margin:
            const EdgeInsetsDirectional.only(top: 10, start: 10, bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              child: Text(
                '${user.id}',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.only(start: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${user.name}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('${user.phone}'),
                ],
              ),
            ),
          ],
        ),
      );
}

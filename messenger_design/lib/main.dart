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
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Row(
            children: [
              Container(
                margin: const EdgeInsetsDirectional.all(5),
                child: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage('https://bit.ly/3mAo2m2')),
              ),
              Container(
                margin: const EdgeInsetsDirectional.only(
                  start: 15,
                ),
                child: Text(
                  'Chats',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey.withOpacity(0.3),
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.black,
                      size: 25,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey.withOpacity(0.3),
                    child: Icon(
                      Icons.edit,
                      color: Colors.black,
                      size: 25,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsetsDirectional.all(18),
                height: 48,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(18)),
                child: Row(
                  children: [
                    Container(
                        margin: const EdgeInsetsDirectional.only(
                          start: 13,
                        ),
                        child: Icon(
                          Icons.search,
                          color: Colors.black.withOpacity(0.5),
                        )),
                    Container(
                        margin: const EdgeInsetsDirectional.only(
                          start: 10,
                        ),
                        child: Text(
                          'Search',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black.withOpacity(0.5)),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  height: 120,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => connected(),
                      separatorBuilder: (context, index) => SizedBox(
                            width: 5,
                          ),
                      itemCount: 10),
                ),
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => conversation(),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 5,
                      ),
                  itemCount: 20),
            ],
          ),
        ),
      ),
    );
  }

  Container connected() {
    return Container(
      margin: const EdgeInsetsDirectional.only(start: 5),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage('https://bit.ly/3mAo2m2'),
              ),
              CircleAvatar(
                radius: 8,
                backgroundColor: Colors.green,
              ),
            ],
          ),
          Container(
              width: 80,
              child: Text(
                'Mohammed Salha',
                style: TextStyle(fontSize: 11),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ))
        ],
      ),
    );
  }

  Container conversation() {
    return Container(
      margin: const EdgeInsetsDirectional.only(top: 10, start: 10, bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage('https://bit.ly/3mAo2m2'),
              ),
              CircleAvatar(
                radius: 8,
                backgroundColor: Colors.green,
              ),
            ],
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin:
                        const EdgeInsetsDirectional.only(start: 15, top: 10),
                    child: Container(
                      width: 200,
                      child: Text(
                        'Mohammed Salha',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsetsDirectional.only(start: 6, top: 5),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 150,
                            margin: const EdgeInsetsDirectional.only(
                                start: 10, top: 5),
                            child: Text(
                              'You: Hello mohammed how are you today',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 2,
                                backgroundColor: Colors.black,
                              ),
                              Container(
                                margin:
                                    const EdgeInsetsDirectional.only(start: 3),
                                child: Text('00:00 PM',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    )),
                              )
                            ],
                          ),
                        ]),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsetsDirectional.only(start: 25),
                child: CircleAvatar(
                  radius: 10,
                  backgroundImage: NetworkImage('https://bit.ly/3mAo2m2'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

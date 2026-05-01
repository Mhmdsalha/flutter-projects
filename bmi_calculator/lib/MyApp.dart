import 'dart:math';

import 'package:bmi_calculator/bmi_result.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool male = false;
  bool female = false;
  double value2 = 120;
  int age = 20;
  int weight = 40;
  double result = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        title: Center(
          child: Text(
            'BMI CALCULATOR',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Container(
          color: Colors.blueGrey,
          child: Expanded(
            child: Container(
              margin: const EdgeInsetsDirectional.only(top: 20),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              male = true;
                              female = false;
                            });
                          },
                          child: Container(
                            width: 165,
                            height: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  color: male ? Colors.blue : Colors.black,
                                  height: 150,
                                  width: 150,
                                  image: AssetImage('images/male.png'),
                                ),
                                Text(
                                  'MALE',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              female = true;
                              male = false;
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin:
                                  const EdgeInsetsDirectional.only(start: 25),
                              width: 165,
                              height: 200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    color: female ? Colors.pink : Colors.black,
                                    height: 150,
                                    width: 150,
                                    image: AssetImage('images/female.png'),
                                  ),
                                  Text(
                                    'FEMALE',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsetsDirectional.only(
                          start: 10, end: 15, bottom: 25, top: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'HEIGHT',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                '${value2.round()}',
                                style: TextStyle(
                                    fontSize: 50, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'cm',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Slider(
                              inactiveColor: Colors.black,
                              activeColor: Colors.blueGrey,
                              value: value2,
                              max: 220,
                              min: 50.0,
                              onChanged: (value) {
                                setState(() {
                                  value2 = value;
                                });
                              }),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    margin: const EdgeInsetsDirectional.only(bottom: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(3),
                          child: Container(
                            width: 165,
                            height: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'WEIGHT',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '$weight',
                                  style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FloatingActionButton(
                                      onPressed: () {
                                        setState(() {});
                                        if (weight > 0) {
                                          weight--;
                                        }
                                      },
                                      backgroundColor: Colors.blueGrey,
                                      child: Icon(
                                        Icons.remove,
                                        size: 40,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsetsDirectional.only(
                                          start: 5),
                                      child: FloatingActionButton(
                                        onPressed: () {
                                          setState(() {});
                                          weight++;
                                        },
                                        backgroundColor: Colors.blueGrey,
                                        child: Icon(
                                          Icons.add,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3),
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin:
                                  const EdgeInsetsDirectional.only(start: 25),
                              width: 165,
                              height: 200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'AGE',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '$age',
                                    style: TextStyle(
                                        fontSize: 50,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FloatingActionButton(
                                        onPressed: () {
                                          setState(() {
                                            if (age > 0) {
                                              age--;
                                            }
                                          });
                                        },
                                        backgroundColor: Colors.blueGrey,
                                        child: Icon(
                                          Icons.remove,
                                          size: 40,
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsetsDirectional.only(
                                                start: 5),
                                        child: FloatingActionButton(
                                          onPressed: () {
                                            setState(() {
                                              age++;
                                            });
                                          },
                                          backgroundColor: Colors.blueGrey,
                                          child: Icon(
                                            Icons.add,
                                            size: 40,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )),
                        ),
                      ],
                    ),
                  )),
                  Container(
                    width: double.infinity,
                    height: 70,
                    color: Colors.white,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          result = weight / pow(value2 / 100, 2);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => bmi_result(
                                        age: age,
                                        female: female,
                                        male: male,
                                        result: result,
                                        value2: value2,
                                        weight: weight,
                                      )));
                        });
                      },
                      child: Text(
                        'CALCULATE',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

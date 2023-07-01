//whats app

import 'package:flutter/material.dart';

class listview extends StatelessWidget {
  const listview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List view'),
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(16.0),
          itemBuilder: (ctx, index) {
            return Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Color.fromARGB(255, 255, 255, 255),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 223, 144, 247).withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ],
                border: Border.all(
                  color: Colors.purple,
                  width: 2.0,
                ),
              ),
              child: ListTile(
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.0),
                    Text(
                      "Name : Yadhukrishnan s",
                      style: TextStyle(
                          fontSize: 16.0,
                          // fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      "Roll NO : 57",
                      style: TextStyle(
                          fontSize: 16.0,
                          // fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Class : S6 CT ',
                      style: TextStyle(
                          fontSize: 16.0,
                          // fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: 8.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 150,
                          width: 700,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                              color: Colors.purple,
                              width: 1.0,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Date of leave : 19/05/2023",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                'Reason : feaver',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 18.0),
                    Text(
                      'STATUS : under processing',
                      style: TextStyle(
                          fontSize: 15.0,
                          // fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (ctx, index) {
            return Divider();
          },
          itemCount: 10,
        ),
      ),
    );
  }
}
//Text('Title $index'),
 // leading: CircleAvatar(
                //   radius: 25,
                //   backgroundColor: Colors.black,
                //   backgroundImage: AssetImage('android/assets/images/got3.jpg'),
                // ),
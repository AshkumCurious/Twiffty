import 'package:flutter/material.dart';
import 'package:twiffty/homepage.dart';
import 'package:twiffty/startpage.dart';
import 'globalvar.dart';

class SelectPage extends StatefulWidget {
  const SelectPage({Key? key}) : super(key: key);

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 50.0,
              ),
              Image.asset('lib/images/start.png',
                height: 200.0,
                width: 200.0,
              ),
              Text("TWIFFTY",
                style: TextStyle(
                  fontSize: 30.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 10.0,
                ),
              ),
              SizedBox(
                height: 200.0,
              ),
              Text("Choose your Twiffy avatar",
                style: TextStyle(color: Colors.orange,
                  letterSpacing: 8.0,
                ),),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 15.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 50.0,
                      ),
                      GestureDetector(
                          onTap:(){
                            avatar=1;
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const StartPage()),
                            );
                            print ("bird "+avatar.toString()+" was clicked");
                          },
                          child: Container(
                            padding: EdgeInsets.all(15.0),
                              height: 300.0,
                              width: 240.0,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade100,
                                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                border: Border.all(width: 15.0,color: Colors.blue.shade300),
                              ),

                              child: Image.asset(avr[0],height: 100.0,width: 100.0,))),
                      SizedBox(
                        width: 50.0,
                      ),
                      GestureDetector(
                          onTap:(){
                            avatar=2;
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const StartPage()),
                            );
                            print ("bird "+avatar.toString()+" was clicked");
                          },
                          child: Container(
                              padding: EdgeInsets.all(15.0),
                              height: 300.0,
                              width: 240.0,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade100,
                                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                border: Border.all(width: 15.0,color: Colors.blue.shade300),
                              ),
                              child: Image.asset(avr[1],height: 100.0,width: 100.0,))),
                      SizedBox(
                        width: 50.0,
                      ),
                      GestureDetector(
                          onTap:(){
                            avatar=3;
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const StartPage()),
                            );
                            print ("bird "+avatar.toString()+" was clicked");
                          },
                          child: Container(
                              padding: EdgeInsets.all(15.0),
                              height: 300.0,
                              width: 240.0,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade100,
                                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                border: Border.all(width: 15.0,color: Colors.blue.shade300),
                              ),
                              child: Image.asset(avr[2],height: 100.0,width: 100.0,))),
                      SizedBox(
                        width: 50.0,
                      ),
                      GestureDetector(
                          onTap:(){
                            avatar=4;
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const StartPage()),
                            );
                            print ("bird "+avatar.toString()+" was clicked");
                          },
                          child: Container(padding: EdgeInsets.all(15.0),
                              height: 300.0,
                              width: 240.0,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade100,
                                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                border: Border.all(width: 15.0,color: Colors.blue.shade300),
                              ),child: Image.asset(avr[3],height: 100.0,width: 100.0,))),
                      SizedBox(
                        width: 50.0,
                      ),
                      GestureDetector(
                          onTap:(){
                            avatar=5;
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const StartPage()),
                            );
                            print ("bird "+avatar.toString()+" was clicked");
                          },
                          child: Container(
                              padding: EdgeInsets.all(15.0),
                              height: 300.0,
                              width: 240.0,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade100,
                                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                border: Border.all(width: 15.0,color: Colors.blue.shade300),
                              ),child: Image.asset(avr[4],height: 100.0,width: 100.0,))),
                      SizedBox(
                        width: 50.0,
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
}

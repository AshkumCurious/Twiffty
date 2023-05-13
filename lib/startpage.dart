import 'package:flutter/material.dart';
import 'globalvar.dart';
import 'homepage.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(avr[avatar-1],height: 200.0,width: 200.0,),
            SizedBox(
              height: 30.0,
            ),
            Text("Your avatar is ready to play",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28.0,
              color: Colors.white,
            ),
            ),
            SizedBox(
              height: 100.0,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: Container(
                height: 50.0,
                width: 200.0,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('START GAME',
                    style: TextStyle(
                      fontSize: 23.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

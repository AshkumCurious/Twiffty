import 'dart:async';

import 'package:flutter/material.dart';
import 'package:twiffty/barriers.dart';
import 'package:twiffty/bird.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYAxix = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYAxix;
  bool gameHasStarted = false;
  static double barrierXone=1;
  double barrierXtwo=barrierXone+1.5;
  double score=0;
  double bscore=0;


  void StartGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 50), (timer) {

      time += 0.03;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYAxix = initialHeight - height;
      });
      setState(() {
        if(barrierXone < -1.2)
        {
          barrierXone +=2.5;
        }
        else
        {
          barrierXone -=0.05;
        }
      });
      setState(() {
        if(barrierXtwo < -1.2)
        {
          barrierXtwo +=2.5;
        }
        else
        {
          barrierXtwo -=0.05;
        }
      });

      if (birdDead()) {
        if(score>bscore)
          {
            bscore=score;
          }
        timer.cancel();
        _showDialog();
      }
    });
  }

  void resetGame()
  {
    Navigator.pop(context);
    setState(() {
      birdYAxix=0;
      gameHasStarted=false;
      time=0;
      initialHeight=birdYAxix;
      score=0;
      barrierXone=1.0;
      barrierXtwo=barrierXone+1.5;
    });
  }

  void _showDialog(){
    showDialog(
        barrierDismissible: false,
        context: context, builder: (BuildContext context){
      return AlertDialog(
        backgroundColor: Colors.brown,
        title: Center(
          child: Text("GAME OVER",
            style: TextStyle(
              color: Colors.white,
            ),),
        ),
        actions: [
          GestureDetector(
            onTap: resetGame,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                padding: EdgeInsets.all(7),
                color: Colors.white,
                child: Text(
                  "PLAY AGAIN",
                  style: TextStyle(color: Colors.brown),
                ),
              ),
            ),
          )
        ],
      );
    });
  }
  void Jump() {
    setState(() {
      score++;
      time = 0;
      initialHeight = birdYAxix;
    });
  }

  bool birdDead(){
    if(birdYAxix < -1 || birdYAxix >1)
    {
      return true;
    }
    return false;
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          Jump();
        } else {
          StartGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 0),
                    alignment: Alignment(0, birdYAxix),
                    color: Colors.blue,
                    child: MyBird(),
                  ),
                  Container(
                    alignment: Alignment(0, -0.3),
                    child: gameHasStarted?Text(""):Text(
                      "TAP TO PLAY",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXone, 1.1),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(
                      size: 220.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXone, -1.1),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(
                      size: 110.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXtwo, 1.1),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(
                      size: 130.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXtwo, -1.1),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(
                      size: 200.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
                child: Container(
              color: Colors.brown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("SCORE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                      ),),
                      Text(score.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("BEST SCORE",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                        ),),
                      Text(bscore.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),),
                    ],
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

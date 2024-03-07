import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("Quiz"),
          centerTitle: true,
          backgroundColor: Colors.teal,
        ),
        body: const QuizArea(), 
      ),
    );
  }
}

class QuizArea extends StatefulWidget {
  const QuizArea({super.key});

  @override
  State<QuizArea> createState() => _QuizAreaState();
}

class Quiz{
  late String ques;
  late int ans;

  Quiz(String q, int a){
    ques = q; ans = a;
  }
}

class _QuizAreaState extends State<QuizArea> {
  
  static List <Quiz> questions = [
    Quiz("Sun is a star.", 1),
    Quiz("Earth is a planet.", 1),
    Quiz("Water is dry.", 0),
    Quiz("This app is built using flutter.", 1),
    Quiz("Fish can fly.", 0),
    Quiz("Blood is blue.", 0),
    Quiz("QUIZ OVER!", 2),
  ];

  static int idx = 0;
  Quiz curr = questions[idx];

  List <Widget> iconlist = [];

  int score = 0;
  String gameover = "";

  @override
  Widget build(BuildContext context) {

    void reloadPressed(){
      idx = 0;
      curr = questions[idx];
      iconlist.clear();
      gameover = "";
      score = 0;
    }

    void ansButtonPressed(int val){
      if(curr.ans == 2){

      } else if(curr.ans == val){
        iconlist.add(const Icon(Icons.check,
          color: Colors.green,
          size: 20,
        ));
        score++;
      } else {
        iconlist.add(const Icon(Icons.close,
          color: Colors.red,
          size: 20,
        ));
      }
      if(idx != questions.length - 1){
        idx++;
        curr = questions[idx];
        if(idx == questions.length - 1){
          iconlist.clear();
          iconlist.add(TextButton(
            onPressed: () {
              setState(() {
                reloadPressed();
              });
            }, 
            child: const Icon(
              Icons.refresh,
              color: Colors.white,
            )));
          gameover = " SCORE : $score";
        }
      } else {
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children : [
        Expanded(
          flex: 5,
          child: Center(
            child: Text("${curr.ques}\n$gameover",
              style: const TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: iconlist,
                ),
              ]
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.green,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.zero),
              )
            ),
            onPressed: (){
              setState(() {
                ansButtonPressed(1);
              });
            },
            child: const Text("True", 
              style: TextStyle(
                fontSize: 25, 
                color: Colors.white,
              ),
            ), 
          ),
        ),
        Expanded(
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.zero),
              )
            ),
            onPressed: (){
              setState(() {
                ansButtonPressed(0);
              });
            },
            child: const Text("False", 
              style: TextStyle(
                fontSize: 25, 
                color: Colors.white,
              ),
            ), 
          ),
        )
      ]
    );
  }
}
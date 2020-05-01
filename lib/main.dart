import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'quiz_brain.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  List<Icon> iconContent = [];
  QuestionBank questionBank = QuestionBank();

  void addICon(bool res) {
    setState(() {
      int z = questionBank.lastQuestion();
      if (z == 0) {
        Alert(
            context: context,
            title: 'Finished',
            desc: 'You have reached at the end of the quiz',
            buttons: [
              DialogButton(
                color: Colors.amber,
                child: Text(
                  'Restart',
                  style: TextStyle(
                      fontSize: 25.0
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              )
            ]
        ).show();
        iconContent = [];
        questionBank.resetQuestions();
      } else if (res == true) {
        iconContent.add(
          Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
        questionBank.nextQuestion();
      } else {
        iconContent.add(
          Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
        questionBank.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Quiz App'),
          ),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 7,
                child: Center(
                    child: Text(
                  questionBank.getQuestionText(),
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                )),
              ),
              Container(
                width: double.infinity,
                height: 60.0,
                color: Colors.green,
                child: FlatButton(
                  onPressed: () {
                    bool a = questionBank.checkAnswer(true);
                    addICon(a);
                  },
                  child: Text(
                    'True',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  color: Colors.green,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                width: double.infinity,
                height: 60.0,
                color: Colors.red,
                child: FlatButton(
                  onPressed: () {
                    bool b = questionBank.checkAnswer(false);
                    addICon(b);
                  },
                  child: Text(
                    'False',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  color: Colors.red,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                children: iconContent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

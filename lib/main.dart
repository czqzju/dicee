import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shake/shake.dart';

import 'dice.dart';

final int totalTimes = 3;

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          title: Text('Dicee'),
          backgroundColor: Colors.red,
        ),
        body: DicePage(),
      ),
    ),
  );
}

class DicePage extends StatefulWidget {
  @override
  _DicePageState createState() => _DicePageState();
}

Dice leftDice = Dice(1);
Dice rightDice = Dice(1);

class _DicePageState extends State<DicePage> {
  int curScore = 0;
  int timesLeft = totalTimes;
  bool _alertShow = false;

  bool checkFinished() {
    if (timesLeft <= 0) {
      if (_alertShow) return true;
      _alertShow = true;
      Alert(
        context: context,
        closeFunction: () {
          _alertShow = false;
        },
        style: AlertStyle(
          isOverlayTapDismiss: false,
          titleStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          descStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        title: "Dice Finished",
        desc: "Congratulations! Your highest score is $curScore!",
        buttons: [
          DialogButton(
            child: Text(
              "Restart",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              _alertShow = false;
              reStart();
              Navigator.pop(context);
            },
            width: 120,
          )
        ],
      ).show();
      return true;
    } else
      return false;
  }

  void reStart() {
    setState(() {
      curScore = 0;
      timesLeft = totalTimes;
    });
  }

  void onClick() {
    if (checkFinished()) return;
    setState(() {
      timesLeft--;
      leftDice.clickDice();
      rightDice.clickDice();
      int newScore = leftDice.getDiceNumber() + rightDice.getDiceNumber();
      if (newScore > curScore) curScore = newScore;
      if (curScore == 12) timesLeft = 0;
    });
    if (checkFinished()) return;
  }

  @override
  void initState() {
    super.initState();
    ShakeDetector detector = ShakeDetector.autoStart(onPhoneShake: () {
      onClick();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      'Current Highest Score:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      curScore.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Times left:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      timesLeft.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    child: Image.asset('images/dice' +
                        leftDice.getDiceNumber().toString() +
                        '.png'),
                    onPressed: () {
                      onClick();
                    },
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    child: Image.asset('images/dice' +
                        rightDice.getDiceNumber().toString() +
                        '.png'),
                    onPressed: () {
                      onClick();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

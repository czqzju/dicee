import 'dart:math';

class Dice {
  int _diceNumber;

  Dice(int diceNumber) {
    this._diceNumber = diceNumber;
  }

  int getDiceNumber() => this._diceNumber;

  int clickDice() {
    this._diceNumber = Random(Random().nextInt(100)).nextInt(6) + 1;
  }
}

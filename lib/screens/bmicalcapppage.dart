import 'package:bmicalcapp/calculator_brain.dart';

import 'results_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/bottom_button.dart';
import '../constants/constants.dart';
import '../components/icon_content.dart';
import '../components/reusable_card.dart';
import '../components/round_icon_button.dart';

enum Gender {
  male,
  female,
}
enum Operation {
  add,
  minus,
}

class BmiCalcAppPage extends StatefulWidget {
  @override
  _BmiCalcAppPageState createState() => _BmiCalcAppPageState();
}

class _BmiCalcAppPageState extends State<BmiCalcAppPage> {
  Gender selectedGender;
  int height = 180;
  int weight = 60;
  int age = 21;
  // Color maleCardColor = inactiveCardColor;
  // Color femaleCardColor = inactiveCardColor;
  // void updateColor(Gender selectedGender) {
  // selectedGender == Gender.male ? activeCardColor : inactiveCardColor
  //   switch (selectedGender) {
  //     case Gender.male:
  //       if (maleCardColor == inactiveCardColor) {
  //         maleCardColor = activeCardColor;
  //         femaleCardColor = inactiveCardColor;
  //       } else {
  //         maleCardColor = inactiveCardColor;
  //       }
  //       break;
  //     case Gender.female:
  //       if (femaleCardColor == inactiveCardColor) {
  //         femaleCardColor = activeCardColor;
  //         maleCardColor = inactiveCardColor;
  //       } else {
  //         femaleCardColor = inactiveCardColor;
  //       }
  //       break;

  //     default:
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: ReusableCard(
                  onPress: () => _setGender(Gender.male),
                  colour: selectedGender == Gender.male
                      ? kActiveCardColor
                      : kInactiveCardColor,
                  cardChild: IconContent(
                    icon: FontAwesomeIcons.mars,
                    label: 'MALE',
                  ),
                ),
              ),
              Expanded(
                child: ReusableCard(
                  onPress: () => _setGender(Gender.female),
                  colour: selectedGender == Gender.female
                      ? kActiveCardColor
                      : kInactiveCardColor,
                  cardChild: IconContent(
                    icon: FontAwesomeIcons.venus,
                    label: 'FEMALE',
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ReusableCard(
            colour: kActiveCardColor,
            cardChild: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Height'.toUpperCase(),
                  style: kLabelTextStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    Text(
                      height.toString(),
                      style: kNumberTextStyle,
                    ),
                    Text(
                      'cm',
                      style: kLabelTextStyle,
                    )
                  ],
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    inactiveTrackColor: Color(0xFF8D8E98),
                    activeTrackColor: Colors.white,
                    thumbColor: Color(0xFFEB1555),
                    overlayColor: Color(0x29EB1555),
                    thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius: 10.0,
                    ),
                    overlayShape: RoundSliderOverlayShape(
                      overlayRadius: 20.0,
                    ),
                  ),
                  child: Slider(
                    value: height.toDouble(),
                    min: 120,
                    max: 220,
                    //  divisions: 10, //optional
                    onChanged: (double newValue) {
                      setState(() {
                        height = newValue.round();
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: ReusableCard(
                  colour: kActiveCardColor,
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Weight'.toUpperCase(),
                        style: kLabelTextStyle,
                      ),
                      Text(
                        weight.toString(),
                        style: kNumberTextStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          RoundIconButton(
                            icon: FontAwesomeIcons.minus,
                            useOperator: () => _setWeight(Operation.minus),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          RoundIconButton(
                            icon: FontAwesomeIcons.plus,
                            useOperator: () => _setWeight(Operation.add),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ReusableCard(
                  colour: kActiveCardColor,
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Age'.toUpperCase(),
                        style: kLabelTextStyle,
                      ),
                      Text(
                        age.toString(),
                        style: kNumberTextStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          RoundIconButton(
                            icon: FontAwesomeIcons.minus,
                            useOperator: () => _setAge(Operation.minus),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          RoundIconButton(
                            icon: FontAwesomeIcons.plus,
                            useOperator: () => _setAge(Operation.add),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        BottomButton(
          buttonTitle: 'CALCULATE',
          onTap: () => _calculateBMI(),
        ),
      ],
    );
  }

  void _setGender(Gender userSelectedGender) {
    setState(() {
      selectedGender = userSelectedGender;
    });
  }

  void _setWeight(Operation choiceOperator) {
    setState(() {
      choiceOperator == Operation.add
          ? weight++
          : weight > 0
              ? weight--
              : weight = 0;
    });
  }

  void _setAge(Operation choiceOperator) {
    setState(() {
      choiceOperator == Operation.add
          ? age++
          : age > 0
              ? age--
              : age = 0;
    });
  }

  void _calculateBMI() {
    CalculatorBrain calc = CalculatorBrain(height: height, weight: weight);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsPage(
          bmiResult: calc.calculateBMI(),
          resultText: calc.getResult(),
          interpretation: calc.getInterpretation(),
        ),
      ),
    );
  }
}

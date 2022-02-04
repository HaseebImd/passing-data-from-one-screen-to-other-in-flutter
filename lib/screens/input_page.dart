import 'package:BMI_calculator/calculator_brain.dart';
import 'package:BMI_calculator/components/round_button_icon.dart';
import 'package:BMI_calculator/screens/results_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/bottom_button.dart';
import '../components/icon_content.dart';
import '../components/reusable_card.dart';
import '../constant.dart';

enum Gender { Male, Female }

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender selectedGender;
  int height = 180;
  int weight = 30;
  int age = 1;
  String total_text='';
  String gender='';
  String error_message='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Final Lab Evaluation',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color:Colors.white,

          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10,),
            Expanded(
              child:Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(

                  decoration: InputDecoration(
                    icon: Icon(Icons.person,color: Colors.white,),
                    border: OutlineInputBorder(),
                    labelText: 'Your name',
                    hintText: 'Enter Your Name',
                    counterText: '${total_text.length.toString()}/30',
                    helperText: error_message,
                    helperStyle: TextStyle(color: Colors.white)

                  ),
                  maxLength: 30,
                  onChanged: (value) {
                    setState(() {
                      total_text = value;
                    });

                  },
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: new ReusableCard(
                      onPress: () {
                        setState(() {
                          selectedGender = Gender.Male;
                          gender="Male";
                        });
                      },
                      cardChild: IconContent(
                        icon: FontAwesomeIcons.mars,
                        label: 'MALE',
                      ),
                      colour: selectedGender == Gender.Male
                          ? kActiveCardColor
                          : kInActiveCardColor,
                    ),
                  ),
                  Expanded(
                    child: new ReusableCard(
                      cardChild: IconContent(
                        icon: FontAwesomeIcons.venus,
                        label: 'FEMALE',
                      ),
                      onPress: () {
                        setState(() {
                          selectedGender = Gender.Female;
                          gender="Female";
                        });
                      },
                      colour: selectedGender == Gender.Female
                          ? kActiveCardColor
                          : kInActiveCardColor,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: new ReusableCard(
                colour: kActiveCardColor,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Age',
                      style: kLabelStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          age.toString(),
                          style: kNumberTextStyle,
                        ),

                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.white,
                        inactiveTrackColor: Color(0xFF8D8E98),
                        thumbColor: Colors.amber,
                        overlayColor: Color(0x29EB1555),
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 15.0),
                        overlayShape:
                            RoundSliderThumbShape(enabledThumbRadius: 30.0),
                      ),
                      child: Slider(
                        value: age.toDouble(),
                        min: 1.0,
                        max: 50.0,
                        onChanged: (double newValue) {
                          setState(() {
                            age = newValue.round();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            BottomButton(

              buttonText: 'Next Proceed',
              onTap: () {
                if(total_text=='' || gender=='')
                  {
                    setState(() {
                      error_message="You need to selected Gender and provide Username";
                    });
                  }
                else {
                  Navigator.pushNamed(
                    context,
                    ResultPage.routeName,
                    arguments: ResultPage(
                      name: total_text,
                      gender: gender,
                      age: age.toString(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

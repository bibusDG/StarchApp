import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'warning_popup.dart';
import 'input_data_row.dart';
import 'output_data_row.dart';
import 'dart:math';


// final ScrollController _firstController = ScrollController();
class Enzyme extends StatefulWidget {


  const Enzyme({Key? key, required this.lossOnDrying}) : super(key: key);
  final int lossOnDrying;

  @override
  State<Enzyme> createState() => _EnzymeState();
}

class _EnzymeState extends State<Enzyme> {


  Map inputValues = {
    'starch dosing kg/t': '',
    'production t/h': '',
    'slurry conc. %': '',
    'final conc. %': '',
  };

  Map inputTextColor = {
    'starch dosing dry kg/t': Colors.black,
    'production t/h': Colors.black,
    'slurry conc. %': Colors.black,
    'final conc. %': Colors.black,
  };

  Map outputValues = {
    'starch consumption t/m': '',
    'slurry water l/h': '',
    'dilution water l/h': '',
    'enzyme flow l/h': '',
    'water consumption m3/m': '',
    'enzyme consumption m3/m': '',
  };

  void vectorCalculation() {
    setState(() {
      try {
        var intDosing = double.parse(inputValues['starch dosing kg/t']);
        var intFinalConc = double.parse((inputValues['final conc. %']));
        var intSlurryConc = double.parse((inputValues['slurry conc. %']));
        var intProduction = double.parse((inputValues['production t/h']));

        var starchConsumptionDry = (((intDosing*intProduction*(1-(widget.lossOnDrying/100)))*24*31)/1000);
        var slurryWater = (((intDosing*intProduction)*100*(1-(widget.lossOnDrying/100))) / (intSlurryConc)) -
            (intDosing*intProduction);
        var dilutionWater = ((slurryWater * intSlurryConc) / intFinalConc)-slurryWater;
        var enzymeFlow = pow((slurryWater*intSlurryConc),2)*0.002 / (slurryWater*intSlurryConc)/100;
        var totalEnzyme = (enzymeFlow *24*31)/1000;
        var totalWater = ((dilutionWater+slurryWater)*24*31)/1000;
        //
        //
        outputValues['starch consumption t/m'] = starchConsumptionDry.toStringAsFixed(1);
        outputValues['slurry water l/h'] = slurryWater.toStringAsFixed(1);
        outputValues['dilution water l/h'] = dilutionWater.toStringAsFixed(1);
        outputValues['enzyme flow l/h'] = enzymeFlow.toStringAsFixed(1);
        outputValues['water consumption m3/m'] = totalWater.toStringAsFixed(1);
        outputValues['enzyme consumption m3/m'] = totalEnzyme.toStringAsFixed(1);

      }on FormatException{
        showCupertinoDialog<void>(
          context: context,
          builder: (BuildContext context) => warningPopUp(warningText: 'Please check all fields'),
        );
      }
    });

    // print(outputValues['consumption t/h']);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CupertinoScrollbar(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Material(
                child: Column(
                  children: [
                    for (String inputData in inputValues.keys)
                      inputDataRow(inputData: inputData, inputValues: inputValues, textInputColor: inputTextColor, minValue: 0,),
                    for (String outputData in outputValues.keys)
                      outputDataRow(outputData: outputData, outputValues: outputValues),
                    CupertinoButton(color: Colors.teal,
                        child: Text('CALCULATE',
                          style: TextStyle(
                            fontFamily: 'Gruppo',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          if (widget.lossOnDrying == 0){
                            showCupertinoDialog<void>(
                              context: context,
                              builder: (BuildContext context) => warningPopUp(warningText: 'Choose starch type'),
                            );
                          }else{
                            vectorCalculation();
                          }
                        })
                  ],
                ));
          },
          itemCount: 1,
        ),
      ),
    );
  }
}





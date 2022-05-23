import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'warning_popup.dart';
import 'input_data_row.dart';
import 'output_data_row.dart';


// final ScrollController _firstController = ScrollController();
class Evo extends StatefulWidget {


  const Evo({Key? key, required this.lossOnDrying}) : super(key: key);
  final int lossOnDrying;

  @override
  State<Evo> createState() => _EvoState();
}

class _EvoState extends State<Evo> {


  Map inputValues = {
    'batches/day': '',
    'days production/year': '',
    'latex price euro/t': '',
    'latex dry substance': '',
    'starch price euro/t': '',
    'dry solid starch glue %': '',
    'kg starch/part' : '',
    'dry solid latex %': '',
    'kg latex/part': '',


  };

  Map inputTextColor = {
    'batches/day': Colors.black,
    'days production/year': Colors.black,
    'latex price euro/t': Colors.black,
    'latex dry substance': Colors.black,
    'starch price euro/t': Colors.black,
    'dry solid starch glue %': Colors.black,
    'kg starch/part' : Colors.black,
    'dry solid latex %': Colors.black,
    'kg latex/part': Colors.black,

  };
  Map trialInputValues ={
    'latex parts': '',
    'evo parts': '',
  };

  Map standardInputValues = {
    'latex parts' : '',
    'evo parts': '',
  };

  Map outputValues = {
    'latex 100% dry e/t': '',
    'dry kg latex/part': '',
    'starch 100% dry e/t': '',
    'dry kg starch/part': '',
    'standard cost/batch': '',
    'trial cost/batch': '',
    'standard cost/day': '',
    'trial cost/day': '',
    'standard cost/year': '',
    'trial cost/year': '',
    'saving/year': '',
  };

  void vectorCalculation() {
    setState(() {
      try {

        var batchDay = double.parse(inputValues['batches/day']);
        var daysProduction = double.parse(inputValues['days production/year']);
        var latexPrice = double.parse(inputValues['latex price euro/t']);
        var latexDrySubstance = double.parse(inputValues['latex dry substance']);
        var evoPrice = double.parse(inputValues['starch price euro/t']);


        var drySolidStarchGlue = double.parse(inputValues['dry solid starch glue %']);
        var starchPart = double.parse(inputValues['kg starch/part']);
        var drySolidLatex = double.parse(inputValues['dry solid latex %']);
        var latexPart = double.parse(inputValues['kg latex/part']);
        
        var standardLatexParts = double.parse(standardInputValues['latex parts']);
        var standardEvoParts = double.parse(standardInputValues['evo parts']);
        var trialLatexParts = double.parse(trialInputValues['latex parts']);
        var trialEvoParts = double.parse(trialInputValues['evo parts']);

        var latexDryEuro = latexPrice * 100 / latexDrySubstance;
        var evoDryEuro = evoPrice * 100 / (100-widget.lossOnDrying);
        
        var latexDryPart = (latexPart * drySolidLatex)/100;
        var evoDryPart = (starchPart*drySolidStarchGlue)/ 100;

        var stdBatchCost = (standardEvoParts*evoDryPart*evoDryEuro)/1000 + (standardLatexParts*latexDryPart*latexDryEuro)/1000;
        var stdDayCost = stdBatchCost * batchDay;
        var stdYearCost = stdDayCost*daysProduction;

        var trialBatchCost = (trialEvoParts*evoDryPart*evoDryEuro)/1000 + (trialLatexParts*latexDryPart*latexDryEuro)/1000;
        var trialDayCost = trialBatchCost * batchDay;
        var trialYearCost = trialDayCost*daysProduction;

        var yearSavings = stdYearCost - trialYearCost;

        outputValues['latex 100% dry e/t'] = latexDryEuro.toStringAsFixed(1);
        outputValues['dry kg latex/part'] = latexDryPart.toStringAsFixed(1);
        outputValues['starch 100% dry e/t'] = evoDryEuro.toStringAsFixed(1);
        outputValues['dry kg starch/part'] = evoDryPart.toStringAsFixed(1);
        
        outputValues['standard cost/batch'] = stdBatchCost.toStringAsFixed(1);
        outputValues['trial cost/batch'] = trialBatchCost.toStringAsFixed(1);
        outputValues['standard cost/day'] = stdDayCost.toStringAsFixed(1);
        outputValues['trial cost/day'] = trialDayCost.toStringAsFixed(1);
        outputValues['standard cost/year'] = stdYearCost.toStringAsFixed(1);
        outputValues['trial cost/year'] = trialYearCost.toStringAsFixed(1);
        outputValues['saving/year'] = yearSavings.toStringAsFixed(1);
  

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
                    Text('STANDARD LATEX RECIPE',
                      style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                        fontSize: 19.0,
                        fontFamily: 'Gruppo',

                      ),),
                    for (String value in standardInputValues.keys)
                      inputDataRow(inputData: value, inputValues: standardInputValues,textInputColor: inputTextColor,minValue: -0.000000001,),
                    Text('TRIAL LATEX RECIPE',
                      style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                        fontSize: 19.0,
                        fontFamily: 'Gruppo',

                      ),),
                    for (String value in trialInputValues.keys)
                      inputDataRow(inputData: value, inputValues: trialInputValues, textInputColor: inputTextColor,minValue: -0.000000001,),
                    Text('CALCULATION RESULTS',
                      style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                        fontSize: 19.0,
                        fontFamily: 'Gruppo',

                      ),),

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





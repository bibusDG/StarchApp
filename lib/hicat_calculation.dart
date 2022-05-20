import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'warning_popup.dart';
import 'input_data_row.dart';
import 'output_data_row.dart';



const minRangeFactor = 0.75;
const maxRangeFactor = 1.20;


// final ScrollController _firstController = ScrollController();
class HiCat extends StatefulWidget {


  const HiCat({Key? key, required this.lossOnDrying}) : super(key: key);
  final int lossOnDrying;

  @override
  State<HiCat> createState() => _HiCatState();
}

class _HiCatState extends State<HiCat> {


  Map inputValues = {
    'starch dosing kg/t': '',
    'production t/h': '',
    'slurry conc. %': '',
    'final conc. %': '',
  };

  Map inputTextColor = {
    'starch dosing kg/t': Colors.black,
    'production t/h': Colors.black,
    'slurry conc. %': Colors.black,
    'final conc. %': Colors.black,
  };

  Map outputValues = {
    'consumption t/m': '',
    'cooker range kg/h': '',
    'slurry water l/h': '',
    'dilution water l/h': '',
    'water consumption m3/m': '',
  };

  void hicatCalculation() {
    setState(() {
      try {
        var intDosing = double.parse(inputValues['starch dosing kg/t']);
        var intSlurryConc = double.parse((inputValues['slurry conc. %']));
        var intFinalConc = double.parse((inputValues['final conc. %']));
        var intProduction = double.parse((inputValues['production t/h']));

        var cookerRangeMin = (minRangeFactor * intDosing * intProduction) * (1 - (widget.lossOnDrying / 100));
        var cookerRangeMax = (maxRangeFactor * intDosing * intProduction) * (1 - (widget.lossOnDrying / 100));
        var cookerRange = cookerRangeMin.toStringAsFixed(1) + ' - ' + cookerRangeMax.toStringAsFixed(1);

        var slurryWaterMin = (((cookerRangeMin * 100) / intSlurryConc) - cookerRangeMin);
        var slurryWaterMax = (((cookerRangeMax * 100) / intSlurryConc) - cookerRangeMax);
        var slurryWater = slurryWaterMin.toStringAsFixed(1) + ' - ' + slurryWaterMax.toStringAsFixed(1);

        var dilutionWaterMin = (((cookerRangeMin * 100) / intFinalConc) - cookerRangeMin - slurryWaterMin);
        var dilutionWaterMax = (((cookerRangeMax * 100) / intFinalConc) - cookerRangeMax - slurryWaterMax);
        var dilutionWater = dilutionWaterMin.toStringAsFixed(1) + ' - ' + dilutionWaterMax.toStringAsFixed(1);

        var totalWaterMin = ((dilutionWaterMin + slurryWaterMin) * 24 * 31) / 1000;
        var totalWaterMax = ((dilutionWaterMax + slurryWaterMax) * 24 * 31) / 1000;
        var totalWater = totalWaterMin.toStringAsFixed(1) + ' - ' + totalWaterMax.toStringAsFixed(1);

        outputValues['consumption t/m'] = ((intProduction * intDosing * 24 * 31) / 1000).toStringAsFixed(1);
        outputValues['cooker range kg/h'] = cookerRange;
        outputValues['slurry water l/h'] = slurryWater;
        outputValues['dilution water l/h'] = dilutionWater;
        outputValues['water consumption m3/m'] = totalWater;

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
                  inputDataRow(inputData: inputData, inputValues: inputValues, textInputColor: inputTextColor),
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
                        hicatCalculation();
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





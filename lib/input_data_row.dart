import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'warning_popup.dart';

TextEditingController controller = TextEditingController(text: "");


class inputDataRow extends StatelessWidget {
  const inputDataRow({
    Key? key,
    required this.inputData,
    required this.inputValues,
    required this.textInputColor,
    required this.minValue,

  }) : super(key: key);

  final String inputData;
  final Map inputValues;
  final Map textInputColor;
  final double minValue;



  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10.0, 15.0, 15.0, 15.0),
            child: Text(
              inputData.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                fontFamily: 'Gruppo',
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: CupertinoTextField(
            onSubmitted: (value) {
              if (value.isEmpty || double.parse(value) <= minValue ){
                inputValues[inputData] = '';
                textInputColor[inputData] = Colors.red;
                showCupertinoDialog<void>(
                  context: context,
                  builder: (BuildContext context) => warningPopUp(warningText: 'Values must be higher than 0'),
                );
              }else{
                inputValues[inputData] = value;
                textInputColor[inputData] = Colors.black;
              }
            },
            style: TextStyle(
              fontFamily: 'Gruppo',
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
              color: textInputColor[inputData],
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }
}
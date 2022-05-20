import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'warning_popup.dart';

TextEditingController controller = TextEditingController(text: "");

class outputDataRow extends StatelessWidget {
  const outputDataRow({
    Key? key,
    required this.outputData,
    required this.outputValues,
  }) : super(key: key);

  final String outputData;
  final Map outputValues;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10.0, 15.0, 15.0, 15.0),
            child: Text(
              outputData.toUpperCase(),
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
          child: Text(
            outputValues[outputData],
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Gruppo',
              color: Colors.teal,
            ),
          ),
        ),
      ],
    );
  }
}
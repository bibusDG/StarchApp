import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main_app_Bar.dart';
import 'product_list.dart';
import 'hicat_calculation.dart';
import 'vector_calculation.dart';
import 'enzyme_calculation.dart';

class CalculationPage extends StatefulWidget {
  const CalculationPage({Key? key}) : super(key: key);

  @override
  State<CalculationPage> createState() => _CalculationPageState();
}

class _CalculationPageState extends State<CalculationPage> {
  int selectedValue = 0;
  String chooseStarchText = 'CHOOSE';
  int lossOnDrying = 0;

  @override
  Widget build(BuildContext context) {
    final categoryName = ModalRoute.of(context)!.settings.arguments as Map;

    var products = data['product'][categoryName['mainName'].toUpperCase()];

    // take value for dry substance of product

    Widget calculationPage = Container();
    String productDrySubstance = '';

    if (categoryName['mainName'] == 'hi-cat') {
      productDrySubstance = 'Loss on drying';
      calculationPage = HiCat(lossOnDrying: lossOnDrying);
    }

    if (categoryName['mainName'] == 'vector') {
      productDrySubstance = 'Dry substance';
      calculationPage = Vector(lossOnDrying: lossOnDrying);
    }
    if (categoryName['mainName'] == 'enzyme') {
      productDrySubstance = 'Loss on drying';
      calculationPage = Enzyme(lossOnDrying: lossOnDrying);
    }
    // categoryName['mainName'] == 'vector'? productDrySubstance = 'Dry substance': null;
    categoryName['mainName'] == 'evo' ? productDrySubstance = 'Loss on drying' : null;
    // categoryName['mainName'] == 'enzyme'? productDrySubstance = 'Loss on drying': null;

    // if (chooseStarchText != 'CHOOSE') {
    //     lossOnDryingPath = data['product'][categoryName['mainName'].toUpperCase()]
    //     [chooseStarchText][productDrySubstance];
    //     setState(() {
    //       lossOnDrying = int.parse(lossOnDryingPath.substring(0,2));
    //     });
    // }

    void starchPicker() {
      showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
          width: 300,
          height: 250,
          child: CupertinoPicker(
            magnification: 1.3,
            backgroundColor: Colors.white,
            itemExtent: 30,
            scrollController: FixedExtentScrollController(initialItem: 0),
            children: [
              for (var product in products.keys) Text(product.toUpperCase()),
            ],
            onSelectedItemChanged: (value) {
              setState(() {
                selectedValue = value;
                chooseStarchText = products.keys.elementAt(selectedValue);
                lossOnDrying = int.parse(data['product'][categoryName['mainName'].toUpperCase()][chooseStarchText]
                        [productDrySubstance]
                    .substring(0, 2));
              });
            },
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: mainAppBar(
          appBarText: categoryName['mainName'].toUpperCase() + ' ' + categoryName['categoryName'].toUpperCase(),
          fontSize: 19.0,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 60.0,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'CHOOSE A STARCH',
                        style: TextStyle(fontSize: 20.0, fontFamily: 'Gruppo', fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: CupertinoButton(
                      onPressed: () {
                        starchPicker();
                      },
                      child: Text(
                        chooseStarchText.toUpperCase(),
                        style: TextStyle(
                          fontSize: 24.0,
                          fontFamily: 'Gruppo',
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'STARCH DRY SUBSTANCE',
                      style: TextStyle(fontSize: 20.0, fontFamily: 'Gruppo', fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    lossOnDrying.toString() + ' %',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: 'Gruppo',
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(flex: 1, child: calculationPage),
          ],
        ),
      ),
    );
  }
}

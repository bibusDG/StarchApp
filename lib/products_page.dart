import 'package:flutter/material.dart';
import 'main_app_Bar.dart';
import 'product_list.dart';
import 'package:flutter/cupertino.dart';


class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {

  String productName = '';
  var buttonTextColor = Colors.black;

  @override
  Widget build(BuildContext context) {

    final categoryName = ModalRoute.of(context)!.settings.arguments as Map;

    var productListNames = data['product'][categoryName['mainName'].toUpperCase()].keys;
    var typeOfRawMaterial = data['product'][categoryName['mainName'].toUpperCase()];

    Map buttonColors ={
      'Wheat': Colors.white70, 'Corn': Colors.yellow[600], 'Potato': Colors.brown[600], 'Pea':Colors.green[900],
      'Mix': Colors.blueGrey[600],
    };

    void showSpecification(BuildContext context){
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(productName.toUpperCase() + ' ' + 'SPEC.'),
          content: Column(
            children: [
              for (var specificationText in typeOfRawMaterial[productName].entries)
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0, top: 8.0, bottom: 8.0, right: 2.0),
                          child: Text(specificationText.key + ' : ',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 1.0,),
                          child: Text(specificationText.value,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.teal,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
            ],
          ),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              /// This parameter indicates the action would perform
              /// a destructive action such as deletion, and turns
              /// the action's text color to red.
              isDestructiveAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            )
          ],
        ),
      );
    } // function to show screen with specification for chosen product

    return SafeArea(
      child: Scaffold(
        appBar: mainAppBar(
          fontSize: 19.0,
          appBarText: categoryName['mainName'].toUpperCase() + '  ' +
              categoryName['categoryName'].toUpperCase(),
        ),
        body: GridView.count(
          crossAxisCount: 3,
          padding: EdgeInsets.all(20.0),
          crossAxisSpacing: 30.0,
          mainAxisSpacing: 20.0,
          children: [
            for (var name in productListNames)
              CircleAvatar(
                backgroundColor: buttonColors[typeOfRawMaterial[name]['Raw material']],
                radius: 20.0,
                child: CupertinoButton(
                  onPressed: (){
                    setState(() {
                      productName = name;
                    });
                    showSpecification(context);
                  },
                  minSize: 200.0,
                  pressedOpacity: 0.3,
                  child: Text(name.toUpperCase(),
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: buttonTextColor,
                      fontFamily: 'Gruppo',
                    ),
                  ),
                ),
              )
          ],

        ),
      ),
    );
  }
}


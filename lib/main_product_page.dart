import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:starch_app/main_app_Bar.dart';
import 'main_app_Bar.dart';


class MainProductPage extends StatefulWidget {
  const MainProductPage({Key? key}) : super(key: key);

  @override
  State<MainProductPage> createState() => _MainProductPageState();
}

class _MainProductPageState extends State<MainProductPage> {

  List subCategories =[
    'calculation', 'products'
  ];

  Map nextPage ={
    'calculation': '/calculationPage',
    'products': '/productsPage',
  };

  @override
  Widget build(BuildContext context) {

    final categoryName = ModalRoute.of(context)!.settings.arguments as Map;

    String mainName = categoryName['categoryName'];


    return SafeArea(
        child: Scaffold(
          appBar: mainAppBar(appBarText: categoryName['categoryName'].toUpperCase() + '  ' + 'MENU',
            fontSize: 19.0,),
          body: GridView.count(
            padding: EdgeInsets.all(50.0),
            crossAxisSpacing: 30.0,
            mainAxisSpacing: 20.0,
            crossAxisCount: 2,
            children: [
              for (var name in subCategories)
                CircleAvatar(
                  backgroundColor: Colors.teal,
                  radius: 20.0,
                  child: CupertinoButton(
                    onPressed: (){
                      Navigator.pushNamed(context, nextPage[name], arguments: {'categoryName': name,
                        'mainName': mainName});
                    },
                    minSize: 200.0,
                    pressedOpacity: 0.3,
                    child: Text(name.toUpperCase(),
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Gruppo',
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
    );
  }
}

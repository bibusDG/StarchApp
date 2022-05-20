import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'main_app_Bar.dart';


class MainPage extends StatefulWidget {

  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  List categoryButtons = [
    'hi-cat', 'vector', 'enzyme', 'evo',
  ];

  String marketPage = 'market';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: mainAppBar(appBarText: 'ROQUETTE TECHNICAL APP', fontSize: 19.0,),
        body: GridView.count(
          padding: EdgeInsets.all(50.0),
          crossAxisSpacing: 30.0,
          mainAxisSpacing: 30.0,
          crossAxisCount: 2,
          children: [
            for (var name in categoryButtons)
              CircleAvatar(
                backgroundColor: Colors.teal,
                radius: 20.0,
                child: CupertinoButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/mainProductPage', arguments: {'categoryName': name});
                  },
                  minSize: 200.0,
                  pressedOpacity: 0.3,
                  child: Text(name.toUpperCase(),
                    style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Gruppo',
                    ),
                  ),
                ),
              ),
              CircleAvatar(
              backgroundColor: Colors.teal,
              radius: 20.0,
              child: CupertinoButton(
                onPressed: (){
                  Navigator.pushNamed(context, '/marketPage', arguments: {'categoryName': marketPage});
                },
                minSize: 200.0,
                pressedOpacity: 0.3,
                child: Text('MARKET',
                  style: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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







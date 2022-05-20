
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';



class mainAppBar extends StatelessWidget implements PreferredSizeWidget{

  const mainAppBar({
    Key? key,required this.appBarText,
    required this.fontSize,
  }) : super(key: key);

  final String appBarText;
  final double fontSize;

  @override
  Size get preferredSize => const Size.fromHeight(45);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Expanded(flex:5,
            child: Center(child: Text(appBarText,
              style: TextStyle(
                fontSize: fontSize,
                fontFamily: 'Gruppo',
                fontWeight: FontWeight.bold,

              ),
            ),
            ),
          ),
          Expanded(flex:1,
            child: Center(
              child: CupertinoButton(
                onPressed: (){
                  if (appBarText.contains('ROQUETTE')){
                  }else{
                    Navigator.pushNamed(context, '/mainPage');
                  }
                },
                child: Icon(
                  CupertinoIcons.home,
                  color: Colors.black,
                  size: 40.0,
                ),
              ),

            ),
          ),
        ],
      ),
    );
  }
}
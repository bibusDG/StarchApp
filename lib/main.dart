import 'package:flutter/material.dart';
import 'main_page.dart';
import 'main_product_page.dart';
import 'calculation_page.dart';
import 'products_page.dart';
import 'starch_market.dart';

void main() {
  runApp(const StarchApp());
}

class StarchApp extends StatelessWidget {
  const StarchApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        theme: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(color: Colors.teal),),

        initialRoute:'/mainPage',
        routes:{
          '/mainPage': (context) => MainPage(),
          '/mainProductPage': (context) => MainProductPage(),
          '/productsPage': (context) => ProductsPage(),
          '/calculationPage': (context) => CalculationPage(),
          '/marketPage': (context) => MarketPage(),
        }


    );
  }
}

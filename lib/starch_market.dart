
import 'main_app_Bar.dart';
import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';


class MarketPage extends StatefulWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {

  @override
  Widget build(BuildContext context) {

    final categoryName = ModalRoute.of(context)!.settings.arguments as Map;

    // void _launchUrl() async {
    //   if (!await launchUrl(_url)) throw 'Could not launch $_url';}

    return SafeArea(
      child: Scaffold(
        appBar: mainAppBar(appBarText: categoryName['categoryName'].toUpperCase(),fontSize: 20.0,),
        // body:WebView(initialUrl: 'https://www.agritel.com/en/fr',
        //     javascriptMode: JavascriptMode.unrestricted),
      ),
    );
  }
}

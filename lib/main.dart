import 'package:english_card_app/packages/quote/qoute_model.dart';
import 'package:english_card_app/packages/quote/quote.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/landing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  // an thanh ngay gio
  await Quotes().getAll();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LandingPage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_translate/pages/main_translate_page.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const GoogleTranslate());
}

class GoogleTranslate extends StatelessWidget {
  const GoogleTranslate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainTranslatePage(),
    );
  }
}

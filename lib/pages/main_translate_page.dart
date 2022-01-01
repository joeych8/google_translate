import 'package:flutter/material.dart';
import 'package:google_translate/view/dropdown_button_view.dart';
import 'package:google_translate/view/inputfield_view.dart';
import 'package:google_translate/view/recent_translations_view.dart';
import 'package:google_translate/view/translated_text_view.dart';
import 'package:translator/translator.dart';
import 'package:google_translate/const/language_codes.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class MainTranslatePage extends StatefulWidget {
  const MainTranslatePage({Key? key}) : super(key: key);

  @override
  MainTranslatePageState createState() => MainTranslatePageState();
}

class MainTranslatePageState extends State<MainTranslatePage> {
  final _textFieldController = TextEditingController();
  final translator = GoogleTranslator();
  var translatedText = "";
  List<String> recentTranslationsList = [];
  List<String> recentTypedTextList = [];
  String fromLanguage = langs.values.first;
  String toLanguage =
      langs.values.firstWhere((element) => element == "English");

/*
  SharedPreferences? preferences;

  @override
  void initState() {
    super.initState();
    loadSharedPrefs();
  }
  void loadSharedPrefs() async {
    preferences = await SharedPreferences.getInstance();
    //preferences.getStringList(key)
  }
*/
  void _translate(String newValue) async {
    if (newValue.isEmpty) {
      setState(() {
        translatedText = "";
      });
      return;
    }

    String _chooseLanguage(String languageName) {
      var languageCode = "";
      var languageMap =
          langs.entries.firstWhere((element) => element.value == languageName);
      languageCode = languageMap.key;

      return languageCode;
    }

    //0.5 seconds delay before translating text after user input.
    Future.delayed(Duration(milliseconds: 500), () async {
      if (newValue == _textFieldController.text) {
        await translator
            .translate(_textFieldController.text,
                from: _chooseLanguage(fromLanguage),
                to: _chooseLanguage(toLanguage))
            .then((value) {
          setState(() {
            translatedText = value.text;
            //Translated text added to RecentTranslatedList
            recentTranslationsList.add(translatedText);
            //Recent typed text added to RecentTypedTextList
            recentTypedTextList.add(_textFieldController.text);
          });
        });
      } else {
        return;
      }
    });
  }

  void _submit(String newValue) {
    setState(() {
      translatedText = '';
      _textFieldController.clear();
    });
  }

  void _onSubmitToLang(String? newValue) {
    setState(() {
      toLanguage = newValue!;
    });
  }

  void _onSubmitFromLang(String? newValue) {
    setState(() {
      fromLanguage = newValue!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        title: Center(
          child: Text('Google Translator'),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropDownButtonView(fromLanguage, langs, _onSubmitFromLang),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                  icon: const Icon(Icons.autorenew),
                  onPressed: () {
                    setState(() {
                      var toLang = toLanguage;
                      var fromLang = fromLanguage;
                      fromLanguage = toLang;
                      toLanguage = fromLang;
                    });
                  },
                ),
                //Icon(Icons.autorenew),
                SizedBox(
                  width: 10,
                ),
                DropDownButtonView(toLanguage, langs, _onSubmitToLang),
              ],
            ),
            Divider(),
            InputFieldView(_translate, _submit, _textFieldController),
            Divider(),
            if (translatedText.isNotEmpty) ...[
              TranslatedTextView(
                _textFieldController.text,
                translatedText,
                toLanguage,
              ),
              Divider(),
            ],
            if (recentTranslationsList.isNotEmpty) ...[
              RecentTranslationsView(
                  recentTranslationsList, recentTypedTextList),
            ],
          ],
        ),
      ),
    );
  }
}

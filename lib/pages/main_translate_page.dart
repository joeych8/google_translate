import 'package:flutter/material.dart';
import 'package:google_translate/view/translated_text_view.dart';
import 'package:translator/translator.dart';
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


  String fromLanguage = 'English';
  var fromLanguageList = [
    'English',
    'Norwegian',
    'Russian',
    'Japanese',
    'French'
  ];
  String toLanguage = 'Norwegian';
  var toLanguageList = [
    'Norwegian',
    'English',
    'Russian',
    'Japanese',
    'French'
  ];

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
    //0.5 seconds delay before translating text after user input.
    Future.delayed(Duration(milliseconds: 500), () async {
      if (newValue == _textFieldController.text) {
        await translator
            .translate(_textFieldController.text, from: 'en', to: 'no')
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

//Recent translated text list
  Widget _recentTranslationsListView() {
    return NotificationListener(
      //On Scroll, removes keyboard.
      onNotification: (notification) {
        if (notification is ScrollStartNotification) {
          FocusScope.of(context).unfocus();
        }
        return true;
      },
      child: Expanded(
        child: ListView.separated(
          itemCount: recentTranslationsList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListTile(
                tileColor: Colors.white,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recentTranslationsList[index],
                    ),
                    Text(
                      recentTypedTextList[index],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                trailing: GestureDetector(
                  child: Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.star_border),
                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Divider(
                height: 0,
              ),
            );
          },
        ),
      ),
    );
  }

  //input_field
  Widget _inputField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        textInputAction: TextInputAction.go,
        controller: _textFieldController,
        //translate func runs here when textfield changes.
        onChanged: _translate,
        maxLines: 5,
        minLines: 5,
        decoration: InputDecoration(
          hintText: 'Enter text',
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            //removes the default borderline
            borderSide: BorderSide(width: 0, style: BorderStyle.none),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(width: 0, style: BorderStyle.none),
          ),
        ),
        onSubmitted: (newValue) {
          setState(() {
            translatedText = '';
            _textFieldController.clear();
          });
        },
      ),
    );
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
                DropdownButton(
                  // Initial Value
                  value: fromLanguage,
                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),
                  // Array list of items
                  items: fromLanguageList.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      fromLanguage = newValue!;
                    });
                  },
                ),
                SizedBox(
                  width: 50,
                ),
                Icon(Icons.autorenew),
                SizedBox(
                  width: 50,
                ),
                DropdownButton(
                  // Initial Value
                  value: toLanguage,
                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),
                  // Array list of items
                  items: toLanguageList.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      toLanguage = newValue!;
                    });
                  },
                ),
              ],
            ),
            Divider(),
            _inputField(),
            Divider(),
            TranslatedTextView(_textFieldController.text, translatedText),
            Divider(),
            _recentTranslationsListView(),
          ],
        ),
      ),
    );
  }
}

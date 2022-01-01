import 'package:flutter/material.dart';

class DropDownButtonView extends StatelessWidget {
  final String language;
  final Map<String, String> langCode;
  final void Function(String? newValue) onSubmitLang;

  DropDownButtonView(this.language, this.langCode, this.onSubmitLang);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      underline: SizedBox(),
      // Initial Value
      value: language,
      // Down Arrow Icon
      icon: const Icon(Icons.arrow_drop_down),
      // Array list of items
      items: langCode.values.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: onSubmitLang,
    );
  }
}
//keyboard_arrow_down
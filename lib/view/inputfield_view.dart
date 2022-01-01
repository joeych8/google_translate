import 'package:flutter/material.dart';

class InputFieldView extends StatelessWidget {

  final TextEditingController controller;
  final void Function(String newValue) onTextChanged;
  final void Function(String newValue) onSubmit;

  InputFieldView(this.onTextChanged,this.onSubmit, this.controller);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        textInputAction: TextInputAction.go,
        controller: controller,
        //translate func runs here when textfield changes.
        onChanged: onTextChanged,
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
        onSubmitted: onSubmit,
      ),
    );
  }
}

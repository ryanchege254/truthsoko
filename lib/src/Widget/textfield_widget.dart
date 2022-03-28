import 'package:flutter/material.dart';
import 'package:truthsoko/src/Widget/color.dart';
import 'package:provider/provider.dart';
import 'package:truthsoko/src/models/textview_model.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData? prefixIconData;
  final IconData? suffixIconData;
  final bool obscureText;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final bool matchPassword;

  // ignore: use_key_in_widget_constructors
  const TextFieldWidget(
      {required this.hintText,
      required this.prefixIconData,
      required this.suffixIconData,
      required this.obscureText,
      required this.onChanged,
      required this.controller,
      required this.matchPassword});

  @override
  Widget build(BuildContext context) {
    //final model = Provider.of<TextviewModel>(context);

    return ChangeNotifierProvider(
        create: (context) => TextviewModel(),
        child: TextFormField(
          controller: controller,
          onChanged: onChanged,
          obscureText: obscureText,
          cursorColor: Global.green,
          style: const TextStyle(
            color: Global.green,
            fontSize: 14.0,
          ),
          decoration: InputDecoration(
            labelStyle: const TextStyle(color: Global.green),
            focusColor: Global.orange,
            filled: true,
            enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Global.green),
            ),
            labelText: hintText,
            prefixIcon: Icon(
              prefixIconData,
              size: 18,
              color: Global.orange,
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                 //.isVisible = !model.isVisible;
                context.read<TextviewModel>().isVisible =
                    !context.read<TextviewModel>().isVisible;
              },
              child: Icon(
                suffixIconData,
                size: 18,
                color: Global.green,
              ),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Empty';
            }
            if (matchPassword == true) {
              if (value == controller!.text) {
                return "Passwords do not match";
              }
            }
            return null;
          },
        ));
  }
}

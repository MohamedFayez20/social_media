
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';

Widget textField({IconData? i, context, controller}) => TextFormField(
      controller: controller,
      style: const TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      readOnly: true,
      enabled: false,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white30,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        prefixIcon: Icon(i),
      ),
    );
Widget media(String t) => Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white10,
        image: DecorationImage(image: AssetImage('images/$t.png'), scale: .9),
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
    );
Widget condition(Widget widget, con) => BuildCondition(
      condition: con,
      fallback: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
      builder: (context) => widget,
    );

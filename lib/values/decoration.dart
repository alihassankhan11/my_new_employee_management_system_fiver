import 'package:flutter/material.dart';

class Decorations {
  static BoxDecoration boxDecorationForEntireScreen() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.blueGrey, Colors.grey],
      ),
    );
  }
}

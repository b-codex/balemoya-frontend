import 'package:flutter/material.dart';

class DurationPicker {
  static int value = 0;

  /// It returns the value of the variable value.
  ///
  /// Returns:
  ///   The value of the variable value.
  static getValue() {
    return value;
  }

  /// It returns a widget that contains a row with a text widget and a row with two icon buttons
  ///
  /// Returns:
  ///   A StatefulBuilder widget.
  static returnWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 7),
      child: StatefulBuilder(
        builder: (context, setState) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Duration: $value+ Years"),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        value++;
                      });
                    },
                    icon: Icon(Icons.add),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (value != 0) {
                          value--;
                        }
                      });
                    },
                    icon: Icon(Icons.remove),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

class DurationPicker {
  static int value = 0;

  static getValue() {
    return value;
  }

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

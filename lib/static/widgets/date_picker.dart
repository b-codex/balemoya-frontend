import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker {
  /// Declaring a static variable called startedDate and assigning it the value of the current date.
  static String startedDate = DateFormat('MM/dd/yyyy').format(DateTime.now());

  /// Declaring a static variable called endDate and assigning it the value of the current date.
  static String endDate = DateFormat('MM/dd/yyyy').format(DateTime.now());

  /// It returns the value of the variable startedDate.
  ///
  /// Returns:
  ///   The value of the variable startedDate.
  static getStartedDate() {
    return startedDate;
  }

  /// It returns the endDate.
  ///
  /// Returns:
  ///   The endDate property of the class.
  static getEndDate() {
    return endDate;
  }

  /// It returns a StatefulBuilder widget that contains a Column widget that contains a Container widget
  /// that contains a Row widget that contains a Text widget that displays the value of the variable
  /// startedDate
  ///
  /// Returns:
  ///   A StatefulBuilder widget that contains a Column widget that contains a Container widget that
  /// contains a Row widget that contains a Text widget.
  static returnStartedDateWidget() {
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Started Date: $startedDate'),
                ],
              ),
            ),
            SizedBox(height: 9),
            ElevatedButton(
              onPressed: () async {
                final DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );

                if (selectedDate != null) {
                  String formatted =
                      DateFormat('MM/dd/yyyy').format(selectedDate);

                  setState(() {
                    startedDate = formatted;
                  });
                }
              },
              child: Text("Choose Start Date"),
            ),
          ],
        );
      },
    );
  }

  /// It returns a StatefulBuilder widget that contains a Column widget that contains a Container widget
  /// that contains a Row widget that contains a Text widget that displays the endDate variable
  ///
  /// Returns:
  ///   A StatefulBuilder widget that contains a Column widget that contains a Container widget that
  /// contains a Row widget that contains a Text widget.
  static returnEndDateWidget() {
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('End Date: $endDate'),
                ],
              ),
            ),
            SizedBox(height: 9),
            ElevatedButton(
              onPressed: () async {
                final DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );

                if (selectedDate != null) {
                  String formatted =
                      DateFormat('MM/dd/yyyy').format(selectedDate);

                  setState(() {
                    endDate = formatted;
                  });
                }
              },
              child: Text("Choose End Date"),
            ),
          ],
        );
      },
    );
  }
}

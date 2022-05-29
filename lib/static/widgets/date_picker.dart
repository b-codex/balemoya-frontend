import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker {
  static String startedDate = DateFormat('MM/dd/yyyy').format(DateTime.now());
  static String endDate = DateFormat('MM/dd/yyyy').format(DateTime.now());

  static getStartedDate() {
    return startedDate;
  }

  static getEndDate() {
    return endDate;
  }

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

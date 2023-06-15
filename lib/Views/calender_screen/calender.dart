// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:kolazz_book/Utils/colors.dart';
import 'package:table_calendar/table_calendar.dart';


class TableBasicsExample extends StatefulWidget {
  const TableBasicsExample({super.key});

  @override
  _TableBasicsExampleState createState() => _TableBasicsExampleState();
}

class _TableBasicsExampleState extends State<TableBasicsExample> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime? _selectedDay;


  List<String> getMonthNames() {
    List<String> monthNames = [];
    for (int i = 1; i <= 12; i++) {
      DateTime month = DateTime(2023, i);
      String monthName = DateFormat.MMMM().format(month);
      monthNames.add(monthName);
    }
    return monthNames;
  }

  void main() {
    initializeDateFormatting();
    List<String> months = getMonthNames();
    print(months);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeDateFormatting();
    List<String> months = getMonthNames();
    print("________________${months}");
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    int currentYear = now.year;
    return Scaffold(
      backgroundColor: AppColors.backgruond,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // leading: Icon(Icons.arrow_back_ios, color: Color(0xff1E90FF)),
        backgroundColor: Color(0xff303030),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Center(child: Text("Calender",
                style: TextStyle(fontSize: 16, color:Color(0xff1E90FF), fontWeight: FontWeight.bold)
            ),
            ),
          ),
        ],
      ),
      body:
      // TableCalendar(
      //   firstDay: DateTime.utc(1950, 01, 01),
      //   lastDay: DateTime.utc(2050, 01, 01),
      //   focusedDay: DateTime.now(),
      //
      //
      //   startingDayOfWeek: StartingDayOfWeek.monday,
      //   headerStyle: HeaderStyle(
      //     formatButtonVisible: false,
      //   ),
      // ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("$currentYear",style: TextStyle(color: AppColors.textclr,fontSize: 20),),
          ),
          TableCalendar(
            firstDay: DateTime.utc(1950,01,01),
            lastDay: DateTime.utc(2050,01,01),
            focusedDay: DateTime.now(),
            calendarStyle: CalendarStyle(
              // Customize the appearance of the calendar
              todayDecoration:BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.blue,),
              // selectedColor: Colors.green,
              // weekendStyle: TextStyle(color: Colors.red),
              // holidayStyle: TextStyle(color: Colors.orange),
            ),
             headerVisible: false,
            onDayLongPressed:  (selectedDay, focusedDay) {
            },
            daysOfWeekStyle: const DaysOfWeekStyle(weekdayStyle: TextStyle(color: AppColors.textclr)),
            // calendarStyle: CalendarStyle(selectedDecoration: BoxDecoration()),
            selectedDayPredicate: (day) {
              return false;
              // Use `selectedDayPredicate` to determine which day is currently selected.
              // If this returns true, then `day` will be marked as selected.
              // Using `isSameDay` is recommended to disregard
              // the time-part of compared DateTime objects.
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                // Call `setState()` when updating the selected day
                setState(() {
                  _selectedDay = selectedDay;
                });
              }

            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                // Call `setState()` when updating calendar format
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              // No need to call `setState()` here
            },
          ),
        ],
      ),
    );
  }
}
// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

// import 'package:flutter/material.dart';
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:intl/intl.dart';
// import 'package:kolazz_book/Utils/colors.dart';
// import 'package:table_calendar/table_calendar.dart';
//
//
// class TableBasicsExample extends StatefulWidget {
//   const TableBasicsExample({super.key});
//
//   @override
//   _TableBasicsExampleState createState() => _TableBasicsExampleState();
// }
//
// class _TableBasicsExampleState extends State<TableBasicsExample> {
//   CalendarFormat _calendarFormat = CalendarFormat.month;
//   DateTime? _selectedDay;
//
//
//   List<String> getMonthNames() {
//     List<String> monthNames = [];
//     for (int i = 1; i <= 12; i++) {
//       DateTime month = DateTime(2023, i);
//       String monthName = DateFormat.MMMM().format(month);
//       monthNames.add(monthName);
//     }
//     return monthNames;
//   }
//
//   void main() {
//     initializeDateFormatting();
//     List<String> months = getMonthNames();
//     print(months);
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     initializeDateFormatting();
//     List<String> months = getMonthNames();
//     print("________________${months}");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     DateTime now = DateTime.now();
//     int currentYear = now.year;
//     return Scaffold(
//       backgroundColor: AppColors.backgruond,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         // leading: Icon(Icons.arrow_back_ios, color: AppColors.AppbtnColor),
//         backgroundColor: Color(0xff303030),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(15),
//             child: Center(child: Text("Calender",
//                 style: TextStyle(fontSize: 16, color:AppColors.AppbtnColor, fontWeight: FontWeight.bold)
//             ),
//             ),
//           ),
//         ],
//       ),
//       body:
//       // TableCalendar(
//       //   firstDay: DateTime.utc(1950, 01, 01),
//       //   lastDay: DateTime.utc(2050, 01, 01),
//       //   focusedDay: DateTime.now(),
//       //
//       //
//       //   startingDayOfWeek: StartingDayOfWeek.monday,
//       //   headerStyle: HeaderStyle(
//       //     formatButtonVisible: false,
//       //   ),
//       // ),
//       Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text("$currentYear",style: TextStyle(color: AppColors.textclr,fontSize: 20),),
//           ),
//           TableCalendar(
//             firstDay: DateTime.utc(2000,01,01),
//             lastDay: DateTime.utc(2050,01,01),
//             focusedDay: DateTime.now(),
//             calendarStyle: CalendarStyle(
//               // Customize the appearance of the calendar
//               todayDecoration:BoxDecoration(
//                 borderRadius: BorderRadius.circular(30),
//                 color: Colors.blue,),
//               // selectedColor: Colors.green,
//               // weekendStyle: TextStyle(color: Colors.red),
//               // holidayStyle: TextStyle(color: Colors.orange),
//             ),
//              headerVisible: false,
//             onDayLongPressed:  (selectedDay, focusedDay) {
//             },
//             daysOfWeekStyle: const DaysOfWeekStyle(weekdayStyle: TextStyle(color: AppColors.textclr)),
//             // calendarStyle: CalendarStyle(selectedDecoration: BoxDecoration()),
//             selectedDayPredicate: (day) {
//               return false;
//               // Use `selectedDayPredicate` to determine which day is currently selected.
//               // If this returns true, then `day` will be marked as selected.
//               // Using `isSameDay` is recommended to disregard
//               // the time-part of compared DateTime objects.
//               return isSameDay(_selectedDay, day);
//             },
//             onDaySelected: (selectedDay, focusedDay) {
//               if (!isSameDay(_selectedDay, selectedDay)) {
//                 // Call `setState()` when updating the selected day
//                 setState(() {
//                   _selectedDay = selectedDay;
//                 });
//               }
//
//             },
//             onFormatChanged: (format) {
//               if (_calendarFormat != format) {
//                 // Call `setState()` when updating calendar format
//                 setState(() {
//                   _calendarFormat = format;
//                 });
//               }
//             },
//             onPageChanged: (focusedDay) {
//               // No need to call `setState()` here
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kolazz_book/Models/get_calendar_jobs_model.dart';
import 'package:kolazz_book/Services/request_keys.dart';
import 'package:kolazz_book/Utils/colors.dart';
import 'package:kolazz_book/Utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  List<CalendarJobs> getJobs = [];
  List<String> dates = [];

  getCalendarJobs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('id');
    var uri =
    Uri.parse(getCalendarJobsApi.toString());
    // '${Apipath.getCitiesUrl}');
    var request = http.MultipartRequest("POST", uri);
    // request.fields.addAll({
    //   "user_id": id.toString(),
    //   "type" :"client",
    //   "date"
    // })
    request.fields[RequestKeys.userId] = id!;
    request.fields[RequestKeys.type] = 'client';
    request.fields['date']= DateFormat('yyyy-MM-dd').format(_selectedDay).toString();
    // print("this is my request ${request.fields.toString()}");
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);

    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    setState(() {
      getJobs = GetCalendarJobsModel.fromJson(userData).data!;
      dates = GetCalendarJobsModel.fromJson(userData).dates!;
    });
   for(var i = 0; i < dates.length; i++ ){
     setState(() {
       _selectedDates.add(DateTime.parse(dates[i]));
     });
     print("this is selected dates $_selectedDates}");
   }
  }

  @override
  void initState() {
    super.initState();
    getCalendarJobs();
  }

   Set<DateTime> _selectedDates = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgruond,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff303030),
        actions: const [
          Padding(
            padding: EdgeInsets.all(15),
            child: Center(
                child: Text("Calendar",
                    style: TextStyle(
                        fontSize: 16,
                        color: AppColors.AppbtnColor,
                        fontWeight: FontWeight.bold))),
          ),
        ],
      ),
      // appBar: AppBar(
      //   title: Text('TableCalendar - Basics'),
      // ),
      body: Column(
        children: [
          const SizedBox(height: 15,),
          Container(
            // height: MediaQuery.of(context).size.height/3,
            color: AppColors.grd1,
            child: TableCalendar(
              headerStyle: const HeaderStyle(
                  leftChevronVisible: false,
                  titleCentered: true,
                  formatButtonVisible: false,
                  rightChevronVisible: false,
                  decoration: BoxDecoration(color: AppColors.primary5),
                  titleTextStyle: TextStyle(color: AppColors.whit)),
              daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(color: AppColors.whit),
                  weekendStyle: TextStyle(color: AppColors.back)),
              // firstDay: kFirstDay,
              // lastDay: kLastDay,
              firstDay: DateTime.utc(2022, 1, 1),
              lastDay: DateTime.utc(2028, 12, 31),
              daysOfWeekHeight: 40,
              calendarStyle:  CalendarStyle(
                  todayDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.AppbtnColor.withOpacity(0.4)
                  ),
                  selectedTextStyle: const TextStyle(color: AppColors.whit),
                  disabledTextStyle: const TextStyle(color: AppColors.back)),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return _selectedDates.contains(day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  _selectedDates.add(selectedDay);
                });
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),

            // TableCalendar(
            //   daysOfWeekHeight: 40,
            //   calendarStyle:  CalendarStyle(
            //     todayDecoration: BoxDecoration(
            //       shape: BoxShape.circle,
            //       color: AppColors.AppbtnColor.withOpacity(0.4)
            //     ),
            //       selectedTextStyle: TextStyle(color: AppColors.whit),
            //       disabledTextStyle: TextStyle(color: AppColors.back)),
            //   selectedDayPredicate: (day) {
            //     return _selectedDates.contains(day);
            //   },
            //   headerStyle: const HeaderStyle(
            //     leftChevronVisible: false,
            //       titleCentered: true,
            //       formatButtonVisible: false,
            //       rightChevronVisible: false,
            //       decoration: BoxDecoration(color: AppColors.primary5),
            //       titleTextStyle: TextStyle(color: AppColors.whit)),
            //   daysOfWeekStyle: const DaysOfWeekStyle(
            //       weekdayStyle: TextStyle(color: AppColors.whit),
            //       weekendStyle: TextStyle(color: AppColors.back)),
            //   firstDay: kFirstDay,
            //   lastDay: kLastDay,
            //   focusedDay: _focusedDay,
            //   calendarFormat: _calendarFormat,
            //   selectedDayPredicate: (day) {
            //     return isSameDay(_selectedDay, day);
            //   },
            //   onDaySelected: (selectedDay, focusedDay) {
            //     if (!isSameDay(_selectedDay, selectedDay)) {
            //       // Call `setState()` when updating the selected day
            //       setState(() {
            //         _selectedDay = selectedDay;
            //         _focusedDay = focusedDay;
            //       });
            //       getCalendarJobs();
            //       print("this is selected date $_selectedDay");
            //     }
            //   },
            //   onFormatChanged: (format) {
            //     if (_calendarFormat != format) {
            //       // Call `setState()` when updating calendar format
            //       setState(() {
            //         _calendarFormat = format;
            //       });
            //     }
            //   },
            //   onPageChanged: (focusedDay) {
            //     // No need to call `setState()` here
            //     _focusedDay = focusedDay;
            //   },
            // ),
          ),
          // Container(
          //   height: MediaQuery.of(context).size.height/3.2,
          //   width: MediaQuery.of(context).size.width,
          //   child:
            getJobs.isNotEmpty ?
            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: getJobs.length ,
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                var data = getJobs[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
                  child: InkWell(
                    onTap: (){
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>EditQuotation()));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      color: Colors.black12,
                      elevation: 1,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Job ID",style: TextStyle(color: AppColors.pdfbtn,fontSize: 14,fontWeight: FontWeight.bold),),
                                Container(
                                    padding: EdgeInsets.symmetric(horizontal: 14,vertical: 3),
                                    decoration: BoxDecoration(
                                        color: AppColors.lightwhite,

                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Text("${data.qid}",style: TextStyle(color: AppColors.whit,),)),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                               const Text("Client Name",style: TextStyle(color: AppColors.pdfbtn,fontWeight: FontWeight.bold,fontSize: 14),),
                                Text("${data.clientName}",style: TextStyle(color: AppColors.whit),),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Mobile",style: TextStyle(color: AppColors.pdfbtn,fontWeight: FontWeight.bold,fontSize: 14),),
                                Text("${data.mobile}",style: TextStyle(color: AppColors.whit),),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                               const Text("Event",style: TextStyle(color: AppColors.pdfbtn,fontSize: 14,fontWeight: FontWeight.bold),),
                                Text("${data.eventName}",style: TextStyle(color: AppColors.whit),),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                               const  Text("Venue",style: TextStyle(color: AppColors.pdfbtn,fontSize: 14,fontWeight: FontWeight.bold),),
                                Text("${data.city}",style: TextStyle(color: AppColors.whit),),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                               const Text("Amount",style: TextStyle(color: AppColors.pdfbtn,fontSize: 14,fontWeight: FontWeight.bold),),
                                Text("${data.amount}",style: TextStyle(color: AppColors.whit),),
                              ],
                            ),
                          ),
                        ],
                      ),),
                  ),
                );
              },
            )
            : const Center(
              child: Text("No data to show", style: TextStyle(
                color: AppColors.whit
              ),),
            // ),
          )
        ],
      ),
    );
  }
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

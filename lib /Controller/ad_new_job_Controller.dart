import 'package:flutter/material.dart';

import 'appbased_controller/appbase_controller.dart';

class AddJobController extends AppBaseController {

  final formKey = GlobalKey<FormState>();


  int adMore=0;

  void increment(){
    if(adMore>=0&&adMore<10) {
      adMore++;
    }
    update();
  }
  List<DateTime> selectedDates = [DateTime.now()];
  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay selectedTime2 = TimeOfDay.now();

  Future<void> selectDate(BuildContext context, int index) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDates[index],
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != selectedDates[index]) {
      selectedDates[index] = pickedDate;
        update();
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (pickedTime != null && pickedTime != selectedTime) {
        selectedTime = pickedTime;
        selectTime2(context);
        update();

    }
  }
  Future<void> selectTime2(BuildContext context) async {
    final TimeOfDay? pickedTime2 = await showTimePicker(
      context: context,
      initialTime: selectedTime2,
    );

    if (pickedTime2 != null && pickedTime2 != selectedTime2) {
        selectedTime2 = pickedTime2;
        update();
    }
  }


}
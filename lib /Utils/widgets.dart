import 'package:intl/intl.dart';

String formatDate(String dateString) {
  final inputFormat = DateFormat('yyyy-MM-dd');
  final outputFormat = DateFormat('dd/MM/yyyy');
  final date = DateFormat('dd/MM/yyyy').parse(dateString);
  final formattedDate = outputFormat.format(date);
  return formattedDate;
}

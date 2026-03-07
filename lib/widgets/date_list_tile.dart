import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateListTile extends StatelessWidget {
  const DateListTile({
    super.key,
    required this.title,
    required this.selectedDate,
    required this.onSelectDate,
  });
  final String title;
  final ValueChanged<DateTime> onSelectDate;
  final DateTime selectedDate;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          initialDate: DateTime.now(),
          builder: (context, child) => Padding(
            padding: EdgeInsetsGeometry.symmetric(
              vertical: 32,
              horizontal: 16,
            ),
            child: child,
          ),
        );
        if (pickedDate != null) {
          onSelectDate(pickedDate);
        }
      },
      leading: Icon(Icons.calendar_month),
      title: Text(
        title,
      ),
      subtitle: Text(
        DateFormat(' d/M/y').format(selectedDate),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerListTile extends StatefulWidget {
  const DatePickerListTile({
    super.key,
    required this.initialDate,
    required this.onDateChanged,
  });
  final DateTime initialDate;
  final ValueChanged<DateTime> onDateChanged;
  @override
  State<DatePickerListTile> createState() => _DatePickerListTileState();
}

class _DatePickerListTileState extends State<DatePickerListTile> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  Future<void> pickDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: widget.initialDate,
      builder: (context, child) => Padding(
        padding: EdgeInsets.symmetric(
          vertical: 32,
          horizontal: 16,
        ),
        child: child,
      ),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
    widget.onDateChanged(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      onTap: () => pickDate(context),
      leading: Icon(Icons.calendar_month),
      title: const Text(
        "Date",
      ),
      subtitle: Text(
        DateFormat(' d/M/y').format(selectedDate),
      ),
    );
  }
}

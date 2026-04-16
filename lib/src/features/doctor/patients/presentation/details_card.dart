import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:intl/intl.dart';

class DetailsCard extends StatelessWidget {
  const DetailsCard({super.key, required this.patient});
  final PatientProfileModel patient;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Details',
              style: context.titleMedium?.extraBold,
            ),
            12.heightBox,
            DetailRow(
              label: 'Full Name',
              value: patient.fullName ?? '-',
            ),
            DetailRow(
              label: 'Gender',
              value: patient.gender?.toString() ?? '-',
            ),
            DetailRow(
              label: 'Date of Birth',
              value: DateFormat(
                'yyyy-MM-dd',
              ).format(patient.dob ?? DateTime(1900)),
            ),
            DetailRow(
              label: 'Blood Type',
              value: patient.bloodType?.toString() ?? '-',
            ),
            DetailRow(
              label: 'Smoking Status',
              value: patient.smokingStatus?.toString() ?? '-',
            ),
            DetailRow(
              label: 'Alcohol Frequency',
              value: patient.alcoholFreq?.toString() ?? '-',
            ),
            DetailRow(
              label: 'Exercise Frequency',
              value: patient.exerciseFreq?.toString() ?? '-',
            ),
          ],
        ),
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  const DetailRow({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Text(value),
        ],
      ),
    );
  }
}

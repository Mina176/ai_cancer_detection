import 'package:cancer_ai_detection/main.dart';
import 'package:flutter/material.dart';
import 'package:gp_backend_client/gp_backend_client.dart';

class PateintProfileScreen extends StatefulWidget {
  const PateintProfileScreen({super.key});

  @override
  State<PateintProfileScreen> createState() => _PateintProfileScreenState();
}

class _PateintProfileScreenState extends State<PateintProfileScreen> {
  late Future<PatientProfileModel> _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = client.patientProfileModelEdit.getOrCreate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _profileFuture,
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapShot.hasError) {
            return Text("Error: ${snapShot.error}");
          }
          final patientInfo = snapShot.data!;
          return Column(
            children: [
              Card(
                child: InkWell(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text('Blood Type:${patientInfo.bloodType}'),
                      Text('exerciseFreq:${patientInfo.exerciseFreq}'),
                      Text('alcoholFreq:${patientInfo.alcoholFreq}'),
                      Text(
                        'emergencyContactName:${patientInfo.emergencyContactName}',
                      ),
                      Text(
                        'emergencyContactPhone:${patientInfo.emergencyContactPhone}',
                      ),
                      Text('smokingStatus:${patientInfo.smokingStatus}'),
                      Text('phone:${patientInfo.phone}'),
                      Text('address:${patientInfo.address}'),
                    ],
                  ),
                ),
              ),
              ElevatedButton(onPressed: () {}, child: Text('Edit')),
            ],
          );
        },
      ),
    );
  }
}

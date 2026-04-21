import 'package:cancer_ai_detection/src/features/authentication/signin_screen.dart';
import 'package:cancer_ai_detection/src/features/doctor/diagnoses/presentation/add_diagnosis_screen.dart';
import 'package:cancer_ai_detection/src/features/doctor/doctor_form_screen.dart';
import 'package:cancer_ai_detection/src/features/doctor/patients/presentation/doctor_patients_screen.dart';
import 'package:cancer_ai_detection/src/features/doctor/patients/presentation/patient_details.dart';
import 'package:cancer_ai_detection/src/features/doctor/diagnoses/presentation/patient_diagnoses_screen.dart';
import 'package:cancer_ai_detection/src/features/doctor/patients/presentation/patient_scans_screen.dart';
import 'package:cancer_ai_detection/src/features/doctor/patients/presentation/scan_ai_analysis_screen.dart';
import 'package:cancer_ai_detection/src/features/doctor/patients/presentation/scan_details_screen.dart';
import 'package:cancer_ai_detection/src/features/lab/presentation/lab_add_health_measurement_screen.dart';
import 'package:cancer_ai_detection/src/features/lab/presentation/lab_add_scan_screen.dart';
import 'package:cancer_ai_detection/src/features/lab/presentation/lab_patients_screen.dart';
import 'package:cancer_ai_detection/src/features/lab/lab_form_screen.dart';
import 'package:cancer_ai_detection/src/features/patient/health_measurement/presentation/add_health_measurement_screen.dart';
import 'package:cancer_ai_detection/src/features/patient/health_measurement/presentation/health_measurement_screen.dart';
import 'package:cancer_ai_detection/src/features/home/home_screen.dart';
import 'package:cancer_ai_detection/src/features/patient/allergies/presentation/add_allergy_screen.dart';
import 'package:cancer_ai_detection/src/features/patient/medical_history/presentation/add_medical_history_screen.dart';
import 'package:cancer_ai_detection/src/features/patient/medical_history/presentation/medical_history_screen.dart';
import 'package:cancer_ai_detection/src/features/patient/medication/presentation/add_medication_screen.dart';
import 'package:cancer_ai_detection/src/features/patient/allergies/presentation/allergies_screen.dart';
import 'package:cancer_ai_detection/src/features/patient/medication/presentation/medications_screen.dart';
import 'package:cancer_ai_detection/src/features/patient/patient_doctor/select_doctor_screen.dart';
import 'package:cancer_ai_detection/src/features/patient/patient_lab/presentation/select_lab_screen.dart';
import 'package:cancer_ai_detection/src/features/settings/root_settings.dart';
import 'package:cancer_ai_detection/src/features/patient/upload/upload_screen.dart';
import 'package:cancer_ai_detection/src/features/user_role_selection/controller/user_role_provider.dart';
import 'package:cancer_ai_detection/src/features/user_role_selection/presentation/patient_form_screen.dart';
import 'package:cancer_ai_detection/src/features/user_role_selection/presentation/select_role_screen.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/src/routing/app_routes.dart';
import 'package:cancer_ai_detection/src/utils/is_form_empty.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

part 'app_router.g.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();
const String authRoute = '/';
const String homeRoute = '/home';
const String selectRoleRoute = '/select-role';
const String doctorFormRoute = '/doctor-form';
const String patientFormRoute = '/patient-form';
const String labFormRoute = '/lab-form';
const String uploadRoute = '/upload';
const String settingsRoute = '/settings';
const String allScansRoute = '/scan-list';
const String doctorPatientsRoute = '/doctor-patients';
const String labPatientsRoute = '/lab-patients';
const String labAddScanRoute = '/add-scan/:patientId';
const String labAddHealthMeasurementRoute =
    '/add-health-measurement/:patientId';
const String patientDetailsRoute = '/patient-details/:patientId';
const String patientDiagnosesRoute = '/patient-diagnoses/:patientId';
const String patientScansRoute = '/patient-scans/:patientId';
const String scanRoute = '/scan';
const String scanAnalysisRoute = '/ai-analysis';
const String addDiagnosisRoute = '/add-diagnosis/:patientId';
const String patientProfileRoute = '/patient-profile';
const String allergiesRoute = '/allergies';
const String addAllergyRoute = '/add-allergy';
const String medicationsRoute = '/medications';
const String addMedicationRoute = '/add-medication';
const String medicalHistoryRoute = '/medical-history';
const String addMedicalHistoryRoute = '/add-medical-history';
const String healthMeasurmentsRoute = '/health-measurments';
const String addHealthMeasurmentRoute = '/add-health-measurment';
const String selectedDoctorsRoute = '/selected-doctors';
const String addDoctorsRoute = '/add-doctors';
const String chooseLabRoute = '/choose-lab';

@Riverpod()
GoRouter router(Ref ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: authRoute,
    refreshListenable: client.authSessionManager.authInfoListenable,
    redirect: (context, state) async {
      final isAuthed = client.auth.isAuthenticated;
      final path = state.matchedLocation;
      final selectedRole = ref.read(userRoleProvider);
      final hasSelectedRole = selectedRole != null;

      if (!isAuthed) {
        return path == authRoute ? null : authRoute;
      }
      if (!hasSelectedRole) {
        return path == selectRoleRoute ? null : selectRoleRoute;
      }
      if (path == authRoute || path == selectRoleRoute) {
        return homeRoute;
      }
      final isEditing = state.uri.queryParameters['isEditing'] == 'true';
      if (path == patientFormRoute) {
        final profile = await client.patientProfile.getOrCreate();
        if (!isPatientFormEmpty(profile) && !isEditing) {
          return homeRoute;
        }
      } else if (path == doctorFormRoute) {
        final doctorProfile = await client.doctorProfile.getOrCreate();
        if (!isDoctorFormEmpty(doctorProfile) && !isEditing) {
          return homeRoute;
        }
      } else if (path == labFormRoute) {
        final labProfile = await client.labProfile.getOrCreate();
        if (!isLabFormEmpty(labProfile) && !isEditing) {
          return homeRoute;
        }
      }

      return null;
    },
    routes: [
      GoRoute(
        path: authRoute,
        name: AppRoute.auth.name,
        builder: (BuildContext context, GoRouterState state) {
          return const AuthScreen();
        },
      ),
      GoRoute(
        path: selectRoleRoute,
        name: AppRoute.selectRole.name,
        builder: (BuildContext context, GoRouterState state) {
          return const SelectRoleScreen();
        },
      ),
      GoRoute(
        name: AppRoute.patientForm.name,
        path: patientFormRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const PatientFormScreen();
        },
      ),
      GoRoute(
        name: AppRoute.doctorForm.name,
        path: doctorFormRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const DoctorFormScreen();
        },
      ),
      GoRoute(
        name: AppRoute.labForm.name,
        path: labFormRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const LabFormScreen();
        },
      ),
      GoRoute(
        name: AppRoute.home.name,
        path: homeRoute,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        name: AppRoute.chooseDoctor.name,
        path: addDoctorsRoute,
        builder: (context, state) => const SelectDoctorScreen(),
      ),
      GoRoute(
        name: AppRoute.chooseLab.name,
        path: chooseLabRoute,
        builder: (context, state) => const SelectLabScreen(),
      ),
      GoRoute(
        name: AppRoute.doctorPatients.name,
        path: doctorPatientsRoute,
        builder: (context, state) => const DoctorPatientsScreen(),
      ),
      GoRoute(
        name: AppRoute.patientDetails.name,
        path: patientDetailsRoute,
        builder: (context, state) {
          final patientIdString = state.pathParameters['patientId'] ?? '';
          final patientUuid = UuidValue.fromString(
            patientIdString,
          );
          return PatientDetails(patientId: patientUuid);
        },
      ),
      GoRoute(
        name: AppRoute.patientDiagnoses.name,
        path: patientDiagnosesRoute,
        builder: (context, state) {
          final patientIdString = state.pathParameters['patientId'] ?? '';
          final patientUuid = UuidValue.fromString(
            patientIdString,
          );
          return PatientDiagnosesScreen(patientId: patientUuid);
        },
      ),
      GoRoute(
        name: AppRoute.addDiagnosis.name,
        path: addDiagnosisRoute,
        builder: (context, state) {
          final patientIdString = state.pathParameters['patientId'] ?? '';
          final patientUuid = UuidValue.fromString(
            patientIdString,
          );
          return AddDiagnosisScreen(patientId: patientUuid);
        },
      ),
      GoRoute(
        name: AppRoute.patientScans.name,
        path: patientScansRoute,
        builder: (context, state) {
          final patientIdString = state.pathParameters['patientId'] ?? '';
          final patientUuid = UuidValue.fromString(
            patientIdString,
          );
          return PatientScansScreen(patientId: patientUuid);
        },
      ),
      GoRoute(
        name: AppRoute.scan.name,
        path: scanRoute,
        builder: (context, state) {
          final scan = state.extra;
          return ScanDetailsScreen(
            scan: scan is MedicalScanModel ? scan : null,
          );
        },
      ),
      GoRoute(
        name: AppRoute.scanAnalysis.name,
        path: scanAnalysisRoute,
        builder: (context, state) {
          final extra = state.extra;
          final Map<String, dynamic>? extraMap = extra is Map<String, dynamic>
              ? extra
              : null;
          final medicalScan = extra is MedicalScanModel
              ? extra
              : extraMap?['medicalScan'] as MedicalScanModel?;
          return ScanAiAnalysisScreen(
            medicalScan: medicalScan,
          );
        },
      ),
      GoRoute(
        name: AppRoute.labPatients.name,
        path: labPatientsRoute,
        builder: (context, state) => const LabPatientsScreen(),
      ),
      GoRoute(
        name: AppRoute.labAddScan.name,
        path: labAddScanRoute,
        builder: (context, state) {
          final patientIdString = state.pathParameters['patientId'] ?? '';
          final patientUuid = UuidValue.fromString(
            patientIdString,
          );
          return LabAddScanScreen(patientId: patientUuid);
        },
      ),
      GoRoute(
        name: AppRoute.labAddHealthMeasurement.name,
        path: labAddHealthMeasurementRoute,
        builder: (context, state) {
          final patientIdString = state.pathParameters['patientId'] ?? '';
          final patientUuid = UuidValue.fromString(
            patientIdString,
          );
          return LabAddHealthMeasurementScreen(
            patientId: patientUuid,
          );
        },
      ),
      GoRoute(
        name: AppRoute.upload.name,
        path: uploadRoute,
        builder: (context, state) {
          final role = ref.read(userRoleProvider);
          if (role == 'doctor') {
            return const DoctorPatientsScreen();
          }
          if (role == 'labSpecialist') {
            return const LabPatientsScreen();
          }
          return const UploadScreen();
        },
      ),
      GoRoute(
        name: AppRoute.settings.name,
        path: settingsRoute,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        name: AppRoute.allergies.name,
        path: allergiesRoute,
        builder: (context, state) => const AllergiesScreen(),
      ),
      GoRoute(
        name: AppRoute.addAllergy.name,
        path: addAllergyRoute,
        builder: (context, state) => const AddAllergyScreen(),
      ),
      GoRoute(
        name: AppRoute.medications.name,
        path: medicationsRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const MedicationsScreen();
        },
      ),
      GoRoute(
        name: AppRoute.addMedication.name,
        path: addMedicationRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const AddMedicationScreen();
        },
      ),
      GoRoute(
        name: AppRoute.medicalHistory.name,
        path: medicalHistoryRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const MedicalHistoryScreen();
        },
      ),
      GoRoute(
        name: AppRoute.addMedicalHistory.name,
        path: addMedicalHistoryRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const AddMedicalHistoryScreen();
        },
      ),
      GoRoute(
        name: AppRoute.healthMeasurments.name,
        path: healthMeasurmentsRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const HealthMeasurementsScreen();
        },
      ),
      GoRoute(
        name: AppRoute.addHealthMeasurement.name,
        path: addHealthMeasurmentRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const AddHealthMeasurementScreen();
        },
      ),
    ],
  );
}

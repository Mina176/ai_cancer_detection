import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/src/features/patient/profile/patient_profile_provider.dart';
import 'package:cancer_ai_detection/src/utils/search_methods.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'select_doctor_controller.g.dart';

class SelectDoctorViewState {
  const SelectDoctorViewState({
    this.searchQuery = '',
    required this.allDoctors,
    required this.selectedDoctors,
  });

  final String searchQuery;
  final List<DoctorProfileModel> allDoctors;
  final List<PatientDoctorModel> selectedDoctors;

  bool isSelected(UuidValue doctorId) =>
      selectedDoctors.any((d) => d.doctorId == doctorId);

  List<DoctorProfileModel> get filteredAllDoctors {
    final selectedIds = selectedDoctors.map((d) => d.doctorId).toSet();

    final availableDoctors = allDoctors
        .where((d) => !selectedIds.contains(d.id))
        .toList();

    return availableDoctors.filterBySearch(searchQuery);
  }

  List<DoctorProfileModel> get filteredYourDoctors {
    final myDocs = selectedDoctors
        .map(
          (d) => d.doctor ?? allDoctors.firstWhere((a) => a.id == d.doctorId),
        )
        .toList();
    return myDocs.filterBySearch(searchQuery);
  }

  SelectDoctorViewState copyWith({
    String? searchQuery,
    List<DoctorProfileModel>? allDoctors,
    List<PatientDoctorModel>? selectedDoctors,
  }) {
    return SelectDoctorViewState(
      searchQuery: searchQuery ?? this.searchQuery,
      allDoctors: allDoctors ?? this.allDoctors,
      selectedDoctors: selectedDoctors ?? this.selectedDoctors,
    );
  }
}

@Riverpod()
class SelectDoctorController extends _$SelectDoctorController {
  @override
  Future<SelectDoctorViewState> build() async {
    return SelectDoctorViewState(
      allDoctors: await client.doctorProfile.getAllDoctors(),
      selectedDoctors: await client.patientDoctor.listMyDoctors(),
    );
  }

  void setSearchQuery(String value) {
    if (state.value != null) {
      state = AsyncData(state.value!.copyWith(searchQuery: value));
    }
  }

  Future<bool> toggleDoctor(UuidValue doctorId) async {
    final currentState = state.value;
    if (currentState == null) return false;

    final isSelected = currentState.isSelected(doctorId);
    final previousDoctors = currentState.selectedDoctors;

    List<PatientDoctorModel> newDoctors;
    if (isSelected) {
      newDoctors = previousDoctors
          .where((d) => d.doctorId != doctorId)
          .toList();
    } else {
      final patientId = ref.read(patientProfileProvider).value?.id;
      newDoctors = [
        ...previousDoctors,
        PatientDoctorModel(
          doctorId: doctorId,
          patientId: patientId!,
        ),
      ];
    }

    state = AsyncData(currentState.copyWith(selectedDoctors: newDoctors));

    try {
      if (isSelected) {
        await client.patientDoctor.removeDoctor(doctorId);
      } else {
        await client.patientDoctor.addDoctor(doctorId);
      }
      // TODO ref.invalidate(patientDoctorsProvider);
      return true;
    } catch (e) {
      state = AsyncData(
        currentState.copyWith(selectedDoctors: previousDoctors),
      );
      return false;
    }
  }
}

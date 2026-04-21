import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/src/features/patient/profile/patient_profile_provider.dart';
import 'package:cancer_ai_detection/src/utils/search_methods.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'select_lab_controller.g.dart';

class SelectLabViewState {
  const SelectLabViewState({
    this.searchQuery = '',
    required this.allLabs,
    required this.selectedLabs,
  });

  final String searchQuery;
  final List<LabProfileModel> allLabs;
  final List<PatientLabModel> selectedLabs;

  bool isSelected(UuidValue labId) => selectedLabs.any((l) => l.labId == labId);

  List<LabProfileModel> get filteredAllLabs {
    return allLabs.filterBySearch(searchQuery);
  }

  List<LabProfileModel> get filteredYourLabs {
    final myLabs = selectedLabs
        .map(
          (l) => l.lab ?? allLabs.firstWhere((a) => a.id == l.labId),
        )
        .toList();
    return myLabs.filterBySearch(searchQuery);
  }

  SelectLabViewState copyWith({
    String? searchQuery,
    List<LabProfileModel>? allLabs,
    List<PatientLabModel>? selectedLabs,
  }) {
    return SelectLabViewState(
      searchQuery: searchQuery ?? this.searchQuery,
      allLabs: allLabs ?? this.allLabs,
      selectedLabs: selectedLabs ?? this.selectedLabs,
    );
  }
}

@Riverpod()
class SelectLabController extends _$SelectLabController {
  @override
  Future<SelectLabViewState> build() async {
    return SelectLabViewState(
      allLabs: await client.labProfile.getAllLabs(),
      selectedLabs: await client.patientLab.listMyLabs(),
    );
  }

  void setSearchQuery(String value) {
    if (state.value != null) {
      state = AsyncData(state.value!.copyWith(searchQuery: value));
    }
  }

  Future<bool> toggleLab(UuidValue labId) async {
    final currentState = state.value;
    if (currentState == null) return false;

    final isSelected = currentState.isSelected(labId);
    final previousLabs = currentState.selectedLabs;

    List<PatientLabModel> newLabs;
    if (isSelected) {
      newLabs = previousLabs.where((l) => l.labId != labId).toList();
    } else {
      final patientId = ref.read(patientProfileProvider).value?.id;
      newLabs = [
        ...previousLabs,
        PatientLabModel(
          labId: labId,
          patientId: patientId!,
        ),
      ];
    }

    state = AsyncData(currentState.copyWith(selectedLabs: newLabs));

    try {
      if (isSelected) {
        await client.patientLab.removeLab(labId);
      } else {
        await client.patientLab.addLab(labId);
      }
      // TODO ref.invalidate(patientLabsProvider);
      return true;
    } catch (e) {
      state = AsyncData(
        currentState.copyWith(selectedLabs: previousLabs),
      );
      return false;
    }
  }
}

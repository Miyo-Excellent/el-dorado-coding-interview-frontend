import 'package:el_dorado_coding_interview_frontend/domain/models/personal_information_model.dart';
import 'package:el_dorado_coding_interview_frontend/domain/repositories/profile_repository.dart';

class SaveProfileUseCase {
  final ProfileRepository repository;

  SaveProfileUseCase(this.repository);

  Future<void> call(PersonalInformationModel info) {
    return repository.savePersonalInformation(info);
  }
}

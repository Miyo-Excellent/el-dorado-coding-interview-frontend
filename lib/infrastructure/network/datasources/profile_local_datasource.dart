import 'package:el_dorado_coding_interview_frontend/domain/models/personal_information_model.dart';

abstract class ProfileLocalDataSource {
  Future<PersonalInformationModel> getPersonalInformation();
  Future<void> savePersonalInformation(PersonalInformationModel info);
}

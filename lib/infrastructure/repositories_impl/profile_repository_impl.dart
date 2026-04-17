import 'package:el_dorado_coding_interview_frontend/domain/models/personal_information_model.dart';
import 'package:el_dorado_coding_interview_frontend/domain/repositories/profile_repository.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/network/datasources/profile_local_datasource.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileLocalDataSource localDataSource;

  ProfileRepositoryImpl({required this.localDataSource});

  @override
  Future<PersonalInformationModel> getPersonalInformation() {
    return localDataSource.getPersonalInformation();
  }

  @override
  Future<void> savePersonalInformation(PersonalInformationModel info) {
    return localDataSource.savePersonalInformation(info);
  }
}

import 'dart:convert';
import 'package:el_dorado_coding_interview_frontend/domain/models/personal_information_model.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/storage/hive_storage.dart';
import 'profile_local_datasource.dart';

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  static const String _profileKey = 'user_profile';

  @override
  Future<PersonalInformationModel> getPersonalInformation() async {
    final data = HiveStorage.profile.get(_profileKey);
    if (data != null) {
      final Map<String, dynamic> jsonMap = jsonDecode(data as String);
      return PersonalInformationModel.fromJson(jsonMap);
    }
    return PersonalInformationModel.empty();
  }

  @override
  Future<void> savePersonalInformation(PersonalInformationModel info) async {
    final String jsonString = jsonEncode(info.toJson());
    await HiveStorage.profile.put(_profileKey, jsonString);
  }
}

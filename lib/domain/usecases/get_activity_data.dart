import 'package:el_dorado_coding_interview_frontend/domain/repositories/activity_repository.dart';

class GetActivityData {
  final ActivityRepository repository;

  const GetActivityData(this.repository);

  Future<Map<String, dynamic>> call() {
    return repository.getActivityData();
  }
}

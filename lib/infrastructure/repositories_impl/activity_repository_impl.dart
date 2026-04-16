import 'package:el_dorado_coding_interview_frontend/domain/repositories/activity_repository.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/network/datasources/activity_mock_remote_datasource.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  final ActivityMockRemoteDataSource dataSource;

  const ActivityRepositoryImpl(this.dataSource);

  @override
  Future<Map<String, dynamic>> getActivityData() {
    return dataSource.fetchActivityData();
  }
}

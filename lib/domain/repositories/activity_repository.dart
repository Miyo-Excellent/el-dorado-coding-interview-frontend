/// Interface for Activity repository.
abstract class ActivityRepository {
  Future<Map<String, dynamic>> getActivityData();
}

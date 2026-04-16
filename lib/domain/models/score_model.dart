import 'package:equatable/equatable.dart';

class ScoreTierModel extends Equatable {
  final String nameCode; // NO_TIER, SILVER, GOLD
  final Map<String, String>? name;
  final double minScore;
  final double? maxScore;
  final bool isExpressCapable;
  final bool canOperateWithNewUsers;

  const ScoreTierModel({
    required this.nameCode,
    this.name,
    required this.minScore,
    this.maxScore,
    required this.isExpressCapable,
    required this.canOperateWithNewUsers,
  });

  factory ScoreTierModel.fromJson(Map<String, dynamic> json) {
    final flags = json['flags'] as Map<String, dynamic>? ?? {};
    final nameData = json['name'] as Map<String, dynamic>?;

    return ScoreTierModel(
      nameCode: json['nameCode'] as String? ?? 'NO_TIER',
      name: nameData?.map((key, value) => MapEntry(key, value.toString())),
      minScore: (json['minScore'] as num?)?.toDouble() ?? 0,
      maxScore: (json['maxScore'] as num?)?.toDouble(),
      isExpressCapable: flags['isExpressCapable'] as bool? ?? false,
      canOperateWithNewUsers: flags['canOperateWithNewUsers'] as bool? ?? false,
    );
  }

  @override
  List<Object?> get props => [
        nameCode,
        minScore,
        maxScore,
        isExpressCapable,
        canOperateWithNewUsers,
      ];
}

class ScoreFeatureModel extends Equatable {
  final String nameCode;
  final double? value;
  final double? score;

  const ScoreFeatureModel({
    required this.nameCode,
    this.value,
    this.score,
  });

  factory ScoreFeatureModel.fromJson(Map<String, dynamic> json) {
    return ScoreFeatureModel(
      nameCode: json['nameCode'] as String? ?? '',
      value: (json['value'] as num?)?.toDouble(),
      score: (json['score'] as num?)?.toDouble(),
    );
  }

  @override
  List<Object?> get props => [nameCode, value, score];
}

class ScoreModel extends Equatable {
  final bool dirty;
  final double? score;
  final ScoreTierModel tier;
  final String version;
  final List<ScoreFeatureModel> scorePerFeature;
  final List<ScoreFeatureModel> overrideScorePerFeature;

  const ScoreModel({
    required this.dirty,
    this.score,
    required this.tier,
    required this.version,
    required this.scorePerFeature,
    required this.overrideScorePerFeature,
  });

  factory ScoreModel.fromJson(Map<String, dynamic> json) {
    final sf = json['scorePerFeature'] as List<dynamic>? ?? [];
    final osf = json['overrideScorePerFeature'] as List<dynamic>? ?? [];

    return ScoreModel(
      dirty: json['dirty'] as bool? ?? false,
      score: (json['score'] as num?)?.toDouble(),
      tier: ScoreTierModel.fromJson(json['tier'] as Map<String, dynamic>? ?? {}),
      version: json['version'] as String? ?? 'v3.6',
      scorePerFeature: sf.map((e) => ScoreFeatureModel.fromJson(e)).toList(),
      overrideScorePerFeature: osf.map((e) => ScoreFeatureModel.fromJson(e)).toList(),
    );
  }

  @override
  List<Object?> get props => [
        dirty,
        score,
        tier,
        version,
        scorePerFeature,
        overrideScorePerFeature,
      ];
}

import 'package:hive/hive.dart';
import '../models/models.dart';

class StorageService {
  static const String _analysesBox = 'analyses';
  static const String _settingsBox = 'settings';

  static Future<void> saveTeamAnalysis(TeamAnalysis analysis) async {
    final box = Hive.box<Map>(_analysesBox);
    await box.put('team_${analysis.teamName}', analysis.toJson());
  }

  static Future<TeamAnalysis?> getTeamAnalysis(String teamName) async {
    final box = Hive.box<Map>(_analysesBox);
    final data = box.get('team_$teamName');
    
    if (data == null) return null;
    
    try {
      return TeamAnalysis.fromJson(Map<String, dynamic>.from(data));
    } catch (e) {
      return null;
    }
  }

  static Future<List<TeamAnalysis>> getAllTeamAnalyses() async {
    final box = Hive.box<Map>(_analysesBox);
    final analyses = <TeamAnalysis>[];

    for (final value in box.values) {
      try {
        if (value.containsKey('teamName')) {
          final analysis = TeamAnalysis.fromJson(Map<String, dynamic>.from(value));
          analyses.add(analysis);
        }
      } catch (e) {
        // Skip invalid entries
      }
    }
    return analyses;
  }

  static Future<void> deleteTeamAnalysis(String teamName) async {
    final box = Hive.box<Map>(_analysesBox);
    await box.delete('team_$teamName');
  }

  static Future<void> saveMatchAnalysis(MatchAnalysis analysis) async {
    final box = Hive.box<Map>(_analysesBox);
    final key = 'match_${analysis.team1}_${analysis.team2}_${analysis.matchDate.toString().split(' ')[0]}';
    // Convert to JSON manually
    await box.put(key, {});
  }

  static Future<List<MatchAnalysis>> getAllMatchAnalyses() async {
    return [];
  }

  static Future<void> saveApiKey(String apiKey) async {
    final box = Hive.box<String>(_settingsBox);
    await box.put('anthropic_api_key', apiKey);
  }

  static Future<String?> getApiKey() async {
    final box = Hive.box<String>(_settingsBox);
    return box.get('anthropic_api_key');
  }

  static Future<void> saveSetting(String key, dynamic value) async {
    final box = Hive.box(_settingsBox);
    await box.put(key, value);
  }

  static Future<dynamic> getSetting(String key, {dynamic defaultValue}) async {
    final box = Hive.box(_settingsBox);
    return box.get(key, defaultValue: defaultValue);
  }

  static Future<void> clearAll() async {
    await Hive.box(_analysesBox).clear();
    await Hive.box(_settingsBox).clear();
  }
}

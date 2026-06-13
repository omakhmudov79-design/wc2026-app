import 'package:dio/dio.dart';
import 'dart:convert';
import '../models/models.dart';

class AnthropicService {
  static const String baseUrl = 'https://api.anthropic.com/v1';
  static const String model = 'claude-sonnet-4-6';
  
  final Dio _dio;
  final String _apiKey;

  AnthropicService({required String apiKey})
      : _apiKey = apiKey,
        _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          contentType: 'application/json',
        ));

  Future<List<TeamAnalysis>> analyzeTeams(List<String> teamNames) async {
    final teamsStr = teamNames.join(', ');
    
    final prompt = '''Ты профессиональный футбольный аналитик ЧМ 2026.
    
Проведи анализ команд: $teamsStr

Для каждой команды выдай результат в следующем формате:

**КОМАНДА_NAME**
✓ Оценка: 75/100
💪 Сильные стороны: сильная атака, опытная защита
⚠️ Слабые стороны: проблемы на фланге
📊 xG: 2.3 за, 1.2 против
🎯 Ключевые игроки: Игрок 1, Игрок 2
📈 Вероятности:
- Победа: 65%
- Ничья: 20%
- Поражение: 15%
🏆 Выход из группы: 78%
🥇 Победа в турнире: 8.5%
📝 Прогноз: Команда в отличной форме, готова к турниру.

---''';

    try {
      final response = await _dio.post(
        '/messages',
        options: Options(headers: {'x-api-key': _apiKey}),
        data: {
          'model': model,
          'max_tokens': 2000,
          'messages': [
            {'role': 'user', 'content': prompt}
          ]
        },
      );

      final content = response.data['content'] as List;
      final textContent = content.firstWhere(
        (item) => item['type'] == 'text',
        orElse: () => {'text': ''},
      );

      final responseText = textContent['text'] as String? ?? '';
      
      // Парсим ответ
      final analyses = _parseAnalyses(responseText);
      return analyses;
    } catch (e) {
      print('Error analyzing teams: $e');
      rethrow;
    }
  }

  List<TeamAnalysis> _parseAnalyses(String text) {
    final analyses = <TeamAnalysis>[];
    final sections = text.split('---');

    for (final section in sections) {
      if (section.isEmpty) continue;
      
      final lines = section.trim().split('\n');
      if (lines.isEmpty) continue;

      final teamName = lines.first.replaceAll('**', '').trim();
      if (teamName.isEmpty) continue;

      double strength = 75;
      List<String> strengths = [];
      List<String> weaknesses = [];
      String xgData = '2.0 за, 1.5 против';
      List<String> keyPlayers = [];
      double winProb = 65;
      double drawProb = 20;
      double lossProb = 15;

      for (final line in lines) {
        if (line.contains('Оценка:')) {
          final match = RegExp(r'(\d+)').firstMatch(line);
          if (match != null) {
            strength = double.parse(match.group(1)!).toDouble();
          }
        }
        if (line.contains('💪')) {
          strengths = line.replaceAll('💪 Сильные стороны:', '').split(',').map((s) => s.trim()).toList();
        }
        if (line.contains('⚠️')) {
          weaknesses = line.replaceAll('⚠️ Слабые стороны:', '').split(',').map((s) => s.trim()).toList();
        }
        if (line.contains('📊')) {
          xgData = line.replaceAll('📊 xG:', '').trim();
        }
        if (line.contains('🎯')) {
          keyPlayers = line.replaceAll('🎯 Ключевые игроки:', '').split(',').map((s) => s.trim()).toList();
        }
        if (line.contains('Победа:')) {
          final match = RegExp(r'(\d+)%').firstMatch(line);
          if (match != null) winProb = double.parse(match.group(1)!).toDouble();
        }
      }

      final team = teamName.split(' ');
      final flag = team.isNotEmpty ? team.first : '🏴';
      final name = team.length > 1 ? team.sublist(1).join(' ') : teamName;

      analyses.add(TeamAnalysis(
        teamName: name,
        flag: flag,
        strength: strength,
        strengths: strengths.isEmpty ? ['Хорошая форма'] : strengths,
        weaknesses: weaknesses.isEmpty ? ['Опытная команда'] : weaknesses,
        xgData: xgData,
        keyPlayers: keyPlayers.isEmpty ? ['Лидер команды'] : keyPlayers,
        nextOpponent: 'TBD',
        nextMatchDate: DateTime.now().add(const Duration(days: 3)),
        winProbability: winProb,
        drawProbability: drawProb,
        lossProbability: lossProb,
        advanceProbability: 78,
        tournamentWinChance: 8.5,
        forecast: 'Команда готова к турниру',
        analyzedAt: DateTime.now(),
      ));
    }

    return analyses;
  }
}

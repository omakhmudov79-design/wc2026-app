import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/storage_service.dart';

class TeamsProvider extends ChangeNotifier {
  final List<Team> _teams = [
    Team(id: 1, name: 'Мексика', flag: '🇲🇽', country: 'Mexico', points: 3, played: 1, wins: 1, draws: 0, losses: 0, goalsFor: 2, goalsAgainst: 0, fifaRank: 13, eloRating: 1850, recentForm: ['W']),
    Team(id: 2, name: 'Аргентина', flag: '🇦🇷', country: 'Argentina', points: 0, played: 0, wins: 0, draws: 0, losses: 0, goalsFor: 0, goalsAgainst: 0, fifaRank: 1, eloRating: 1917, recentForm: []),
    Team(id: 3, name: 'Бразилия', flag: '🇧🇷', country: 'Brazil', points: 0, played: 0, wins: 0, draws: 0, losses: 0, goalsFor: 0, goalsAgainst: 0, fifaRank: 2, eloRating: 1900, recentForm: []),
    Team(id: 4, name: 'Франция', flag: '🇫🇷', country: 'France', points: 0, played: 0, wins: 0, draws: 0, losses: 0, goalsFor: 0, goalsAgainst: 0, fifaRank: 4, eloRating: 1860, recentForm: []),
    Team(id: 5, name: 'Англия', flag: '🇬🇧', country: 'England', points: 0, played: 0, wins: 0, draws: 0, losses: 0, goalsFor: 0, goalsAgainst: 0, fifaRank: 5, eloRating: 1850, recentForm: []),
    Team(id: 6, name: 'Испания', flag: '🇪🇸', country: 'Spain', points: 0, played: 0, wins: 0, draws: 0, losses: 0, goalsFor: 0, goalsAgainst: 0, fifaRank: 8, eloRating: 1830, recentForm: []),
  ];

  final Set<int> _selectedTeamIds = {};
  List<TeamAnalysis> _analyses = [];

  List<Team> get teams => _teams;
  Set<int> get selectedTeamIds => _selectedTeamIds;
  List<Team> get selectedTeams => _teams.where((t) => _selectedTeamIds.contains(t.id)).toList();
  List<TeamAnalysis> get analyses => _analyses;

  void toggleTeam(int teamId) {
    if (_selectedTeamIds.contains(teamId)) {
      _selectedTeamIds.remove(teamId);
    } else {
      _selectedTeamIds.add(teamId);
    }
    notifyListeners();
  }

  void selectAll() {
    _selectedTeamIds.addAll(_teams.map((t) => t.id));
    notifyListeners();
  }

  void clearSelection() {
    _selectedTeamIds.clear();
    notifyListeners();
  }

  Future<void> loadAnalyses() async {
    _analyses = await StorageService.getAllTeamAnalyses();
    notifyListeners();
  }

  void addAnalysis(TeamAnalysis analysis) {
    final index = _analyses.indexWhere((a) => a.teamName == analysis.teamName);
    if (index >= 0) {
      _analyses[index] = analysis;
    } else {
      _analyses.add(analysis);
    }
    notifyListeners();
  }
}

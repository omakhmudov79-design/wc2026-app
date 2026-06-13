import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/storage_service.dart';

class AnalysisProvider extends ChangeNotifier {
  List<MatchAnalysis> _matchAnalyses = [];
  bool _isLoading = false;
  String? _error;

  List<MatchAnalysis> get matchAnalyses => _matchAnalyses;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadMatchAnalyses() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _matchAnalyses = await StorageService.getAllMatchAnalyses();
      _isLoading = false;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
    }
    notifyListeners();
  }

  void addAnalysis(MatchAnalysis analysis) {
    final index = _matchAnalyses.indexWhere(
      (a) => (a.team1 == analysis.team1 && a.team2 == analysis.team2) ||
             (a.team1 == analysis.team2 && a.team2 == analysis.team1),
    );

    if (index >= 0) {
      _matchAnalyses[index] = analysis;
    } else {
      _matchAnalyses.add(analysis);
    }
    notifyListeners();
  }

  Future<void> saveAnalysis(MatchAnalysis analysis) async {
    addAnalysis(analysis);
    await StorageService.saveMatchAnalysis(analysis);
  }
}

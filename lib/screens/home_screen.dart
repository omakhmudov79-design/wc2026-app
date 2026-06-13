import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/teams_provider.dart';
import '../models/models.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ЧМ 2026 — AI Аналитик'),
        centerTitle: true,
      ),
      body: Consumer<TeamsProvider>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1a2235),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF1e2d45)),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'ЧМ 2026 АНАЛИТИК',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          color: Color(0xFF00d4aa),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Анализируй команды с помощью Claude AI',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6b7a99),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Выбрано команд: ${provider.selectedTeamIds.length}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFFF5c518),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: provider.selectAll,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1a2235),
                        ),
                        child: const Text('✓ Все'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: provider.clearSelection,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1a2235),
                        ),
                        child: const Text('✕ Сбросить'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.4,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: provider.teams.length,
                  itemBuilder: (context, index) {
                    final team = provider.teams[index];
                    final isSelected = provider.selectedTeamIds.contains(team.id);
                    
                    return GestureDetector(
                      onTap: () => provider.toggleTeam(team.id),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF1a2235) : const Color(0xFF111827),
                          border: Border.all(
                            color: isSelected ? const Color(0xFF00d4aa) : const Color(0xFF1e2d45),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(team.flag, style: const TextStyle(fontSize: 32)),
                            const SizedBox(height: 8),
                            Text(
                              team.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 4),
                            if (team.points > 0)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF00d4aa).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '${team.points}п',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF00d4aa),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                if (provider.selectedTeamIds.isNotEmpty)
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Анализ команд
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Запуск анализа... Установите API ключ в настройках'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.flash_on),
                      label: const Text('ЗАПУСТИТЬ АНАЛИЗ'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00d4aa),
                        foregroundColor: const Color(0xFF0a0e1a),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

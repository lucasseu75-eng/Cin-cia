import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';
import '../utils/page_transitions.dart';
import 'casting_result_screen.dart';

// Mock data model for a casting result entry
class _CastingEntry {
  final String projectName;
  final String role;
  final String agency;
  final String date;
  final CastingResultStatus status;

  const _CastingEntry({
    required this.projectName,
    required this.role,
    required this.agency,
    required this.date,
    required this.status,
  });
}

class MyResultsScreen extends StatelessWidget {
  const MyResultsScreen({super.key});

  static const List<_CastingEntry> _mockResults = [
    _CastingEntry(
      projectName: 'In The Shadow',
      role: 'Inspecteur Moreau',
      agency: 'Studio Lumières Production',
      date: '22 Avr. 2026',
      status: CastingResultStatus.selected,
    ),
    _CastingEntry(
      projectName: 'Le Dernier Train',
      role: 'Voyageur mystérieux',
      agency: 'Pathé Films',
      date: '14 Avr. 2026',
      status: CastingResultStatus.preselected,
    ),
    _CastingEntry(
      projectName: 'Abidjan by Night',
      role: 'Protagoniste principal',
      agency: 'Canal+ Afrique Studios',
      date: '03 Avr. 2026',
      status: CastingResultStatus.waiting,
    ),
    _CastingEntry(
      projectName: "L'Ombre de Paris",
      role: 'Commissaire adjoint',
      agency: 'Warner Bros France',
      date: '19 Mar. 2026',
      status: CastingResultStatus.refused,
    ),
    _CastingEntry(
      projectName: 'Série : Frontières',
      role: 'Agent de liaison',
      agency: 'Netflix Africa',
      date: '02 Mar. 2026',
      status: CastingResultStatus.refused,
    ),
    _CastingEntry(
      projectName: 'Spot publicitaire OrangeCi',
      role: 'Ambassadeur',
      agency: 'Publicis Abidjan',
      date: '12 Fév. 2026',
      status: CastingResultStatus.selected,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    // Stats
    final selected = _mockResults.where((e) => e.status == CastingResultStatus.selected).length;
    final total = _mockResults.length;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              isDarkMode ? const Color(0xFF8B2B2B) : const Color(0xFFFFD1D1),
              isDarkMode ? AppColors.backgroundDark : AppColors.backgroundLight,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.0, 0.4],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(Icons.arrow_back_ios_new, size: 16, color: colorScheme.onSurface),
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              'MES RÉSULTATS',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 1.0),
                            ),
                            Text(
                              'HISTORIQUE DE CANDIDATURES',
                              style: TextStyle(fontSize: 10, color: AppColors.primary, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 44),
                  ],
                ),
              ).animate().fadeIn(duration: 400.ms),

              // Stats card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: isDarkMode ? Border.all(color: AppColors.borderDark) : null,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStat('$total', 'Candidatures', Colors.grey),
                      _buildStatDivider(),
                      _buildStat('$selected', 'Sélections', Colors.green),
                      _buildStatDivider(),
                      _buildStat(
                        '${((selected / total) * 100).round()}%',
                        'Taux succès',
                        AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ).animate().fadeIn(delay: 150.ms),

              const SizedBox(height: 20),

              // List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                  itemCount: _mockResults.length,
                  itemBuilder: (context, index) {
                    final entry = _mockResults[index];
                    return _buildResultCard(context, entry, index, colorScheme, isDarkMode);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String value, String label, Color color) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: color)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
      ],
    );
  }

  Widget _buildStatDivider() {
    return Container(width: 1, height: 32, color: Colors.grey.withOpacity(0.2));
  }

  Widget _buildResultCard(BuildContext context, _CastingEntry entry, int index, ColorScheme colorScheme, bool isDarkMode) {
    final config = _statusConfig(entry.status);

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        CineciaTransition(page: CastingResultScreen(status: entry.status)),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: isDarkMode ? Border.all(color: AppColors.borderDark) : null,
          boxShadow: !isDarkMode
              ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12, offset: const Offset(0, 4))]
              : null,
        ),
        child: Row(
          children: [
            // Status icon
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: (config['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(config['icon'] as IconData, color: config['color'] as Color, size: 24),
            ),
            const SizedBox(width: 14),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.projectName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: colorScheme.onSurface),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Rôle : ${entry.role}',
                    style: TextStyle(fontSize: 12, color: colorScheme.onSurface.withOpacity(0.6)),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      // Status badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: (config['color'] as Color).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          config['label'] as String,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: config['color'] as Color,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(LucideIcons.calendar, size: 11, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(entry.date, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),

            // Arrow
            Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey.withOpacity(0.5)),
          ],
        ),
      ).animate().fadeIn(delay: Duration(milliseconds: 200 + index * 80)).slideY(begin: 0.1, end: 0),
    );
  }

  Map<String, dynamic> _statusConfig(CastingResultStatus status) {
    switch (status) {
      case CastingResultStatus.selected:
        return {'color': Colors.green, 'icon': LucideIcons.checkCircle, 'label': 'SÉLECTIONNÉ'};
      case CastingResultStatus.preselected:
        return {'color': Colors.orange, 'icon': LucideIcons.clock, 'label': 'PRÉ-SÉLECTIONNÉ'};
      case CastingResultStatus.refused:
        return {'color': Colors.grey, 'icon': LucideIcons.xCircle, 'label': 'NON RETENU'};
      case CastingResultStatus.waiting:
        return {'color': const Color(0xFF6B7280), 'icon': LucideIcons.hourglass, 'label': 'EN ATTENTE'};
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_colors.dart';
import '../providers/casting_provider.dart';
import '../widgets/cinecia_header.dart';
import 'casting_detail_screen.dart';

class MyCastingsScreen extends ConsumerWidget {
  const MyCastingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appliedIds = ref.watch(appliedCastingsProvider);
    final allCastings = ref.watch(castingsProvider);
    
    final appliedCastings = allCastings.where((c) => appliedIds.contains(c.id)).toList();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CineciaHeader(title: 'CANDIDATURES'),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${appliedCastings.length} POSTE${appliedCastings.length > 1 ? 'S' : ''}',
                      style: TextStyle(
                        color: isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: appliedCastings.isEmpty
                    ? Center(
                        child: Text(
                          "Aucune candidature envoyée.",
                          style: TextStyle(
                            color: isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight
                          ),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 100),
                        itemCount: appliedCastings.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final casting = appliedCastings[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CastingDetailScreen(casting: casting),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: colorScheme.surface,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: !isDarkMode ? AppColors.shadowLight : null,
                                border: isDarkMode ? Border.all(color: AppColors.borderDark) : null,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.asset(
                                      casting.imageUrl,
                                      width: 64,
                                      height: 64,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          casting.title,
                                          style: TextStyle(
                                            color: colorScheme.onSurface,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          casting.type,
                                          style: const TextStyle(
                                            color: AppColors.primary,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.0,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Icon(LucideIcons.mapPin, 
                                              size: 12, 
                                              color: isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
                                            const SizedBox(width: 4),
                                            Expanded(
                                              child: Text(
                                                casting.location,
                                                style: TextStyle(
                                                  color: isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight, 
                                                  fontSize: 12
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary.withOpacity(0.1),
                                          border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        child: const Text(
                                          'ENVOYÉ',
                                          style: TextStyle(
                                            color: AppColors.primary,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.0,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Icon(Icons.arrow_forward_ios, 
                                        color: isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight, 
                                        size: 16),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

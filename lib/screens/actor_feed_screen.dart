import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:cinecia/theme/app_colors.dart';
import 'package:cinecia/providers/casting_provider.dart';
import 'package:cinecia/widgets/casting_card.dart';
import 'package:cinecia/widgets/cinecia_header.dart';
import 'package:cinecia/utils/page_transitions.dart';
import 'package:cinecia/screens/casting_detail_screen.dart';

class ActorFeedScreen extends ConsumerWidget {
  const ActorFeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ['TOUS', 'CINÉMA', 'SÉRIE TV', 'THÉÂTRE', 'PUBLICITÉ'];
    final selectedFilter = ref.watch(selectedFilterProvider);
    final castings = ref.watch(filteredCastingsProvider);
    
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
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- SECTION FIXE (HAUT + PROFIL) ---
              const CineciaHeader(title: 'ABIDJAN'),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: !isDarkMode ? AppColors.shadowLight : null,
                    border: isDarkMode ? Border.all(color: AppColors.borderDark) : null,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(LucideIcons.user, color: Colors.white, size: 28),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Lucas Seu', 
                                style: TextStyle(color: colorScheme.onSurface, fontWeight: FontWeight.bold, fontSize: 18)),
                            const SizedBox(height: 4),
                            Text(
                              'comédien polyvalent passionné par le cinéma d\'auteur et le théâtre classique...',
                              style: TextStyle(
                                color: colorScheme.onSurface.withOpacity(0.6), 
                                fontSize: 11
                              ),
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text('ACTIF', 
                              style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w900, fontSize: 10)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              // --- SECTION FIXE (FILTRES) ---
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 0, 12),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: filters.map((f) {
                      final isSelected = f == selectedFilter;
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: GestureDetector(
                          onTap: () => ref.read(selectedFilterProvider.notifier).setFilter(f),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.primary : colorScheme.surface,
                              borderRadius: BorderRadius.circular(32),
                              boxShadow: !isDarkMode && !isSelected ? AppColors.shadowLight : null,
                              border: isDarkMode && !isSelected ? Border.all(color: AppColors.borderDark) : null,
                            ),
                            child: Text(
                              f,
                              style: TextStyle(
                                color: isSelected 
                                  ? Colors.white 
                                  : (isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              // --- SECTION DÉFILANTE (LISTE CASTINGS) ---
              Expanded(
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final casting = castings[index];
                            return CastingCard(
                              casting: casting,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CineciaTransition(
                                    page: CastingDetailScreen(casting: casting),
                                  ),
                                );
                              },
                            );
                          },
                          childCount: castings.length,
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 100)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

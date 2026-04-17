import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_colors.dart';
import '../models/casting.dart';
import '../providers/casting_provider.dart';
import '../widgets/primary_button.dart';

class CastingDetailScreen extends ConsumerWidget {
  final Casting casting;

  const CastingDetailScreen({super.key, required this.casting});

  void _showPostulationModal(BuildContext context, WidgetRef ref) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black.withOpacity(Theme.of(context).brightness == Brightness.dark ? 0.8 : 0.4),
      pageBuilder: (ctx, anim1, anim2) {
        return BackdropFilter(
          filter: anim1.value > 0.5 
            ? ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken) 
            : const ColorFilter.mode(Colors.transparent, BlendMode.srcOver),
          child: _PostulationModal(casting: casting)
        );
      },
      transitionBuilder: (ctx, anim1, anim2, child) {
        return FadeTransition(opacity: anim1, child: child);
      }
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasApplied = ref.watch(appliedCastingsProvider).contains(casting.id);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.white),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(LucideIcons.bookmark, size: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero Image
                SizedBox(
                  height: 400,
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        casting.imageUrl,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent, 
                              isDarkMode ? AppColors.backgroundDark : AppColors.backgroundLight
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.5, 1.0],
                          ),
                        ),
                      ),
                      // Top gradient for AppBar readability
                      Container(
                        height: 100,
                        alignment: Alignment.topCenter,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.black54, Colors.transparent],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                      // Play Pitch button
                      Positioned(
                        bottom: 32,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(32),
                              border: Border.all(color: Colors.white.withOpacity(0.5), width: 1),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  padding: const EdgeInsets.all(4),
                                  child: const Icon(Icons.play_arrow, color: Colors.black, size: 16),
                                ),
                                const SizedBox(width: 12),
                                const Text('Regarder le Pitch', 
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '${casting.rating} (${casting.reviewsCountText})',
                            style: TextStyle(
                              color: colorScheme.onSurface, 
                              fontWeight: FontWeight.bold, 
                              fontSize: 14
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              casting.title,
                              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                fontSize: 32,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ),
                          if (casting.isUrgent)
                            Container(
                              margin: const EdgeInsets.only(left: 16, top: 8),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.primary.withOpacity(0.5)),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Row(
                                children: [
                                  Icon(LucideIcons.clock, color: AppColors.primary, size: 12),
                                  SizedBox(width: 4),
                                  Text(
                                    'URGENT',
                                    style: TextStyle(color: AppColors.primary, fontSize: 10, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Tags
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: casting.tags.map((tag) {
                          final isFirst = casting.tags.indexOf(tag) == 0;
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: isFirst ? AppColors.primary : colorScheme.surface,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: !isDarkMode && !isFirst ? AppColors.shadowLight : null,
                              border: isDarkMode && !isFirst ? Border.all(color: AppColors.borderDark) : null,
                            ),
                            child: Text(
                              tag,
                              style: TextStyle(
                                color: isFirst 
                                  ? Colors.white 
                                  : (isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'DESCRIPTION DU POSTE',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Rôle récurrent pour la nouvelle saison. Jeune lycéen\ndynamique.',
                        style: TextStyle(
                          color: colorScheme.onSurface.withOpacity(0.8),
                          fontSize: 14,
                          height: 1.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: !isDarkMode ? AppColors.shadowLight : null,
                          border: isDarkMode ? Border.all(color: AppColors.borderDark) : null,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'LE PROFIL RECHERCHÉ',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "Garçon, 16-19 ans, allure sportive, à l'aise avec\nl'improvisation.",
                              style: TextStyle(
                                color: colorScheme.onSurface,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Bottom Fixed Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    (isDarkMode ? AppColors.backgroundDark : AppColors.backgroundLight).withOpacity(0), 
                    isDarkMode ? AppColors.backgroundDark : AppColors.backgroundLight
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.4],
                ),
              ),
              child: SafeArea(
                child: hasApplied
                    ? ElevatedButton(
                        onPressed: null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.surface,
                          disabledBackgroundColor: colorScheme.surface,
                          disabledForegroundColor: isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                          minimumSize: const Size(double.infinity, 56),
                        ),
                        child: const Text('DÉJÀ POSTULÉ'),
                      )
                    : PrimaryButton(
                        text: 'POSTULER MAINTENANT',
                        onPressed: () => _showPostulationModal(context, ref),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PostulationModal extends ConsumerStatefulWidget {
  final Casting casting;
  const _PostulationModal({required this.casting});

  @override
  ConsumerState<_PostulationModal> createState() => _PostulationModalState();
}

class _PostulationModalState extends ConsumerState<_PostulationModal> {
  bool _isSuccess = false;

  void _confirm() {
    setState(() {
      _isSuccess = true;
    });
    ref.read(appliedCastingsProvider.notifier).apply(widget.casting.id);
    
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _isSuccess
              ? Container(
                  key: const ValueKey('success'),
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: !isDarkMode ? AppColors.shadowLight : null,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.success.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.check_circle, color: AppColors.success, size: 48),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Candidature Envoyée !',
                        style: TextStyle(
                          color: colorScheme.onSurface, 
                          fontSize: 18, 
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  key: const ValueKey('confirm'),
                  padding: const EdgeInsets.all(32),
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: !isDarkMode ? AppColors.shadowLight : null,
                    border: isDarkMode ? Border.all(color: AppColors.borderDark) : null,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Confirmer la candidature ?',
                        style: TextStyle(
                          color: colorScheme.onSurface, 
                          fontSize: 20, 
                          fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Votre profil sera envoyé pour "${widget.casting.title}".',
                        style: TextStyle(
                          color: colorScheme.onSurface.withOpacity(0.6)
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      PrimaryButton(
                        text: 'OUI, POSTULER',
                        onPressed: _confirm,
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Annuler', 
                          style: TextStyle(
                            color: isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight
                          )
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

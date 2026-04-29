import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';
import '../widgets/primary_button.dart';
import '../widgets/cinecia_header.dart';
import 'create_offer_screen.dart';
import '../utils/page_transitions.dart';

class DashboardAgentScreen extends ConsumerWidget {
  const DashboardAgentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textPrimary = isDarkMode ? Colors.white : Colors.black;
    final textSecondary = isDarkMode ? Colors.grey[400]! : Colors.grey[700]!;
    final surfaceColor = isDarkMode ? AppColors.surfaceDark : Colors.white;
    final borderColor = isDarkMode ? AppColors.borderDark : Colors.grey[200]!;

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
              const CineciaHeader(title: 'DASHBOARD'),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      _buildWelcomeHeader(textPrimary, textSecondary),
                      const SizedBox(height: 30),
                      _buildStatsSection(context, surfaceColor, borderColor, textPrimary, textSecondary),
                      const SizedBox(height: 30),
                      _buildQuickActions(context),
                      const SizedBox(height: 30),
                      _buildUpcomingEvents(context, surfaceColor, borderColor, textPrimary, textSecondary),
                      const SizedBox(height: 30),
                      _buildRecentActivity(context, surfaceColor, borderColor, textPrimary, textSecondary),
                      const SizedBox(height: 30),
                      _buildQuickAccess(context, textSecondary),
                      const SizedBox(height: 100), // Space for bottom nav
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeHeader(Color textPrimary, Color textSecondary) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bonjour,',
          style: GoogleFonts.plusJakartaSans(
            color: textSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          'Studio Cinéma Plus',
          style: GoogleFonts.plusJakartaSans(
            color: textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildStatsSection(BuildContext context, Color surface, Color border, Color textPrimary, Color textSecondary) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.3, // Taller cards to prevent overflow
      children: [
        _buildStatCard(context, LucideIcons.clapperboard, '12', 'Castings actifs', surface, border, textPrimary, textSecondary),
        _buildStatCard(context, LucideIcons.users, '48', 'Candidatures', surface, border, textPrimary, textSecondary),
        _buildStatCard(context, LucideIcons.star, '24', 'Shortlistés', surface, border, textPrimary, textSecondary),
        _buildStatCard(context, LucideIcons.calendar, '5', 'Prochains', surface, border, textPrimary, textSecondary),
      ],
    ).animate().fadeIn(duration: 500.ms, delay: 100.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildStatCard(BuildContext context, IconData icon, String value, String label, Color surface, Color border, Color textPrimary, Color textSecondary) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: border),
        boxShadow: Theme.of(context).brightness == Brightness.light ? AppColors.shadowLight : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                style: GoogleFonts.plusJakartaSans(
                  color: textPrimary,
                  fontSize: 22, // Slightly larger for emphasis
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  color: textSecondary,
                  fontSize: 11, // Slightly smaller to fit better
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ACTIONS RAPIDES',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                context,
                'Créer un casting',
                LucideIcons.plus,
                () => Navigator.push(context, CineciaTransition(page: const CreateOfferScreen())),
                isPrimary: true,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionButton(
                context,
                'Lancer en ligne',
                LucideIcons.video,
                () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                context,
                'Voir candidats',
                LucideIcons.users,
                () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionButton(
                context,
                'Accéder démos',
                LucideIcons.playCircle,
                () {},
              ),
            ),
          ],
        ),
      ],
    ).animate().fadeIn(duration: 500.ms, delay: 200.ms);
  }

  Widget _buildActionButton(BuildContext context, String text, IconData icon, VoidCallback onTap, {bool isPrimary = false}) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.primary : (isDarkMode ? AppColors.surfaceDark : Colors.white),
          borderRadius: BorderRadius.circular(16),
          border: isPrimary ? null : Border.all(color: isDarkMode ? AppColors.borderDark : Colors.grey[200]!),
          boxShadow: !isPrimary && !isDarkMode ? AppColors.shadowLight : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isPrimary ? Colors.white : (isDarkMode ? Colors.white : Colors.black), size: 18),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                text,
                style: GoogleFonts.plusJakartaSans(
                  color: isPrimary ? Colors.white : (isDarkMode ? Colors.white : Colors.black),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingEvents(BuildContext context, Color surface, Color border, Color textPrimary, Color textSecondary) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'PROCHAINS ÉVÉNEMENTS',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
                color: textSecondary,
              ),
            ),
            Icon(LucideIcons.chevronRight, size: 16, color: textSecondary),
          ],
        ),
        const SizedBox(height: 16),
        _buildEventCard(context, 'Casting : L\'Ombre de Paris', 'En ligne', 'Aujourd\'hui • 14:30', '12 candidats', surface, border, textPrimary, textSecondary),
        _buildEventCard(context, 'Série : Les Rues d\'Or', 'Sur site', 'Demain • 10:00', '45 candidats', surface, border, textPrimary, textSecondary),
      ],
    ).animate().fadeIn(duration: 500.ms, delay: 300.ms);
  }

  Widget _buildEventCard(BuildContext context, String title, String type, String time, String candidates, Color surface, Color border, Color textPrimary, Color textSecondary) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: border),
        boxShadow: Theme.of(context).brightness == Brightness.light ? AppColors.shadowLight : null,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(LucideIcons.calendar, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    color: textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(type, style: TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w600)),
                    Text(' • $time', style: TextStyle(color: textSecondary, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(candidates, style: TextStyle(color: textSecondary, fontSize: 12)),
              ],
            ),
          ),
          Icon(LucideIcons.chevronRight, color: textSecondary, size: 20),
        ],
      ),
    );
  }

  Widget _buildRecentActivity(BuildContext context, Color surface, Color border, Color textPrimary, Color textSecondary) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ACTIVITÉ RÉCENTE',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
            color: textSecondary,
          ),
        ),
        const SizedBox(height: 16),
        _buildActivityItem(LucideIcons.userPlus, 'Nouvelle candidature reçue', 'Il y a 5 min', textPrimary, textSecondary),
        _buildActivityItem(LucideIcons.star, 'Acteur ajouté à shortlist', 'Il y a 1h', textPrimary, textSecondary),
        _buildActivityItem(LucideIcons.edit3, 'Casting mis à jour', 'Il y a 3h', textPrimary, textSecondary),
        _buildActivityItem(LucideIcons.messageSquare, 'Message reçu de Paul Valery', 'Il y a 5h', textPrimary, textSecondary),
      ],
    ).animate().fadeIn(duration: 500.ms, delay: 400.ms);
  }

  Widget _buildActivityItem(IconData icon, String text, String time, Color textPrimary, Color textSecondary) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, size: 16, color: textSecondary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.plusJakartaSans(color: textPrimary, fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            time,
            style: GoogleFonts.plusJakartaSans(color: textSecondary, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAccess(BuildContext context, Color textSecondary) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ACCÈS RAPIDE',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
            color: textSecondary,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          children: [
            _buildQuickAccessChip(context, 'Favoris'),
            _buildQuickAccessChip(context, 'Castings récents'),
            _buildQuickAccessChip(context, 'Derniers acteurs'),
          ],
        ),
      ],
    ).animate().fadeIn(duration: 500.ms, delay: 500.ms);
  }

  Widget _buildQuickAccessChip(BuildContext context, String label) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Chip(
      label: Text(label, style: const TextStyle(fontSize: 12)),
      backgroundColor: Colors.transparent,
      side: BorderSide(color: isDarkMode ? AppColors.borderDark : Colors.grey[300]!, width: 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}

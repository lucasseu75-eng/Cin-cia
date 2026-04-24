import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_colors.dart';

enum CastingResultStatus { selected, preselected, refused, waiting }

class CastingResultScreen extends StatefulWidget {
  final CastingResultStatus status;

  const CastingResultScreen({
    super.key,
    this.status = CastingResultStatus.selected,
  });

  @override
  State<CastingResultScreen> createState() => _CastingResultScreenState();
}

class _CastingResultScreenState extends State<CastingResultScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;
  bool _showPopup = true;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _scaleAnim = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutBack),
    );
    _animController.forward();
    // Dismiss popup after 2.5s
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) setState(() => _showPopup = false);
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
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
          ),

          SafeArea(
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
                          child: Icon(Icons.arrow_back_ios_new,
                              size: 16, color: colorScheme.onSurface),
                        ),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            'Résultat du casting',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(width: 44),
                    ],
                  ),
                ),

                Expanded(
                  child: FadeTransition(
                    opacity: _fadeAnim,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                      child: Column(
                        children: [
                          const SizedBox(height: 16),

                          // Casting Info Card
                          _buildInfoCard(colorScheme, isDarkMode),
                          const SizedBox(height: 24),

                          // Status Block
                          ScaleTransition(
                            scale: _scaleAnim,
                            child: _buildStatusBlock(),
                          ),
                          const SizedBox(height: 24),

                          // Agency message
                          _buildAgencyMessage(colorScheme, isDarkMode),
                          const SizedBox(height: 32),

                          // Action Buttons
                          _buildActions(),
                          const SizedBox(height: 32),

                          // History
                          _buildHistory(colorScheme, isDarkMode),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Popup overlay
          if (_showPopup) _buildPopup(isDarkMode),
        ],
      ),
    );
  }

  Widget _buildInfoCard(ColorScheme colorScheme, bool isDarkMode) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: !isDarkMode
            ? [BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 20, offset: const Offset(0, 4))]
            : null,
        border: isDarkMode ? Border.all(color: AppColors.borderDark) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(LucideIcons.film, color: AppColors.primary, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Film long métrage',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('In The Shadow',
                        style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildInfoRow(LucideIcons.user2, 'Rôle', 'Inspecteur Moreau', colorScheme),
          const Divider(height: 20),
          _buildInfoRow(LucideIcons.building2, 'Agence', 'Studio Lumières Production', colorScheme),
          const Divider(height: 20),
          _buildInfoRow(LucideIcons.calendar, 'Date du casting', '22 Avril 2026', colorScheme),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, ColorScheme colorScheme) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 8),
        Text('$label : ', style: const TextStyle(color: Colors.grey, fontSize: 13)),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: colorScheme.onSurface),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBlock() {
    final config = _statusConfig();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: config['color'].withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: config['color'].withOpacity(0.3), width: 1.5),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: config['color'].withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(config['icon'], color: config['color'], size: 36),
          ),
          const SizedBox(height: 16),
          Text(
            config['title'],
            textAlign: TextAlign.center,
            style: TextStyle(
              color: config['color'],
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgencyMessage(ColorScheme colorScheme, bool isDarkMode) {
    final messages = {
      CastingResultStatus.selected:
          'L\'agence sera en contact avec vous dans les prochains jours pour les détails contractuels.',
      CastingResultStatus.preselected:
          'Vous serez contacté pour une deuxième audition. Restez disponible.',
      CastingResultStatus.refused:
          'Votre talent a été apprécié. Nous vous encourageons à postuler pour d\'autres projets.',
      CastingResultStatus.waiting:
          'L\'agence finalise sa sélection. Vous recevrez une notification dans 48h.',
    };
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: isDarkMode ? Border.all(color: AppColors.borderDark) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(LucideIcons.messageSquare, size: 16, color: Colors.grey),
              SizedBox(width: 8),
              Text('Message de l\'agence',
                  style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            messages[widget.status]!,
            style: TextStyle(color: colorScheme.onSurface.withOpacity(0.8), fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    switch (widget.status) {
      case CastingResultStatus.selected:
        return Column(
          children: [
            _primaryButton('Contacter l\'agence', LucideIcons.phone, () {}),
            const SizedBox(height: 12),
            _secondaryButton('Voir les détails', () {}),
          ],
        );
      case CastingResultStatus.preselected:
        return _primaryButton('Voir la prochaine étape', LucideIcons.arrowRight, () {});
      case CastingResultStatus.refused:
        return _primaryButton('Voir d\'autres castings', LucideIcons.search, () {});
      case CastingResultStatus.waiting:
        return _secondaryButton('Retour aux castings', () {});
    }
  }

  Widget _buildHistory(ColorScheme colorScheme, bool isDarkMode) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: isDarkMode ? Border.all(color: AppColors.borderDark) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('HISTORIQUE', style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
          const SizedBox(height: 16),
          _historyItem('Candidature soumise', '18 Avril 2026', colorScheme),
          _historyItem('Casting effectué', '22 Avril 2026', colorScheme),
          _historyItem('Résultat publié', 'Aujourd\'hui', colorScheme, isLast: true),
        ],
      ),
    );
  }

  Widget _historyItem(String title, String date, ColorScheme colorScheme, {bool isLast = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 10, height: 10,
              decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
            ),
            if (!isLast)
              Container(width: 2, height: 32, color: AppColors.primary.withOpacity(0.2)),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: colorScheme.onSurface)),
                Text(date, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _primaryButton(String label, IconData icon, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 18),
        label: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }

  Widget _secondaryButton(String label, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.primary),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: Text(label, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 15)),
      ),
    );
  }

  Widget _buildPopup(bool isDarkMode) {
    final config = _statusConfig();
    final message = widget.status == CastingResultStatus.selected
        ? 'Félicitations ! Vous êtes retenu'
        : widget.status == CastingResultStatus.preselected
            ? 'Bonne nouvelle ! Étape suivante disponible'
            : 'Résultat disponible';

    return AnimatedOpacity(
      opacity: _showPopup ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 400),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100, left: 24, right: 24),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xFF1E2028) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 30)],
              border: Border.all(color: config['color'].withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(config['icon'], color: config['color'], size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(message,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> _statusConfig() {
    switch (widget.status) {
      case CastingResultStatus.selected:
        return {
          'color': Colors.green,
          'icon': LucideIcons.checkCircle,
          'title': 'Félicitations, vous êtes sélectionné',
        };
      case CastingResultStatus.preselected:
        return {
          'color': Colors.orange,
          'icon': LucideIcons.clock,
          'title': 'Vous êtes retenu pour la prochaine étape',
        };
      case CastingResultStatus.refused:
        return {
          'color': Colors.grey,
          'icon': LucideIcons.xCircle,
          'title': 'Votre profil n\'a pas été retenu pour ce rôle',
        };
      case CastingResultStatus.waiting:
        return {
          'color': const Color(0xFF6B7280),
          'icon': LucideIcons.hourglass,
          'title': 'Votre candidature est en cours d\'évaluation',
        };
    }
  }
}

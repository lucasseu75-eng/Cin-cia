import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_colors.dart';

import '../models/user_role.dart';

class GlassNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final UserRole userRole;

  const GlassNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.userRole = UserRole.actor,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF12141A).withOpacity(0.8) : Colors.white.withOpacity(0.9),
        border: isDarkMode 
          ? Border(top: BorderSide(color: Colors.white.withOpacity(0.05), width: 1))
          : null,
        boxShadow: !isDarkMode ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          )
        ] : null,
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            height: 90,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: userRole == UserRole.actor 
                ? [
                    _buildNavItem(context, 0, LucideIcons.home, 'Casting'),
                    _buildNavItem(context, 1, LucideIcons.messageSquare, 'Messages'),
                    _buildNavItem(context, 2, LucideIcons.tv, 'Mes Postulations'),
                    _buildNavItem(context, 3, LucideIcons.user, 'Profil'),
                  ]
                : [
                    _buildNavItem(context, 0, LucideIcons.home, 'Candidat'),
                    _buildNavItem(context, 1, LucideIcons.messageSquare, 'Contacts'),
                    _buildNavItem(context, 2, LucideIcons.briefcase, 'Casting'),
                    _buildNavItem(context, 3, LucideIcons.user, 'Profil'),
                  ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index, IconData icon, String label) {
    final isSelected = currentIndex == index;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: isSelected
            ? const EdgeInsets.symmetric(horizontal: 20, vertical: 12)
            : const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected 
                ? Colors.white 
                : (isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
              size: 24,
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

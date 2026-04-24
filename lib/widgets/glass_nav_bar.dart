import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
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
    
    // Background of the bar itself
    final Color barColor = isDarkMode ? const Color(0xFF1A1D23) : Colors.white;
    
    // The background of the screen content (for the curve cutout illusion)
    final Color backgroundColor = isDarkMode ? AppColors.backgroundDark : AppColors.backgroundLight;

    final List<IconData> icons = userRole == UserRole.actor 
      ? [
          LucideIcons.home,
          LucideIcons.playCircle,
          LucideIcons.video,
          LucideIcons.tv,
          LucideIcons.user,
        ]
      : [
          LucideIcons.home,
          LucideIcons.playCircle,
          LucideIcons.video,
          LucideIcons.briefcase,
          LucideIcons.user,
        ];

    return CurvedNavigationBar(
      index: currentIndex,
      height: 70.0,
      items: icons.map((icon) => _buildIcon(icon, icons.indexOf(icon) == currentIndex, isDarkMode)).toList(),
      color: barColor,
      buttonBackgroundColor: AppColors.primary,
      backgroundColor: backgroundColor,
      animationCurve: Curves.easeInOutCubic,
      animationDuration: const Duration(milliseconds: 500),
      onTap: onTap,
    );
  }

  Widget _buildIcon(IconData icon, bool isSelected, bool isDarkMode) {
    return Icon(
      icon,
      size: 26,
      color: isSelected 
        ? Colors.white 
        : (isDarkMode ? Colors.white70 : Colors.black54),
    );
  }
}

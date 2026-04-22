import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../utils/page_transitions.dart';
import '../screens/notifications_screen.dart';
import '../screens/messages_screen.dart';
import '../screens/profile_screen.dart';

class CineciaHeader extends StatelessWidget {
  final String? title;
  
  const CineciaHeader({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textPrimary = isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final surfaceColor = isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight;

    return Container(
      height: 60, // Fixed height for corporate consistency
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. Profile Avatar at far LEFT
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                CineciaTransition(page: const ProfileScreen()),
              );
            },
            child: const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/user_avatar.png'),
            ),
          ),
          
          const SizedBox(width: 12),
          
          // 2. Uniform Title (near the profile circle)
          if (title != null) ...[
            Text(
              title!.toUpperCase(),
              style: GoogleFonts.roboto(
                color: textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
              ),
            ),
          ],
          
          const Spacer(),

          // 3. Icons Bundle at far RIGHT in order: Search, Message, Notification
          _HeaderIcon(
            icon: LucideIcons.search,
            onTap: () {
              // TODO: Implement Search
            },
            color: textPrimary,
          ),
          const SizedBox(width: 16),
          
          _HeaderIcon(
            icon: LucideIcons.messageSquare,
            onTap: () {
              Navigator.push(
                context,
                CineciaTransition(page: const MessagesScreen()),
              );
            },
            color: textPrimary,
          ),
          const SizedBox(width: 16),
          
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                CineciaTransition(page: const NotificationsScreen()),
              );
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(LucideIcons.bell, color: textPrimary, size: 24),
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: surfaceColor, width: 1.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  const _HeaderIcon({
    required this.icon,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, color: color, size: 24),
    );
  }
}

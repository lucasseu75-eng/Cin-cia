import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_colors.dart';
import '../widgets/primary_button.dart';
import '../widgets/custom_text_field.dart';
import '../models/user_role.dart';
import '../providers/auth_provider.dart';
import 'main_screen.dart';
import '../utils/page_transitions.dart';

class RegisterActorScreen extends ConsumerWidget {
  const RegisterActorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? AppColors.backgroundDark : AppColors.backgroundLight;
    final textPrimary = isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final textSecondary = isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final surfaceColor = isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight;
    final borderColor = isDarkMode ? AppColors.borderDark : AppColors.borderLight;

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
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Custom Back Button
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: surfaceColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: borderColor),
                        boxShadow: !isDarkMode ? AppColors.shadowLight : null,
                      ),
                      child: Icon(Icons.arrow_back_ios_new, size: 16, color: textPrimary),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Inscription Acteur',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Rejoignez l'élite du cinéma.",
                  style: TextStyle(color: textSecondary, fontSize: 14),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    backgroundColor: surfaceColor,
                    side: BorderSide(color: borderColor),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icon/icone-google.png',
                        height: 24,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "S'inscrire avec Google",
                        style: TextStyle(
                          color: textPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: Divider(color: borderColor, thickness: 1)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'OU',
                        style: TextStyle(color: textSecondary, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(child: Divider(color: borderColor, thickness: 1)),
                  ],
                ),
                const SizedBox(height: 16),
                const CustomTextField(
                  label: 'Nom Complet',
                  placeholder: 'Ex: Lucas Seu',
                ),
                const SizedBox(height: 12),
                const CustomTextField(
                  label: 'Numéro',
                  placeholder: 'Ex: +225 07 00 00 00 00',
                ),
                const SizedBox(height: 12),
                const CustomTextField(
                  label: 'Mot de passe',
                  placeholder: '••••••••',
                  isPassword: true,
                ),
                const SizedBox(height: 24),
                PrimaryButton(
                  text: 'Créer mon compte',
                  onPressed: () {
                    // Set the role to actor
                    ref.read(userRoleProvider.notifier).setRole(UserRole.actor);

                    Navigator.pushAndRemoveUntil(
                      context,
                      CineciaTransition(page: const MainScreen()),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

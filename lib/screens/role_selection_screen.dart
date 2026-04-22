import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_colors.dart';
import '../widgets/primary_button.dart';
import 'login_screen.dart';
import 'register_actor_screen.dart';
import 'register_agent_screen.dart';
import '../utils/page_transitions.dart';
import '../utils/app_branding.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? AppColors.backgroundDark : AppColors.backgroundLight;
    final textPrimary = isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final textSecondary = isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight - 64.0),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      // Logo
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.bottomRight,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.asset(
                              'assets/icon/Logo_cinecia.png',
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),

                      Text(
                        AppBranding.fullTitle,
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: textPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "L'excellence du casting\ncommence ici.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: textSecondary,
                          fontSize: 18,
                          height: 1.5,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'CRÉER UN COMPTE EN TANT QUE',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: textPrimary,
                        ),
                      ),
                      const SizedBox(height: 24),
                      PrimaryButton(
                        text: 'Acteur',
                        icon: const Icon(LucideIcons.user),
                        onPressed: () {
                          Navigator.push(
                            context,
                            CineciaTransition(page: const RegisterActorScreen()),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            CineciaTransition(page: const RegisterAgentScreen()),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 56),
                        ).copyWith(
                          side: WidgetStateProperty.all(const BorderSide(color: AppColors.primary, width: 1)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(LucideIcons.building2, color: AppColors.primary),
                            const SizedBox(width: 12),
                            Text(
                              'AGENT / PRODUCTION',
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: AppColors.primary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 48),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            CineciaTransition(page: const LoginScreen()),
                          );
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'Déjà un compte ? ',
                            style: TextStyle(color: textSecondary, fontSize: 14),
                            children: [
                              TextSpan(
                                text: 'Se connecter',
                                style: TextStyle(
                                  color: textPrimary,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

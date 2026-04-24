import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_colors.dart';
import '../widgets/primary_button.dart';
import '../widgets/custom_text_field.dart';
import '../models/user_role.dart';
import '../providers/auth_provider.dart';
import 'main_screen.dart';
import '../utils/page_transitions.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  UserRole _selectedRole = UserRole.actor;

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Custom Back Button in Header
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
                  'Connexion',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Accédez à votre univers artistique.',
                  style: TextStyle(color: textSecondary, fontSize: 16),
                ),
                const SizedBox(height: 32),
                // Temporary Role Selector for Demo
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedRole = UserRole.actor),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: _selectedRole == UserRole.actor ? AppColors.primary : surfaceColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: borderColor),
                            boxShadow: !isDarkMode && _selectedRole != UserRole.actor ? AppColors.shadowLight : null,
                          ),
                          child: Center(
                            child: Text(
                              'ACTEUR',
                              style: TextStyle(
                                color: _selectedRole == UserRole.actor ? Colors.white : textSecondary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedRole = UserRole.agent),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: _selectedRole == UserRole.agent ? AppColors.primary : surfaceColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: borderColor),
                            boxShadow: !isDarkMode && _selectedRole != UserRole.agent ? AppColors.shadowLight : null,
                          ),
                          child: Center(
                            child: Text(
                              'AGENT',
                              style: TextStyle(
                                color: _selectedRole == UserRole.agent ? Colors.white : textSecondary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                const CustomTextField(
                  label: "Nom d'utilisateur",
                  placeholder: 'Votre nom',
                ),
                const SizedBox(height: 24),
                const CustomTextField(
                  label: 'Mot de passe',
                  placeholder: '••••••••',
                  isPassword: true,
                ),
                const SizedBox(height: 40),
                PrimaryButton(
                  text: 'Se connecter',
                  onPressed: () {
                    // Set the role
                    ref.read(userRoleProvider.notifier).setRole(_selectedRole);

                    Navigator.pushAndRemoveUntil(
                      context,
                      CineciaTransition(page: const MainScreen()),
                      (route) => false,
                    );
                  },
                ),
                const SizedBox(height: 32),
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
                const SizedBox(height: 32),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
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
                        'Continuer avec Google',
                        style: TextStyle(
                          color: textPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
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

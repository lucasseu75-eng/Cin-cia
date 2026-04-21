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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.arrow_back_ios_new, size: 16),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Text(
              'Connexion',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 8),
            const Text(
              'Accédez à votre univers artistique.',
              style: TextStyle(color: AppColors.textBody, fontSize: 16),
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
                        color: _selectedRole == UserRole.actor ? AppColors.primary : AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'ACTEUR',
                          style: TextStyle(
                            color: _selectedRole == UserRole.actor ? Colors.white : AppColors.textBody,
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
                        color: _selectedRole == UserRole.agent ? AppColors.primary : AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'AGENT',
                          style: TextStyle(
                            color: _selectedRole == UserRole.agent ? Colors.white : AppColors.textBody,
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
                const Expanded(child: Divider(color: AppColors.surface, thickness: 2)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'OU',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 12),
                  ),
                ),
                const Expanded(child: Divider(color: AppColors.surface, thickness: 2)),
              ],
            ),
            const SizedBox(height: 32),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
                side: BorderSide.none,
                backgroundColor: AppColors.surface,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'G',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Continuer avec Google',
                    style: TextStyle(
                      color: AppColors.white,
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
    );
  }
}

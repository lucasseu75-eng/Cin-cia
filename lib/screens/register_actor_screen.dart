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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Inscription Acteur',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 4),
            const Text(
              "Rejoignez l'élite du cinéma.",
              style: TextStyle(color: AppColors.textBody, fontSize: 14),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
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
                    "S'inscrire avec Google",
                    style: TextStyle(
                      color: AppColors.white,
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
    );
  }
}

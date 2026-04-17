import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_colors.dart';
import '../widgets/primary_button.dart';
import '../widgets/custom_text_field.dart';
import '../models/user_role.dart';
import '../providers/auth_provider.dart';
import 'main_screen.dart';

class RegisterAgentScreen extends ConsumerWidget {
  const RegisterAgentScreen({super.key});

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
              'Inscription Agent',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 4),
            const Text(
              "Recrutez les meilleurs talents.",
              style: TextStyle(color: AppColors.textBody, fontSize: 14),
            ),
            const SizedBox(height: 16),
            const CustomTextField(
              label: 'Nom de la structure',
              placeholder: 'Ex: Studio Paris',
            ),
            const SizedBox(height: 12),
            // Custom Dropdown
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TYPE DE STRUCTURE',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 12),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: 'Agence de Casting',
                      dropdownColor: AppColors.surface,
                      icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textBody),
                      items: <String>['Agence de Casting', 'Production de Film', 'Publicité']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: const TextStyle(color: AppColors.white)),
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const CustomTextField(
              label: 'Numéro de téléphone',
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
                // Set the role to agent
                ref.read(userRoleProvider.notifier).setRole(UserRole.agent);
                
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const MainScreen()),
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

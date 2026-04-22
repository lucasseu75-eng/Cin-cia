import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_colors.dart';
import '../widgets/primary_button.dart';
import '../widgets/custom_text_field.dart';
import '../models/user_role.dart';
import '../providers/auth_provider.dart';
import 'main_screen.dart';
import '../utils/page_transitions.dart';

class RegisterAgentScreen extends ConsumerWidget {
  const RegisterAgentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? AppColors.backgroundDark : AppColors.backgroundLight;
    final textPrimary = isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final textSecondary = isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final surfaceColor = isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight;
    final borderColor = isDarkMode ? AppColors.borderDark : AppColors.borderLight;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderColor),
              boxShadow: !isDarkMode ? AppColors.shadowLight : null,
            ),
            child: Icon(Icons.arrow_back_ios_new, size: 16, color: textPrimary),
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
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Recrutez les meilleurs talents.",
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
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontSize: 12,
                    color: textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: borderColor),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: 'Agence de Casting',
                      dropdownColor: surfaceColor,
                      icon: Icon(Icons.keyboard_arrow_down, color: textSecondary),
                      items: <String>['Agence de Casting', 'Production de Film', 'Publicité']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: TextStyle(color: textPrimary)),
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

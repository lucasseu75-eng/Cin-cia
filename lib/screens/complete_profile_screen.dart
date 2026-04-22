import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/primary_button.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  String _selectedAge = '25-35';
  final _ageOptions = ['16-19', '20-24', '25-35', '36-45', '46+'];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? AppColors.backgroundDark : AppColors.backgroundLight;
    final textPrimary = isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final textSecondary = isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final surfaceColor = isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight;
    final borderColor = isDarkMode ? AppColors.borderDark : AppColors.borderLight;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: surfaceColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: borderColor),
                        boxShadow: !isDarkMode ? AppColors.shadowLight : null,
                      ),
                      child: Icon(Icons.arrow_back_ios_new, color: textPrimary, size: 16),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Mon Profil',
                    style: TextStyle(
                      color: textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 40),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),

                    // Avatar + Change photo
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(36),
                              border: Border.all(color: surfaceColor, width: 2),
                              boxShadow: !isDarkMode ? AppColors.shadowLight : null,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(34),
                              child: Image.asset(
                                'assets/images/user_avatar.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'CHANGER LA PHOTO',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // NOM / PRÉNOM
                    _buildLabel('NOM / PRÉNOM', textSecondary),
                    const SizedBox(height: 8),
                    _buildTextField(hintText: 'Lucas', surface: surfaceColor, text: textPrimary, sec: textSecondary, border: borderColor),

                    const SizedBox(height: 20),

                    // NOM DE SCÈNE
                    _buildLabel('NOM DE SCÈNE', textSecondary),
                    const SizedBox(height: 8),
                    _buildTextField(hintText: 'Optionnel', surface: surfaceColor, text: textPrimary, sec: textSecondary, border: borderColor),

                    const SizedBox(height: 20),

                    // TRANCHE D'ÂGE + LOCALISATION side by side
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("TRANCHE D'ÂGE", textSecondary),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                  color: surfaceColor,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: borderColor),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: _selectedAge,
                                    isExpanded: true,
                                    dropdownColor: surfaceColor,
                                    style: TextStyle(color: textPrimary, fontSize: 14),
                                    icon: Icon(Icons.keyboard_arrow_down, color: textSecondary),
                                    items: _ageOptions
                                        .map((age) => DropdownMenuItem(value: age, child: Text(age)))
                                        .toList(),
                                    onChanged: (val) {
                                      if (val != null) setState(() => _selectedAge = val);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel('LOCALISATION', textSecondary),
                              const SizedBox(height: 8),
                              _buildTextField(hintText: 'Paris', surface: surfaceColor, text: textPrimary, sec: textSecondary, border: borderColor),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // LANGUES PARLÉES
                    _buildLabel('LANGUES PARLÉES', textSecondary),
                    const SizedBox(height: 8),
                    _buildTextField(hintText: 'Français, Anglais', surface: surfaceColor, text: textPrimary, sec: textSecondary, border: borderColor),

                    const SizedBox(height: 20),

                    // COMPÉTENCES
                    _buildLabel('COMPÉTENCES (DANSE, CHANT...)', textSecondary),
                    const SizedBox(height: 8),
                    _buildTextField(hintText: 'Théâtre, Danse', surface: surfaceColor, text: textPrimary, sec: textSecondary, border: borderColor),

                    const SizedBox(height: 20),

                    // EXPÉRIENCE / FILMOGRAPHIE
                    _buildLabel('EXPÉRIENCE / FILMOGRAPHIE', textSecondary),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: surfaceColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: borderColor),
                      ),
                      child: TextFormField(
                        maxLines: 5,
                        style: TextStyle(color: textPrimary, fontSize: 14),
                        initialValue:
                            "comédien polyvalent passionné par le cinéma d'auteur et le théâtre classique, 3 ans de formation au conservatoire national.",
                        decoration: InputDecoration(
                          hintText: 'Décrivez votre expérience...',
                          hintStyle: TextStyle(color: textSecondary),
                          contentPadding: const EdgeInsets.all(16),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Submit button
                    PrimaryButton(
                      text: 'COMPLÉTER MON PROFIL',
                      onPressed: () => Navigator.pop(context),
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 11,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.0,
      ),
    );
  }

  Widget _buildTextField({required String hintText, required Color surface, required Color text, required Color sec, required Color border}) {
    return Container(
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: border),
      ),
      child: TextFormField(
        style: TextStyle(color: text, fontSize: 14),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: sec),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}

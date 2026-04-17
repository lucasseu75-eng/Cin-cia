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
    return Scaffold(
      backgroundColor: AppColors.background,
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
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new, color: AppColors.white, size: 16),
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'Mon Profil',
                    style: TextStyle(
                      color: AppColors.white,
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
                              border: Border.all(color: AppColors.surface, width: 2),
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
                    _buildLabel('NOM / PRÉNOM'),
                    const SizedBox(height: 8),
                    _buildTextField(hintText: 'Lucas'),

                    const SizedBox(height: 20),

                    // NOM DE SCÈNE
                    _buildLabel('NOM DE SCÈNE'),
                    const SizedBox(height: 8),
                    _buildTextField(hintText: 'Optionnel'),

                    const SizedBox(height: 20),

                    // TRANCHE D'ÂGE + LOCALISATION side by side
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("TRANCHE D'ÂGE"),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                  color: AppColors.surface,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: _selectedAge,
                                    isExpanded: true,
                                    dropdownColor: AppColors.surface,
                                    style: const TextStyle(color: AppColors.white, fontSize: 14),
                                    icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textBody),
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
                              _buildLabel('LOCALISATION'),
                              const SizedBox(height: 8),
                              _buildTextField(hintText: 'Paris'),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // LANGUES PARLÉES
                    _buildLabel('LANGUES PARLÉES'),
                    const SizedBox(height: 8),
                    _buildTextField(hintText: 'Français, Anglais'),

                    const SizedBox(height: 20),

                    // COMPÉTENCES
                    _buildLabel('COMPÉTENCES (DANSE, CHANT...)'),
                    const SizedBox(height: 8),
                    _buildTextField(hintText: 'Théâtre, Danse'),

                    const SizedBox(height: 20),

                    // EXPÉRIENCE / FILMOGRAPHIE
                    _buildLabel('EXPÉRIENCE / FILMOGRAPHIE'),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextFormField(
                        maxLines: 5,
                        style: const TextStyle(color: AppColors.white, fontSize: 14),
                        initialValue:
                            "comédien polyvalent passionné par le cinéma d'auteur et le théâtre classique, 3 ans de formation au conservatoire national.",
                        decoration: const InputDecoration(
                          hintText: 'Décrivez votre expérience...',
                          hintStyle: TextStyle(color: AppColors.textBody),
                          contentPadding: EdgeInsets.all(16),
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

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.textBody,
        fontSize: 11,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.0,
      ),
    );
  }

  Widget _buildTextField({required String hintText}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextFormField(
        style: const TextStyle(color: AppColors.white, fontSize: 14),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: AppColors.textBody),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}

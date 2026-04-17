import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_colors.dart';
import '../widgets/primary_button.dart';
import '../widgets/custom_text_field.dart';

class CreateOfferScreen extends StatefulWidget {
  const CreateOfferScreen({super.key});

  @override
  State<CreateOfferScreen> createState() => _CreateOfferScreenState();
}

class _CreateOfferScreenState extends State<CreateOfferScreen> {
  final List<TextEditingController> _roleControllers = [TextEditingController()];

  void _addRole() {
    setState(() {
      _roleControllers.add(TextEditingController());
    });
  }

  void _removeRole(int index) {
    if (_roleControllers.length > 1) {
      setState(() {
        _roleControllers[index].dispose();
        _roleControllers.removeAt(index);
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _roleControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        title: const Text('PUBLIER UN CASTING', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, letterSpacing: 1.2)),
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTextField(
              label: 'TITRE DE L\'OFFRE',
              placeholder: 'Ex: Long Métrage "L\'Ombre de Paris"',
            ),
            const SizedBox(height: 24),
            const CustomTextField(
              label: 'DESCRIPTION',
              placeholder: 'Décrivez brièvement le projet...',
            ),
            const SizedBox(height: 24),
            const CustomTextField(
              label: 'LOCALISATION',
              placeholder: 'Ex: Paris, France',
            ),
            const SizedBox(height: 24),
            const CustomTextField(
              label: 'DATE LIMITE',
              placeholder: 'JJ/MM/AAAA',
            ),
            const SizedBox(height: 40),
            
            // Dynamic Roles Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'RÔLES À POURVOIR',
                  style: TextStyle(
                    color: AppColors.textSecondaryDark,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                  ),
                ),
                TextButton.icon(
                  onPressed: _addRole,
                  icon: const Icon(LucideIcons.plusCircle, size: 18, color: AppColors.primary),
                  label: const Text('AJOUTER', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...List.generate(_roleControllers.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceDark,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.borderDark),
                        ),
                        child: TextField(
                          controller: _roleControllers[index],
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Nom du rôle ${index + 1}',
                            hintStyle: const TextStyle(color: AppColors.textSecondaryDark),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    if (_roleControllers.length > 1)
                      IconButton(
                        onPressed: () => _removeRole(index),
                        icon: const Icon(LucideIcons.trash2, color: AppColors.primary, size: 20),
                      ),
                  ],
                ),
              );
            }),
            
            const SizedBox(height: 60),
            PrimaryButton(
              text: 'PUBLIER L\'OFFRE',
              onPressed: () {
                // Submit logic
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

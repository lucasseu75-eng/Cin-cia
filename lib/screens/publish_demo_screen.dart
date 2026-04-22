import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:cinecia/theme/app_colors.dart';
import 'package:cinecia/widgets/primary_button.dart';

class PublishDemoScreen extends StatelessWidget {
  const PublishDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(LucideIcons.chevronLeft, color: isDarkMode ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'PUBLIER UNE DÉMO',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📹 Camera Preview Placeholder
            Container(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: Colors.white10),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                   const Icon(LucideIcons.camera, color: Colors.white24, size: 64),
                   // Bottom Recording Bar
                   Positioned(
                     bottom: 24,
                     child: Row(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         IconButton(
                           icon: const Icon(LucideIcons.image, color: Colors.white),
                           onPressed: () {},
                         ),
                         const SizedBox(width: 40),
                         // Record Button
                         Container(
                           width: 72,
                           height: 72,
                           padding: const EdgeInsets.all(4),
                           decoration: BoxDecoration(
                             shape: BoxShape.circle,
                             border: Border.all(color: Colors.white, width: 4),
                           ),
                           child: Container(
                             decoration: const BoxDecoration(
                               color: AppColors.primary,
                               shape: BoxShape.circle,
                             ),
                           ),
                         ),
                         const SizedBox(width: 40),
                         IconButton(
                           icon: const Icon(LucideIcons.refreshCw, color: Colors.white),
                           onPressed: () {},
                         ),
                       ],
                     ),
                   ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            
            // 📝 Metadata Fields
            _buildFieldLabel('TITRE DE LA SCÈNE', isDarkMode),
            _buildTextField(context, 'Ex: Monologue dramatique...', isDarkMode),
            
            const SizedBox(height: 24),
            _buildFieldLabel('DESCRIPTION', isDarkMode),
            _buildTextField(context, 'Décrivez votre performance en quelques mots...', isDarkMode, maxLines: 3),
            
            const SizedBox(height: 24),
            _buildFieldLabel('TAGS', isDarkMode),
            _buildTextField(context, 'Drame, Comédie, Action...', isDarkMode),
            
            const SizedBox(height: 40),
            PrimaryButton(
              text: 'FINALISER LA PUBLICATION',
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        label,
        style: TextStyle(
          color: isDarkMode ? Colors.white38 : Colors.black45,
          fontSize: 10,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, String hint, bool isDarkMode, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      style: TextStyle(color: isDarkMode ? Colors.white : Colors.black, fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: isDarkMode ? Colors.white24 : Colors.black26),
        filled: true,
        fillColor: isDarkMode ? Colors.white.withOpacity(0.03) : Colors.black.withOpacity(0.03),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_colors.dart';
import '../widgets/primary_button.dart';
import 'login_screen.dart';
import 'register_actor_screen.dart';
import 'register_agent_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
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
                'CINECIA',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 16),
              const Text(
                "L'excellence du casting\ncommence ici.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textBody,
                  fontSize: 18,
                  height: 1.5,
                ),
              ),
              const Spacer(),
              Text(
                'CRÉER UN COMPTE EN TANT QUE',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                text: 'Acteur',
                icon: const Icon(LucideIcons.user),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterActorScreen()),
                  );
                },
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterAgentScreen()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  side: const BorderSide(color: AppColors.surface, width: 2), // Actually mock shows slight dark red border maybe? Using surface or a very dark red. Let's use surface. Wait, prompt says "Bordure rouge" for Agent/Production
                  // Changing to red border:
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
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
                child: RichText(
                  text: const TextSpan(
                    text: 'Déjà un compte ? ',
                    style: TextStyle(color: AppColors.textBody, fontSize: 14),
                    children: [
                      TextSpan(
                        text: 'Se connecter',
                        style: TextStyle(
                          color: AppColors.white,
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
  }
}

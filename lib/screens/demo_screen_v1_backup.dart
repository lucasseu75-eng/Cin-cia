import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:cinecia/theme/app_colors.dart';
import 'package:cinecia/widgets/demo_video_card.dart';
import 'package:cinecia/screens/publish_demo_screen.dart';
import 'package:cinecia/utils/page_transitions.dart';
import 'package:cinecia/widgets/cinecia_header.dart';

class DemoScreen extends StatelessWidget {
  const DemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
          child: Column(
            children: [
              const CineciaHeader(title: 'DÉMO'),
            
            // 🎬 Cinematic Feed
            Expanded(
              child: PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 3,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final demoData = [
                    {
                      'actor': 'Lucas Seu',
                      'desc': 'Monologue dramatique - L\'étranger (Camus)',
                      'tags': ['Drame', 'Casting', 'Classique'],
                      'thumb': 'assets/images/movie_1.png',
                    },
                    {
                      'actor': 'Perez Morel',
                      'desc': 'Scène d\'action - Combat chorégraphié',
                      'tags': ['Action', 'Performance', 'Aventure'],
                      'thumb': 'assets/images/movie_5.png',
                    },
                    {
                      'actor': 'Falcao Junior',
                      'desc': 'Improvisation comique - Scène du restaurant',
                      'tags': ['Comédie', 'Humour', 'Théâtre'],
                      'thumb': 'assets/images/movie_6.png',
                    },
                  ][index];

                  return DemoVideoCard(
                    actorName: demoData['actor'] as String,
                    description: demoData['desc'] as String,
                    tags: List<String>.from(demoData['tags'] as Iterable),
                    videoThumbnail: demoData['thumb'] as String,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ),
      // ➕ Publish Button
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 160.0), 
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              CineciaTransition(page: const PublishDemoScreen()),
            );
          },
          backgroundColor: AppColors.primary,
          elevation: 8,
          shape: const CircleBorder(),
          child: const Icon(
            LucideIcons.plus,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

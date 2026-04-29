import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';
import '../models/demo_model.dart';
import '../utils/page_transitions.dart';
import '../widgets/cinecia_header.dart';
import 'demo_detail_screen.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  bool _isGridView = true;
  String _activeFilter = 'Tout';

  final List<DemoModel> _demos = const [
    DemoModel(
      id: '1',
      actorName: 'Lucas Seu',
      description: 'Monologue dramatique intense basé sur "L\'étranger" d\'Albert Camus.',
      tags: ['Drame', 'Classique'],
      thumbnail: 'assets/images/movie_1.png',
      duration: '02:15',
      performanceTitle: 'L\'Étranger (Monologue)',
      bio: 'Acteur dramatique spécialisé dans le théâtre classique et le cinéma d\'auteur.',
    ),
    DemoModel(
      id: '2',
      actorName: 'Perez Morel',
      description: 'Démonstration de combat chorégraphié et cascades urbaines.',
      tags: ['Action', 'Performance'],
      thumbnail: 'assets/images/movie_5.png',
      duration: '01:45',
      performanceTitle: 'Sequence d\'action urbaine',
      bio: 'Cascadeur et acteur d\'action avec 5 ans d\'expérience en productions internationales.',
    ),
    DemoModel(
      id: '3',
      actorName: 'Falcao Depoh',
      description: 'Scène d\'improvisation comique dans un cadre quotidien.',
      tags: ['Comédie', 'Improvisation'],
      thumbnail: 'assets/images/movie_6.png',
      duration: '03:00',
      performanceTitle: 'Le Client Difficile',
      bio: 'Humoriste et acteur spécialisé dans l\'improvisation et la comédie de situation.',
    ),
    DemoModel(
      id: '4',
      actorName: 'Sarah Koné',
      description: 'Performance émotionnelle sur la perte et la résilience.',
      tags: ['Drame', 'Émotion'],
      thumbnail: 'assets/images/movie_3.png',
      duration: '02:30',
      performanceTitle: 'La Lettre Perdue',
      bio: 'Actrice polyvalente formée au Conservatoire, passionnée par les rôles à forte charge émotionnelle.',
    ),
    DemoModel(
      id: '5',
      actorName: 'Lucas Seu',
      description: 'Monologue dramatique intense basé sur "L\'étranger" d\'Albert Camus.',
      tags: ['Drame', 'Classique'],
      thumbnail: 'assets/images/movie_1.png',
      duration: '02:15',
      performanceTitle: 'L\'Étranger (Monologue)',
      bio: 'Acteur dramatique spécialisé dans le théâtre classique et le cinéma d\'auteur.',
    ),
    DemoModel(
      id: '6',
      actorName: 'Perez Morel',
      description: 'Démonstration de combat chorégraphié et cascades urbaines.',
      tags: ['Action', 'Performance'],
      thumbnail: 'assets/images/movie_5.png',
      duration: '01:45',
      performanceTitle: 'Sequence d\'action urbaine',
      bio: 'Cascadeur et acteur d\'action avec 5 ans d\'expérience en productions internationales.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textPrimary = isDarkMode ? Colors.white : Colors.black;
    final textSecondary = isDarkMode ? Colors.grey[400]! : Colors.grey[700]!;

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
              // 1. Uniform Header
              const CineciaHeader(title: 'DÉMO'),
              
              // 2. Search and Task bar (Compact)
              _buildCompactSearchAndFilters(context, isDarkMode, textPrimary),
              
              Expanded(
                child: _isGridView 
                    ? _buildGridView(context, textPrimary, textSecondary) 
                    : _buildListView(context, textPrimary, textSecondary),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompactSearchAndFilters(BuildContext context, bool isDarkMode, Color textPrimary) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              // 🔍 Search Bar
              Expanded(
                child: Container(
                  height: 42, // Decreased height
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: isDarkMode ? AppColors.surfaceDark.withOpacity(0.6) : Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: isDarkMode ? AppColors.borderDark : Colors.grey[300]!.withOpacity(0.5)),
                  ),
                  child: Row(
                    children: [
                      const Icon(LucideIcons.search, size: 16, color: Colors.grey),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          style: GoogleFonts.plusJakartaSans(fontSize: 13, color: textPrimary),
                          decoration: const InputDecoration(
                            hintText: 'Rechercher un acteur...',
                            hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            filled: true,
                            fillColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // 🔲 List/Grid Toggle
              GestureDetector(
                onTap: () => setState(() => _isGridView = !_isGridView),
                child: Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                    color: isDarkMode ? AppColors.surfaceDark.withOpacity(0.6) : Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: isDarkMode ? AppColors.borderDark : Colors.grey[300]!.withOpacity(0.5)),
                  ),
                  child: Icon(
                    _isGridView ? LucideIcons.list : LucideIcons.layoutGrid, 
                    size: 18, 
                    color: AppColors.primary
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // ⚙️ Filter
              GestureDetector(
                onTap: () {
                  // TODO: Implement filter logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Filtres avancés bientôt disponibles')),
                  );
                },
                child: Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                    color: isDarkMode ? AppColors.surfaceDark.withOpacity(0.6) : Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: isDarkMode ? AppColors.borderDark : Colors.grey[300]!.withOpacity(0.5)),
                  ),
                  child: const Icon(LucideIcons.slidersHorizontal, size: 18, color: AppColors.primary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // 🎯 Horizontal Filters Row (Chips)
          SizedBox(
            height: 32, // More compact
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildFilterChip('Tout'),
                _buildFilterChip('Drame'),
                _buildFilterChip('Comédie'),
                _buildFilterChip('Improvisation'),
                _buildFilterChip('Confirmé'),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildFilterChip(String label) {
    final isActive = _activeFilter == label;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => setState(() => _activeFilter = label),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : (isDarkMode ? AppColors.surfaceDark.withOpacity(0.4) : Colors.grey[100]),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isActive ? AppColors.primary : (isDarkMode ? AppColors.borderDark : Colors.transparent),
            ),
          ),
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              color: isActive ? Colors.white : (isDarkMode ? Colors.white70 : Colors.black54),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGridView(BuildContext context, Color textPrimary, Color textSecondary) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 100),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: _demos.length,
      itemBuilder: (context, index) {
        final demo = _demos[index];
        return _buildGridItem(context, demo, textPrimary, textSecondary);
      },
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildGridItem(BuildContext context, DemoModel demo, Color textPrimary, Color textSecondary) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => Navigator.push(context, CineciaTransition(page: DemoDetailScreen(demo: demo))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: !isDarkMode ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ] : null,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(demo.thumbnail, fit: BoxFit.cover),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          demo.duration,
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const Center(
                      child: Icon(Icons.play_circle_outline, color: Colors.white70, size: 36),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            demo.actorName,
            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold, fontSize: 14, color: textPrimary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '#${demo.tags.first}',
            style: GoogleFonts.plusJakartaSans(color: AppColors.primary, fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildListView(BuildContext context, Color textPrimary, Color textSecondary) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 100),
      itemCount: _demos.length,
      itemBuilder: (context, index) {
        final demo = _demos[index];
        return _buildListItem(context, demo, textPrimary, textSecondary);
      },
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildListItem(BuildContext context, DemoModel demo, Color textPrimary, Color textSecondary) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => Navigator.push(context, CineciaTransition(page: DemoDetailScreen(demo: demo))),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDarkMode ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isDarkMode ? AppColors.borderDark : Colors.grey[100]!),
          boxShadow: [
            if (!isDarkMode)
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(demo.thumbnail, fit: BoxFit.cover),
                    const Center(child: Icon(Icons.play_circle_outline, color: Colors.white70, size: 24)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    demo.actorName,
                    style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold, fontSize: 15, color: textPrimary),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    demo.description,
                    style: GoogleFonts.plusJakartaSans(fontSize: 11, color: textSecondary),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        '#${demo.tags.join(' #')}',
                        style: GoogleFonts.plusJakartaSans(color: AppColors.primary, fontSize: 9, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        demo.duration,
                        style: GoogleFonts.plusJakartaSans(color: textSecondary, fontSize: 9, fontWeight: FontWeight.bold),
                      ),
                    ],
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

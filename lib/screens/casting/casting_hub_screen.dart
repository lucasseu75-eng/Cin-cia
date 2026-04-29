import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/user_role.dart';
import '../../providers/auth_provider.dart';
import '../../theme/app_colors.dart';
import '../../widgets/cinecia_header.dart';
import 'online_agent_view.dart';
import 'online_actor_view.dart';
import 'onsite_agent_view.dart';
import 'onsite_actor_view.dart';

class CastingHubScreen extends ConsumerWidget {
  const CastingHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userRole = ref.watch(userRoleProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
            bottom: false,
            child: Column(
              children: [
                const CineciaHeader(title: 'CASTING'),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: isDarkMode ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1),
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: TabBar(
                    indicatorColor: AppColors.primary,
                    indicatorWeight: 3,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: AppColors.primary,
                    unselectedLabelColor: isDarkMode ? Colors.white54 : Colors.black54,
                    tabs: const [
                      Tab(text: 'En ligne'),
                      Tab(text: 'Sur site'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(), // Prévenir les swipes accidentels
                    children: [
                      userRole == UserRole.actor 
                          ? const OnlineActorView() 
                          : const OnlineAgentView(),
                      userRole == UserRole.actor 
                          ? const OnsiteActorView() 
                          : const OnsiteAgentView(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

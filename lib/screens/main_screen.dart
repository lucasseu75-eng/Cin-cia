import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/glass_nav_bar.dart';
import '../models/user_role.dart';
import '../providers/auth_provider.dart';
import 'messages_screen.dart';
import 'actor_feed_screen.dart';
import 'my_castings_screen.dart';
import 'profile_screen.dart';
import 'agent_home_screen.dart';
import 'my_offers_screen.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final userRole = ref.watch(userRoleProvider);

    final List<Widget> actorScreens = [
      const ActorFeedScreen(),
      const MessagesScreen(),
      const MyCastingsScreen(),
      const ProfileScreen(),
    ];

    final List<Widget> agentScreens = [
      const AgentHomeScreen(),
      const MessagesScreen(), // Contacts
      const MyOffersScreen(), // Casting
      const ProfileScreen(), // Profil
    ];

    final screens = userRole == UserRole.actor ? actorScreens : agentScreens;

    return Scaffold(
      extendBody: true, 
      body: screens[_currentIndex],
      bottomNavigationBar: GlassNavigationBar(
        currentIndex: _currentIndex,
        userRole: userRole,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

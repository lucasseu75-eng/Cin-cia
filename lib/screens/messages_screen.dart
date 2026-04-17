import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_colors.dart';
import 'chat_screen.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, 
            color: isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight, 
            size: 20),
          onPressed: () {
            if (Navigator.canPop(context)) Navigator.pop(context);
          },
        ),
        title: Text(
          'Messages',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: AppColors.primary,
                fontSize: 24,
              ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: !isDarkMode ? AppColors.shadowLight : null,
                border: isDarkMode ? Border.all(color: AppColors.borderDark) : null,
              ),
              child: TextField(
                style: TextStyle(color: colorScheme.onSurface),
                decoration: InputDecoration(
                  prefixIcon: Icon(LucideIcons.search, 
                    color: isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight, 
                    size: 20),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: 'Recherche',
                  hintStyle: TextStyle(
                    color: isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(bottom: 100),
              itemCount: mockChats.length,
              separatorBuilder: (context, index) => Divider(
                color: isDarkMode ? AppColors.borderDark : Colors.black.withOpacity(0.05),
                thickness: 1,
                height: 1,
                indent: 16,
                endIndent: 16,
              ),
              itemBuilder: (context, index) {
                final chat = mockChats[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatScreen(
                          contactName: chat.name,
                          avatarUrl: chat.avatarUrl,
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: Stack(
                      children: [
                        Container(
                          padding: chat.isOnline ? const EdgeInsets.all(2) : EdgeInsets.zero,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: chat.isOnline ? Border.all(color: AppColors.success, width: 2) : null,
                          ),
                          child: CircleAvatar(
                            radius: 24,
                            backgroundImage: AssetImage(chat.avatarUrl),
                          ),
                        ),
                        if (chat.isOnline)
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                color: AppColors.success,
                                shape: BoxShape.circle,
                                border: Border.all(color: colorScheme.surface, width: 2),
                              ),
                            ),
                          ),
                      ],
                    ),
                    title: Text(
                      chat.name,
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        chat.lastMessage,
                        style: TextStyle(
                          color: chat.unreadCount > 0 
                            ? colorScheme.onSurface 
                            : (isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          chat.time,
                          style: TextStyle(
                            color: chat.unreadCount > 0 ? AppColors.primary : (isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        if (chat.unreadCount > 0)
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              chat.unreadCount.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        else
                          const SizedBox(width: 20, height: 20),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ChatThread {
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final String avatarUrl;
  final bool isOnline;

  const ChatThread({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.avatarUrl,
    required this.isOnline,
  });
}

const mockChats = [
  ChatThread(
    name: 'Moussa Wayne',
    lastMessage: 'Je veux manger poulet tchai',
    time: '07:59',
    unreadCount: 3,
    avatarUrl: 'assets/images/istockphoto-500221637-612x612.jpg',
    isOnline: true,
  ),
  ChatThread(
    name: 'Robinson Xavier',
    lastMessage: 'Est sint beatae in quaerant possimus',
    time: '07:59',
    unreadCount: 1,
    avatarUrl: 'assets/images/istockphoto-814423752-612x612.jpg',
    isOnline: false,
  ),
  ChatThread(
    name: 'Soro Béton',
    lastMessage: 'ut eaque rerum ut ?',
    time: '07:59',
    unreadCount: 0,
    avatarUrl: 'assets/images/beautiful-black-woman-with-afro-curls-hairstylesmiling-model-yellow-hoodie-sexy-carefree-female-posi.png',
    isOnline: true,
  ),
  ChatThread(
    name: 'Abib cfa la flèche',
    lastMessage: 'Ok, j\'accepte le contrat !!',
    time: '07:59',
    unreadCount: 0,
    avatarUrl: 'assets/images/istockphoto-500221637-612x612.jpg',
    isOnline: false,
  ),
  ChatThread(
    name: 'Miss click',
    lastMessage: 'j\'ai raté le click',
    time: '07:59',
    unreadCount: 0,
    avatarUrl: 'assets/images/beautiful-black-woman-with-afro-curls-hairstylesmiling-model-yellow-hoodie-sexy-carefree-female-posi.png',
    isOnline: false,
  ),
];

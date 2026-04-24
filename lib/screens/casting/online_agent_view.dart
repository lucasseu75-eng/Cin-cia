import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../theme/app_colors.dart';

class OnlineAgentView extends StatefulWidget {
  const OnlineAgentView({super.key});

  @override
  State<OnlineAgentView> createState() => _OnlineAgentViewState();
}

class _OnlineAgentViewState extends State<OnlineAgentView> {
  String _activeCandidate = "En attente d'acteur...";
  bool _isCallActive = false;
  String _selectedTag = "";

  void _startCall() {
    setState(() {
      _isCallActive = true;
      _activeCandidate = "Thomas Dubois";
      _selectedTag = "";
    });
  }

  void _nextCandidate() {
    setState(() {
      _activeCandidate = "Marie Laurent";
      _selectedTag = "";
    });
  }

  void _endCall() {
    setState(() {
      _isCallActive = false;
      _activeCandidate = "Session terminée";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top section: Square Video Feed
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark ? Colors.black87 : const Color(0xFF1C1C1E),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: _isCallActive ? AppColors.primary : Colors.grey.withOpacity(0.3), width: 2),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (!_isCallActive)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(LucideIcons.videoOff, size: 64, color: Colors.grey.withOpacity(0.5)),
                        const SizedBox(height: 16),
                        Text("Caméra inactive", style: TextStyle(color: Colors.grey.withOpacity(0.8))),
                      ],
                    ),
                  if (_isCallActive)
                    // Mock video layout
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=800&auto=format&fit=crop',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  // Agent self-view picture-in-picture
                  if (_isCallActive)
                    Positioned(
                      bottom: 16,
                      right: 16,
                      child: Container(
                        width: 80,
                        height: 110,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white24),
                          image: const DecorationImage(
                            image: NetworkImage('https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=400&auto=format&fit=crop'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  // Candidate Name overlay
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _isCallActive ? Colors.green : Colors.grey,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(_activeCandidate, style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Action Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (!_isCallActive)
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _startCall,
                      icon: const Icon(LucideIcons.play),
                      label: const Text('Démarrer Session', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                if (_isCallActive) ...[
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      onPressed: _nextCandidate,
                      icon: const Icon(LucideIcons.skipForward),
                      label: const Text('Suivant', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: _endCall,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: Colors.red),
                      ),
                      child: const Text('Terminer', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ]
              ],
            ),
          ),
          
          const SizedBox(height: 24),

          // File d'attente
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('File d\'attente', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 12),
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildQueueItem('Thomas Dubois', 'En cours', Colors.green),
                    _buildQueueItem('Marie Laurent', 'Attente (2m)', Colors.orange),
                    _buildQueueItem('Lucas Martin', 'Attente (12m)', Colors.grey),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 12),

          // Evaluation
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Évaluation', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildTag('Intéressant', Colors.green),
                    _buildTag('À revoir', Colors.orange),
                    _buildTag('Refusé', Colors.red),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Notes sur $_activeCandidate...',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    filled: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text, Color color) {
    bool isSelected = _selectedTag == text;
    return InkWell(
      onTap: () => setState(() => _selectedTag = text),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.2) : Colors.transparent,
          border: Border.all(color: isSelected ? color : Colors.grey),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? color : (Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black87),
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildQueueItem(String name, String status, Color statusColor) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        dense: true,
        leading: CircleAvatar(
          radius: 16,
          backgroundColor: statusColor.withOpacity(0.2),
          child: Icon(LucideIcons.user, size: 16, color: statusColor),
        ),
        title: Text(name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
        subtitle: Text(status, style: TextStyle(fontSize: 11, color: statusColor)),
      ),
    );
  }
}

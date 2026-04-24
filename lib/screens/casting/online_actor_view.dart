import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../theme/app_colors.dart';

class OnlineActorView extends StatefulWidget {
  const OnlineActorView({super.key});

  @override
  State<OnlineActorView> createState() => _OnlineActorViewState();
}

class _OnlineActorViewState extends State<OnlineActorView> {
  // Mock states: 0 = Not joined, 1 = Waiting room, 2 = In call, 3 = Finished
  int _callState = 0;
  bool _micOn = true;
  bool _camOn = true;

  @override
  Widget build(BuildContext context) {
    if (_callState == 0) {
      return _buildConvocation();
    } else if (_callState == 1) {
      return _buildWaitingRoom();
    } else if (_callState == 2) {
      return _buildActiveCall();
    } else {
      return _buildFinished();
    }
  }

  Widget _buildConvocation() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(LucideIcons.calendarClock, size: 64, color: AppColors.primary),
            const SizedBox(height: 24),
            const Text(
              "Convocation au Casting",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Projet : Film \"Les Misérables\"",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(LucideIcons.clock),
                  SizedBox(width: 8),
                  Text("Aujourd'hui à 14h30", style: TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => setState(() => _callState = 1),
                child: const Text("Rejoindre la session", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWaitingRoom() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary, width: 4),
            ),
            child: const Center(
              child: Text("3", style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "Vous êtes en position 3",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "Temps estimé : ~12 minutes",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 48),
          const CircularProgressIndicator(color: AppColors.primary),
          const SizedBox(height: 16),
          const Text("L'agent vous fera entrer quand ce sera votre tour"),
          const SizedBox(height: 48),
          // Bouton mock pour simuler l'entrée de l'agent
          TextButton(
            onPressed: () => setState(() => _callState = 2),
            child: const Text("Simuler: L'agent me fait entrer (Dev)"),
          )
        ],
      ),
    );
  }

  Widget _buildActiveCall() {
    return Stack(
      children: [
        // Actor's main camera view
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
          child: _camOn 
              ? Image.network(
                  'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=800&auto=format&fit=crop',
                  fit: BoxFit.cover,
                )
              : const Center(child: Icon(LucideIcons.cameraOff, size: 64, color: Colors.grey)),
        ),
        
        // Agent's PIP view
        Positioned(
          top: 16,
          right: 16,
          child: Container(
            width: 100,
            height: 140,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white24),
              image: const DecorationImage(
                image: NetworkImage('https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=400&auto=format&fit=crop'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        // Controls
        Positioned(
          bottom: 32,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildControlButton(
                icon: _micOn ? LucideIcons.mic : LucideIcons.micOff,
                color: _micOn ? Colors.white24 : Colors.red,
                onTap: () => setState(() => _micOn = !_micOn),
              ),
              const SizedBox(width: 24),
              _buildControlButton(
                icon: LucideIcons.phoneOff,
                color: Colors.red,
                onTap: () => setState(() => _callState = 3),
                isEndCall: true,
              ),
              const SizedBox(width: 24),
              _buildControlButton(
                icon: _camOn ? LucideIcons.camera : LucideIcons.cameraOff,
                color: _camOn ? Colors.white24 : Colors.red,
                onTap: () => setState(() => _camOn = !_camOn),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildControlButton({required IconData icon, required Color color, required VoidCallback onTap, bool isEndCall = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isEndCall ? 64 : 56,
        height: isEndCall ? 64 : 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Icon(icon, color: Colors.white, size: isEndCall ? 32 : 24),
      ),
    );
  }

  Widget _buildFinished() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(LucideIcons.checkCircle, size: 80, color: Colors.green),
          const SizedBox(height: 24),
          const Text("Casting terminé", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const Text("En attente de réponse", style: TextStyle(color: Colors.grey, fontSize: 16)),
          const SizedBox(height: 48),
          ElevatedButton(
            onPressed: () => setState(() => _callState = 0),
            child: const Text("Retour aux convocations"),
          )
        ],
      ),
    );
  }
}

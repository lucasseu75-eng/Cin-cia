import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../theme/app_colors.dart';

class OnsiteActorView extends StatefulWidget {
  const OnsiteActorView({super.key});

  @override
  State<OnsiteActorView> createState() => _OnsiteActorViewState();
}

class _OnsiteActorViewState extends State<OnsiteActorView> {
  bool _hasArrived = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 24.0, bottom: 120.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Banner Status
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _hasArrived ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _hasArrived ? Colors.green : Colors.orange),
            ),
            child: Row(
              children: [
                Icon(
                  _hasArrived ? LucideIcons.checkCircle : LucideIcons.clock,
                  color: _hasArrived ? Colors.green : Colors.orange,
                  size: 32,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _hasArrived ? "Présence confirmée" : "Passe dans ~30 minutes",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _hasArrived ? Colors.green : Colors.orange,
                        ),
                      ),
                      if (!_hasArrived)
                        const Text(
                          "N'oubliez pas de signaler votre arrivée.",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Details Card
          Card(
            elevation: 0,
            color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const Text("Détails du passage", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  _buildDetailRow(LucideIcons.film, "Projet", "Les Misérables"),
                  const Divider(height: 24),
                  _buildDetailRow(LucideIcons.calendar, "Date", "Aujourd'hui"),
                  const Divider(height: 24),
                  _buildDetailRow(LucideIcons.clock, "Heure prévue", "10h30"),
                  const Divider(height: 24),
                  _buildDetailRow(LucideIcons.listOrdered, "Ordre de passage", "4ème"),
                  const Divider(height: 24),
                  _buildDetailRow(LucideIcons.mapPin, "Lieu", "Studio 5, 12 rue de Paris\n75001 Paris"),
                ],
              ),
            ),
          ),
          const SizedBox(height: 48),

          // Action Button
          if (!_hasArrived)
            ElevatedButton.icon(
              onPressed: () {
                setState(() => _hasArrived = true);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Votre présence a été signalée à l\'agent.')),
                );
              },
              icon: const Icon(LucideIcons.mapPin),
              label: const Text("Je suis arrivé sur place"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            
          if (_hasArrived)
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text(
                    "Présentez ce QR Code à l'accueil",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const Icon(LucideIcons.qrCode, size: 150),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.grey),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
        ),
      ],
    );
  }
}

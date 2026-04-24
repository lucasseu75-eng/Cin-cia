import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../theme/app_colors.dart';

class OnsiteAgentView extends StatefulWidget {
  const OnsiteAgentView({super.key});

  @override
  State<OnsiteAgentView> createState() => _OnsiteAgentViewState();
}

class _OnsiteAgentViewState extends State<OnsiteAgentView> {
  // Mock data
  final List<Map<String, dynamic>> _schedule = [
    {"time": "10:00", "name": "Robinson Toé", "status": "present"},
    {"time": "10:15", "name": "Salam JL", "status": "en_cours"},
    {"time": "10:30", "name": "Lucas Seu", "status": "attente"},
    {"time": "10:45", "name": "Abib Aziz", "status": "absent"},
    {"time": "11:00", "name": "David Soro", "status": "attente"},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header (Casting Info & Stats)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Film: In The Shadow", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(LucideIcons.mapPin, size: 16, color: Colors.grey),
                      SizedBox(width: 4),
                      Text("Insaac, Cocody", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.primary),
                ),
                child: const Column(
                  children: [
                    Text("12 / 45", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.primary)),
                    Text("Passés", style: TextStyle(fontSize: 12, color: AppColors.primary)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text("Planning du jour", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 16),
          
          // Timeline
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 120.0),
              itemCount: _schedule.length,
              itemBuilder: (context, index) {
                final item = _schedule[index];
                return _buildTimelineItem(item, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(Map<String, dynamic> item, int index) {
    final bool isOngoing = item["status"] == "en_cours";
    final bool isPresent = item["status"] == "present" || item["status"] == "en_cours";
    
    Color statusColor;
    switch (item["status"]) {
      case "present": statusColor = Colors.green; break;
      case "en_cours": statusColor = AppColors.primary; break;
      case "absent": statusColor = Colors.red; break;
      default: statusColor = Colors.grey;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: isOngoing ? 4 : 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isOngoing ? const BorderSide(color: AppColors.primary, width: 2) : BorderSide.none,
      ),
      color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: Row(
          children: [
            // Time column
            SizedBox(
              width: 45,
              child: Text(
                item["time"],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: isOngoing ? AppColors.primary : null,
                ),
              ),
            ),
            
            // Timeline line/dot
            Container(
              width: 4,
              height: 40,
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            
            // Actor Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item["name"], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        width: 8, height: 8,
                        decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        item["status"].toString().toUpperCase(),
                        style: TextStyle(fontSize: 10, color: statusColor, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(width: 4),
            
            // Actions
            if (item["status"] == "attente")
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () => setState(() => _schedule[index]["status"] = "present"),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(LucideIcons.checkCircle, color: Colors.green, size: 22),
                    ),
                  ),
                  InkWell(
                    onTap: () => setState(() => _schedule[index]["status"] = "absent"),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(LucideIcons.xCircle, color: Colors.red, size: 22),
                    ),
                  ),
                ],
              ),
            if (item["status"] == "present")
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary, 
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  minimumSize: const Size(72, 40),
                ),
                onPressed: () => setState(() => _schedule[index]["status"] = "en_cours"),
                child: const Text("Lancer", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            if (isOngoing)
              InkWell(
                onTap: () {}, // Show notes dialog
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(LucideIcons.edit3, color: AppColors.primary, size: 20),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

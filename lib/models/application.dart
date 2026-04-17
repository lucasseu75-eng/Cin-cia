import 'actor_profile.dart';

class Application {
  final String id;
  final ActorProfile actor;
  final String castingTitle;
  final String date;
  final String motivation;
  final String targetRole;

  const Application({
    required this.id,
    required this.actor,
    required this.castingTitle,
    required this.date,
    required this.motivation,
    required this.targetRole,
  });
}

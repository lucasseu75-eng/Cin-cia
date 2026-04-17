import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/casting.dart';

final mockCastings = <Casting>[
  const Casting(
    id: '1',
    title: 'Long Métrage : "In the Shadow 75009"',
    type: 'CINÉMA',
    location: 'ABIDJAN, COTE D\'IVOIRE',
    imageUrl: 'assets/images/movie_1.png',
    rating: 4.9,
    reviewsCountText: '1.5K',
    tags: ['CINÉMA', 'DRAME'],
  ),
  const Casting(
    id: '2',
    title: 'Série TV : "Demain nous appartient"',
    type: 'SÉRIE TV',
    location: 'SÈTE, FRANCE',
    imageUrl: 'assets/images/movie_2.jpg',
    rating: 4.8,
    reviewsCountText: '12.3K',
    isUrgent: true,
    tags: ['SÉRIE TV', 'PSYCHOLOGIQUE', 'ANNÉES 50'],
  ),
  const Casting(
    id: '3',
    title: 'Série TV : "Lucas le beau mec"',
    type: 'SÉRIE TV',
    location: 'SÈTE, FRANCE',
    imageUrl: 'assets/images/movie_3.webp',
    rating: 4.8,
    reviewsCountText: '12.3K',
    isUrgent: true,
    tags: ['SÉRIE TV', 'PSYCHOLOGIQUE', 'ANNÉES 50'],
  ),
];

final castingsProvider = Provider<List<Casting>>((ref) {
  return mockCastings;
});

class SelectedFilterNotifier extends Notifier<String> {
  @override
  String build() => 'TOUS';

  void setFilter(String filter) {
    state = filter;
  }
}

final selectedFilterProvider = NotifierProvider<SelectedFilterNotifier, String>(() {
  return SelectedFilterNotifier();
});

final filteredCastingsProvider = Provider<List<Casting>>((ref) {
  final filter = ref.watch(selectedFilterProvider);
  final castings = ref.watch(castingsProvider);
  
  if (filter == 'TOUS') return castings;
  return castings.where((c) => c.type == filter).toList();
});

// Applied castings state
class AppliedCastingsNotifier extends Notifier<List<String>> {
  @override
  List<String> build() => [];

  void apply(String castingId) {
    if (!state.contains(castingId)) {
      state = [...state, castingId];
    }
  }

  bool hasApplied(String castingId) => state.contains(castingId);
}

final appliedCastingsProvider = NotifierProvider<AppliedCastingsNotifier, List<String>>(() {
  return AppliedCastingsNotifier();
});

// lib/data/models/watchlist_model.dart
class WatchlistItem {
  final int movieId;
  final String title;
  final String coverImage;
  final DateTime addedAt;

  WatchlistItem({
    required this.movieId,
    required this.title,
    required this.coverImage,
    required this.addedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'movieId': movieId,
      'title': title,
      'coverImage': coverImage,
      'addedAt': addedAt.toIso8601String(),
    };
  }

  factory WatchlistItem.fromJson(Map<String, dynamic> json) {
    return WatchlistItem(
      movieId: json['movieId'],
      title: json['title'],
      coverImage: json['coverImage'],
      addedAt: DateTime.parse(json['addedAt']),
    );
  }
}

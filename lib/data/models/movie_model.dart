// lib/data/models/movie_model.dart
class Movie {
  final int id;
  final String title;
  final int year;
  final double rating;
  final String? summary;
  final String? description;
  final String? language;
  final List<String> genres;
  final String mediumCoverImage;
  final String largeCoverImage;
  final List<String> screenshots;
  final int runtime;
  final List<CastMember> cast;

  Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.rating,
    this.summary,
    this.description,
    this.language,
    required this.genres,
    required this.mediumCoverImage,
    required this.largeCoverImage,
    required this.screenshots,
    required this.runtime,
    required this.cast,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      year: json['year'],
      rating: json['rating'].toDouble(),
      summary: json['summary'],
      description: json['description_full'],
      language: json['language'],
      genres: List<String>.from(json['genres'] ?? []),
      mediumCoverImage: json['medium_cover_image'] ?? '',
      largeCoverImage: json['large_cover_image'] ?? '',
      screenshots: List<String>.from(
        json['yt_trailer_code'] != null
            ? ['https://img.youtube.com/vi/${json['yt_trailer_code']}/0.jpg']
            : json['images']['screenshots']?.map((s) => s.toString()) ?? [],
      ),
      runtime: json['runtime'] ?? 0,
      cast: (json['cast'] as List? ?? [])
          .map((c) => CastMember.fromJson(c))
          .toList(),
    );
  }
}

class CastMember {
  final String name;
  final String characterName;
  final String? imageUrl;

  CastMember({required this.name, required this.characterName, this.imageUrl});

  factory CastMember.fromJson(Map<String, dynamic> json) {
    return CastMember(
      name: json['name'] ?? '',
      characterName: json['character_name'] ?? '',
      imageUrl: json['url_small_image'],
    );
  }
}

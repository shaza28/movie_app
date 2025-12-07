import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:movie_app/data/models/movie_model.dart';

class MovieRepository {
  static const String _baseUrl = 'https://yts.mx/api/v2/';

  Future<List<Movie>> getLatestMovies() async {
    try {
      final response = await http.get(
        Uri.parse(
          '${_baseUrl}list_movies.json?limit=10&sort_by=year&order_by=desc',
        ),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final movies = data['data']['movies'] as List?;

        if (movies == null || movies.isEmpty) {
          return _getDummyMovies();
        }

        return movies.map((json) => Movie.fromJson(json)).toList();
      } else if (response.statusCode == 429) {
        // Too Many Requests
        return _getDummyMovies();
      }

      return _getDummyMovies();
    } catch (e) {
      print('Error in getLatestMovies: $e');
      return _getDummyMovies();
    }
  }

  Future<List<Movie>> getMoviesByGenre(String genre) async {
    try {
      final response = await http.get(
        Uri.parse('${_baseUrl}list_movies.json?genre=$genre&limit=12'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final movies = data['data']['movies'] as List?;

        if (movies == null || movies.isEmpty) {
          return _getDummyMoviesByGenre(genre);
        }

        return movies.map((json) => Movie.fromJson(json)).toList();
      }

      return _getDummyMoviesByGenre(genre);
    } catch (e) {
      print('Error in getMoviesByGenre($genre): $e');
      return _getDummyMoviesByGenre(genre);
    }
  }

  Future<Movie> getMovieDetails(int movieId) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${_baseUrl}movie_details.json?movie_id=$movieId&with_images=true&with_cast=true',
        ),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['data']['movie'] == null) {
          return _getDummyMovieDetails(movieId);
        }

        return Movie.fromJson(data['data']['movie']);
      }

      return _getDummyMovieDetails(movieId);
    } catch (e) {
      print('Error in getMovieDetails($movieId): $e');
      return _getDummyMovieDetails(movieId);
    }
  }

  Future<List<Movie>> getSimilarMovies(int movieId) async {
    try {
      final response = await http.get(
        Uri.parse('${_baseUrl}movie_suggestions.json?movie_id=$movieId'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final movies = data['data']['movies'] as List?;

        if (movies == null || movies.isEmpty) {
          return _getDummyMovies().take(4).toList();
        }

        return movies.map((json) => Movie.fromJson(json)).take(4).toList();
      }

      return _getDummyMovies().take(4).toList();
    } catch (e) {
      print('Error in getSimilarMovies($movieId): $e');
      return _getDummyMovies().take(4).toList();
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    try {
      if (query.isEmpty) return [];

      final response = await http.get(
        Uri.parse('${_baseUrl}list_movies.json?query_term=$query&limit=20'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final movies = data['data']['movies'] as List?;

        if (movies == null) return [];
        return movies.map((json) => Movie.fromJson(json)).toList();
      }

      return [];
    } catch (e) {
      print('Error in searchMovies($query): $e');
      return [];
    }
  }

  Future<List<String>> getAllGenres() async {
    try {
      return [
        'Action',
        'Adventure',
        'Animation',
        'Comedy',
        'Crime',
        'Documentary',
        'Drama',
        'Family',
        'Fantasy',
        'History',
        'Horror',
        'Music',
        'Mystery',
        'Romance',
        'Science Fiction',
        'TV Movie',
        'Thriller',
        'War',
        'Western',
      ];
    } catch (e) {
      print('Error in getAllGenres: $e');
      return [
        'Action',
        'Adventure',
        'Comedy',
        'Drama',
        'Horror',
        'Romance',
        'Sci-Fi',
        'Thriller',
      ];
    }
  }

  Future<String> getFeaturedMovieImage() async {
    final featuredImages = [
      'https://m.media-amazon.com/images/M/MV5BMDdmMTBiNTYtMDIzNi00NGVlLWIzMDYtZTk3MTQ3NGQxZGEwXkEyXkFqcGdeQXVyMzMwOTU5MDk@._V1_FMjpg_UX1000_.jpg',
      'https://m.media-amazon.com/images/M/MV5BODcwNWE3OTMtMDc3MS00NDFjLWE1OTAtNDU3NjgxODMxY2UyXkEyXkFqcGdeQXVyNTAyODkwOQ@@._V1_FMjpg_UX1000_.jpg',
      'https://m.media-amazon.com/images/M/MV5BYjhiNjBlODctY2ZiOC00YjVlLWFlNzAtNTVhNzM1YjI1NzMxXkEyXkFqcGdeQXVyMjQxNTE1MDA@._V1_FMjpg_UX1000_.jpg',
    ];

    final random = Random();
    return featuredImages[random.nextInt(featuredImages.length)];
  }

  List<Movie> _getDummyMovies() {
    return [
      Movie(
        id: 1,
        title: 'Time is the Enemy',
        year: 2023,
        rating: 7.7,
        summary:
            'In a world where time can be manipulated, a group of rebels fight against a tyrannical regime that controls time itself. As they uncover dark secrets about the nature of reality, they must race against time to save humanity.',
        description:
            'A thrilling sci-fi action film about time manipulation and rebellion.',
        language: 'English',
        genres: ['Action', 'Sci-Fi', 'Thriller'],
        mediumCoverImage:
            'https://images.unsplash.com/photo-1534447677768-be436bb09401?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
        largeCoverImage:
            'https://images.unsplash.com/photo-1534447677768-be436bb09401?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2000&q=80',
        screenshots: [
          'https://images.unsplash.com/photo-1489599809516-9827b6d1cf13?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80',
          'https://images.unsplash.com/photo-1517604931442-7e0c8ed2963c?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80',
          'https://images.unsplash.com/photo-1534796636918-6a8c0be14515?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80',
        ],
        runtime: 128,
        cast: [
          CastMember(
            name: 'Chris Hemsworth',
            characterName: 'Alex Turner',
            imageUrl:
                'https://images.unsplash.com/photo-1568602471122-7832951cc4c5?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
          ),
          CastMember(
            name: 'Zendaya',
            characterName: 'Maya Chen',
            imageUrl:
                'https://images.unsplash.com/photo-1494790108755-2616b612b786?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
          ),
          CastMember(
            name: 'Tom Hardy',
            characterName: 'Victor Kane',
            imageUrl:
                'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
          ),
        ],
      ),
      Movie(
        id: 2,
        title: 'Doctor Strange in the Multiverse of Madness',
        year: 2022,
        rating: 8.5,
        summary:
            'Doctor Strange teams up with a mysterious teenage girl from his dreams who can travel across multiverses, to battle multiple threats, including other-universe versions of himself, which threaten to wipe out millions across the multiverse.',
        description:
            'Marvel Studios\' "Doctor Strange in the Multiverse of Madness" - a thrilling ride through the Multiverse.',
        language: 'English',
        genres: ['Action', 'Fantasy', 'Horror'],
        mediumCoverImage:
            'https://images.unsplash.com/photo-1635805737707-575885ab0820?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
        largeCoverImage:
            'https://images.unsplash.com/photo-1635805737707-575885ab0820?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2000&q=80',
        screenshots: [
          'https://images.unsplash.com/photo-1574375927938-d5a98e8ffe85?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80',
          'https://images.unsplash.com/photo-1560179707-f14e90ef3623?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80',
        ],
        runtime: 126,
        cast: [
          CastMember(
            name: 'Benedict Cumberbatch',
            characterName: 'Doctor Strange',
            imageUrl:
                'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
          ),
          CastMember(
            name: 'Elizabeth Olsen',
            characterName: 'Wanda Maximoff',
            imageUrl:
                'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
          ),
          CastMember(
            name: 'Rachel McAdams',
            characterName: 'Christine Palmer',
            imageUrl:
                'https://images.unsplash.com/photo-1494790108755-2616b612b786?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
          ),
        ],
      ),
      Movie(
        id: 3,
        title: 'Black Widow',
        year: 2021,
        rating: 8.0,
        summary:
            'Natasha Romanoff, also known as Black Widow, confronts the darker parts of her ledger when a dangerous conspiracy with ties to her past arises. Pursued by a force that will stop at nothing to bring her down, Natasha must deal with her history as a spy.',
        description:
            'A film about Natasha Romanoff in her quests between the films Civil War and Infinity War.',
        language: 'English',
        genres: ['Action', 'Adventure', 'Sci-Fi'],
        mediumCoverImage:
            'https://images.unsplash.com/photo-1595769812725-4c6564f7528b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
        largeCoverImage:
            'https://images.unsplash.com/photo-1595769812725-4c6564f7528b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2000&q=80',
        screenshots: [
          'https://images.unsplash.com/photo-1551029506-0807df4e2031?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80',
          'https://images.unsplash.com/photo-1560179707-f14e90ef3623?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80',
        ],
        runtime: 134,
        cast: [
          CastMember(
            name: 'Scarlett Johansson',
            characterName: 'Natasha Romanoff',
            imageUrl:
                'https://images.unsplash.com/photo-1494790108755-2616b612b786?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
          ),
          CastMember(
            name: 'Florence Pugh',
            characterName: 'Yelena Belova',
            imageUrl:
                'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
          ),
          CastMember(
            name: 'David Harbour',
            characterName: 'Alexei Shostakov',
            imageUrl:
                'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
          ),
        ],
      ),
      Movie(
        id: 4,
        title: 'Spider-Man: No Way Home',
        year: 2021,
        rating: 9.2,
        summary:
            'With Spider-Man\'s identity now revealed, Peter asks Doctor Strange for help. When a spell goes wrong, dangerous foes from other worlds start to appear, forcing Peter to discover what it truly means to be Spider-Man.',
        description:
            'Peter Parker\'s secret identity is revealed to the entire world.',
        language: 'English',
        genres: ['Action', 'Adventure', 'Fantasy'],
        mediumCoverImage:
            'https://images.unsplash.com/photo-1635805737707-575885ab0820?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80',
        largeCoverImage:
            'https://images.unsplash.com/photo-1635805737707-575885ab0820?ixlib=rb-4.0.3&auto=format&fit=crop&w=2000&q=80',
        screenshots: [
          'https://images.unsplash.com/photo-1574375927938-d5a98e8ffe85?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80',
          'https://images.unsplash.com/photo-1560179707-f14e90ef3623?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80',
        ],
        runtime: 148,
        cast: [
          CastMember(
            name: 'Tom Holland',
            characterName: 'Peter Parker',
            imageUrl:
                'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
          ),
          CastMember(
            name: 'Zendaya',
            characterName: 'MJ',
            imageUrl:
                'https://images.unsplash.com/photo-1494790108755-2616b612b786?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
          ),
        ],
      ),
    ];
  }

  List<Movie> _getDummyMoviesByGenre(String genre) {
    final allMovies = _getDummyMovies();
    return allMovies.where((movie) => movie.genres.contains(genre)).toList();
  }

  Movie _getDummyMovieDetails(int movieId) {
    final allMovies = _getDummyMovies();
    final movie = allMovies.firstWhere(
      (m) => m.id == movieId,
      orElse: () => allMovies.first,
    );

    return movie;
  }
}

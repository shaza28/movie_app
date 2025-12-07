import 'package:flutter/material.dart';
import '../../data/models/movie_model.dart';
import '../../data/repositories/movie_repository.dart';

class MovieProvider with ChangeNotifier {
  final MovieRepository _repository = MovieRepository();
  List<Movie> _watchlist = [];
  List<Movie> get watchlist => _watchlist;

  Future<void> addToWatchlist(Movie movie) async {
    if (!_watchlist.contains(movie)) {
      _watchlist.add(movie);
      notifyListeners();
    }
  }

  Future<void> removeFromWatchlist(Movie movie) async {
    _watchlist.remove(movie);
    notifyListeners();
  }

  bool isInWatchlist(Movie movie) {
    return _watchlist.any((m) => m.id == movie.id);
  }

  Future<List<Movie>> getLatestMovies() async {
    return await _repository.getLatestMovies();
  }

  Future<Movie> getMovieDetails(int movieId) async {
    return await _repository.getMovieDetails(movieId);
  }

  Future<List<Movie>> getSimilarMovies(int movieId) async {
    return await _repository.getSimilarMovies(movieId);
  }
}

import 'package:flutter/material.dart';
import 'package:movie_app/core/resourses/app_images.dart';
import 'package:movie_app/core/routers.dart';
import 'package:movie_app/feature/home/widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../providers/home_provider.dart';
import '../../../core/models/movie_model.dart';
import '../../movie_details/views/movie_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _carouselController = PageController();
  int _currentCarouselIndex = 0;
  int _currentBottomNavIndex = 0;

  String _currentCategory = 'latest';
  List<Movie> _displayedMovies = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().fetchAllMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        _updateDisplayedMovies(provider);

        return Scaffold(
          extendBodyBehindAppBar: true,
          extendBody: true,
          appBar: AppBar(
            title: Image.asset(
              AppImages.availableNow,
              height: 40,
              fit: BoxFit.contain,
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: _showSearchDialog,
              ),
            ],
          ),
          body: _buildBody(provider),
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: _currentBottomNavIndex,
            onTap: (index) {
              setState(() {
                _currentBottomNavIndex = index;

                if (index == 0) _currentCategory = 'latest';
                if (index == 1) _currentCategory = 'action';
                if (index == 2) _currentCategory = 'Adventure';
                if (index == 3) _currentCategory = 'Animation';
              });
            },
          ),
        );
      },
    );
  }

  void _updateDisplayedMovies(HomeProvider provider) {
    switch (_currentCategory) {
      case 'latest':
        _displayedMovies = provider.latestMovies;
        break;
      case 'action':
        _displayedMovies = provider.actionMovies;
        break;
      case 'drama':
        _displayedMovies = provider.dramaMovies;
        break;
      case 'comedy':
        _displayedMovies = provider.comedyMovies;
        break;
      default:
        _displayedMovies = provider.latestMovies;
    }
  }

  Widget _buildBody(HomeProvider provider) {
    if (provider.isLoading) {
      return _buildLoadingState();
    }

    if (provider.error != null) {
      return _buildErrorState(provider.error!);
    }

    if (provider.latestMovies.isEmpty) {
      return const Center(child: Text('No movies available'));
    }

    final backgroundMovie = provider.latestMovies.isNotEmpty
        ? provider.latestMovies[0]
        : provider.latestMovies[0];

    return Stack(
      children: [
        Positioned.fill(
          child: CachedNetworkImage(
            imageUrl: backgroundMovie.largeCoverImage,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                Container(color: const Color(0xFF282A28)),
            errorWidget: (context, url, error) =>
                Container(color: const Color(0xFF282A28)),
          ),
        ),

        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.8),
                  Colors.black.withOpacity(0.4),
                  Colors.black.withOpacity(0.7),
                ],
                stops: const [0.0, 0.4, 1.0],
              ),
            ),
          ),
        ),

        SingleChildScrollView(
          padding: const EdgeInsets.only(top: kToolbarHeight + 40, bottom: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFeaturedMovieCard(backgroundMovie),
              const SizedBox(height: 32),
              _buildCategoryTitle(),
              const SizedBox(height: 16),
              _buildMoviesGrid(_displayedMovies),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedMovieCard(Movie movie) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rating
          Text(
            movie.rating.toStringAsFixed(1),
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 0.9,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            movie.title.toUpperCase(),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () => _navigateToMovieDetails(movie.id),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF6BD00),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Image.asset(AppImages.watchNow)],
              ),
            ),
          ),

          const SizedBox(height: 16),

          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.3)),
              ),
              child: Text(
                movie.genres.isNotEmpty ? movie.genres.first : 'Action',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTitle() {
    String categoryTitle = '';
    switch (_currentCategory) {
      case 'latest':
        categoryTitle = 'Latest Movies';
        break;
      case 'action':
        categoryTitle = 'Action Movies';
        break;
      case 'adventure':
        categoryTitle = 'adventure Movies';
        break;
      case 'Animation':
        categoryTitle = 'Animation Movies';
        break;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          categoryTitle,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          child: const Row(
            children: [
              Text(
                'See More',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFF6BD00),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 4),
              Icon(
                Icons.arrow_forward,
                size: 16,
                color: Color(0xFFF6BD00), // Yellow
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMoviesGrid(List<Movie> movies) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.7,
      ),
      itemCount: movies.length > 6 ? 6 : movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return GestureDetector(
          onTap: () => _navigateToMovieDetails(movie.id),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  // Movie Poster
                  Positioned.fill(
                    child: CachedNetworkImage(
                      imageUrl: movie.mediumCoverImage,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Container(color: Colors.grey[800]),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[800],
                        child: const Icon(Icons.movie, color: Colors.white),
                      ),
                    ),
                  ),

                  // Gradient Overlay
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Movie Rating
                  Positioned(
                    bottom: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6BD00), // Yellow
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, color: Colors.white, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            movie.rating.toStringAsFixed(1),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: Color(0xFFF6BD00)),
          const SizedBox(height: 16),
          Text('Loading movies...', style: TextStyle(color: Colors.grey[300])),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, color: Colors.red, size: 64),
          const SizedBox(height: 16),
          Text(
            'Error: $error',
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<HomeProvider>().fetchAllMovies();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF6BD00),
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  void _navigateToMovieDetails(int movieId) {
    Navigator.pushNamed(
      context,
      AppRoutes.movieDetails,
      arguments: {'movieId': movieId},
    );
  }

  void _showSearchDialog() async {
    final results = await showSearch(
      context: context,
      delegate: MovieSearchDelegate(context.read<HomeProvider>()),
    );

    if (results != null && results is Movie) {
      _navigateToMovieDetails(results.id);
    }
  }
}

class MovieSearchDelegate extends SearchDelegate {
  final HomeProvider homeProvider;

  MovieSearchDelegate(this.homeProvider);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear, color: Colors.white),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: homeProvider.searchMovies(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFFF6BD00)),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        final movies = snapshot.data ?? [];

        if (movies.isEmpty) {
          return const Center(
            child: Text(
              'No movies found',
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        return Container(
          color: Colors.black,
          child: ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return ListTile(
                tileColor: Colors.black,
                leading: CachedNetworkImage(
                  imageUrl: movie.mediumCoverImage,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  movie.title,
                  style: const TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  '${movie.year} • Rating: ${movie.rating}',
                  style: const TextStyle(color: Colors.grey),
                ),
                onTap: () {
                  close(context, movie);
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(color: Colors.black);
  }
}

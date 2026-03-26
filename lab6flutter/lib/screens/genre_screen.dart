import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../widgets/movie_card.dart';
import '../widgets/search_bar.dart';
import '../widgets/genre_chip_list.dart';

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  String searchQuery = "";
  String selectedSort = "A-Z";

  final Set<String> selectedGenres = {};

  final List<String> genres = [
    "Action",
    "Drama",
    "Comedy",
    "Sci-Fi",
    "Romance"
  ];

  final List<Movie> allMovies = [
    Movie(
      title: "Avengers",
      genre: ["Action", "Sci-Fi"],
      imageUrl:
          "https://th.bing.com/th/id/R.85df614f3b55c6c1aa4ba0254f9f6ead?rik=fw1C7R%2bptd%2b3%2bQ&pid=ImgRaw&r=0",
      rating: 8.5,
    ),
    Movie(
      title: "Titanic",
      genre: ["Drama", "Romance"],
      imageUrl:
          "https://tse2.mm.bing.net/th/id/OIP.6eoXKOg7kzdEqJBTFELMygHaJ5?pid=ImgDet&w=474&h=633&rs=1&o=7&rm=3",
      rating: 8.0,
    ),
    Movie(
      title: "Interstellar",
      genre: ["Sci-Fi", "Drama"],
      imageUrl:
          "https://tse1.mm.bing.net/th/id/OIP.IuuohBMqKkT8LCNUWL4W3QHaJQ?rs=1&pid=ImgDetMain&o=7&rm=3",
      rating: 8.6,
    ),
  ];

  void _clearFilters() {
    setState(() {
      selectedGenres.clear();
      searchQuery = "";
    });
  }

  List<Movie> _sortMovies(List<Movie> movies) {
    final sorted = List<Movie>.from(movies);
    switch (selectedSort) {
      case "A-Z":
        sorted.sort((a, b) => a.title.compareTo(b.title));
        break;
      case "Z-A":
        sorted.sort((a, b) => b.title.compareTo(a.title));
        break;
      case "Rating":
        sorted.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case "Year":
        // Placeholder: no year field yet, keep original order
        break;
    }
    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    List<Movie> visibleMovies = _sortMovies(
      allMovies.where((movie) {
        final matchesSearch =
            movie.title.toLowerCase().contains(searchQuery.toLowerCase());
        final matchesGenre = selectedGenres.isEmpty ||
            movie.genre.any((g) => selectedGenres.contains(g));
        return matchesSearch && matchesGenre;
      }).toList(),
    );

    final bool hasActiveFilters =
        selectedGenres.isNotEmpty || searchQuery.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Find a Movie"),
        actions: [
          // Badge + Clear Filters button
          if (hasActiveFilters)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: TextButton.icon(
                onPressed: _clearFilters,
                icon: const Icon(Icons.filter_alt_off, size: 18),
                label: Text(
                  selectedGenres.isNotEmpty
                      ? "Clear (${selectedGenres.length})"
                      : "Clear",
                ),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
              ),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBarWidget(
              query: searchQuery,
              onChanged: (value) {
                setState(() => searchQuery = value);
              },
            ),
            const SizedBox(height: 10),

            // Genre chips + Badge row
            Row(
              children: [
                Expanded(
                  child: GenreChipList(
                    genres: genres,
                    selectedGenres: selectedGenres,
                    onToggle: (genre) {
                      setState(() {
                        if (selectedGenres.contains(genre)) {
                          selectedGenres.remove(genre);
                        } else {
                          selectedGenres.add(genre);
                        }
                      });
                    },
                  ),
                ),
                // Badge showing number of selected genres
                if (selectedGenres.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "${selectedGenres.length} selected",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 4),

            // Clear filters button (inline, shown below chips)
            if (hasActiveFilters)
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: _clearFilters,
                  icon: const Icon(Icons.clear_all, size: 16),
                  label: const Text("Clear filters"),
                  style: TextButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ),

            const SizedBox(height: 6),

            /// Sort + results count row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${visibleMovies.length} movie(s) found",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.grey),
                ),
                Row(
                  children: [
                    const Text("Sort: "),
                    DropdownButton<String>(
                      value: selectedSort,
                      items: ["A-Z", "Z-A", "Year", "Rating"]
                          .map((s) =>
                              DropdownMenuItem(value: s, child: Text(s)))
                          .toList(),
                      onChanged: (value) {
                        setState(() => selectedSort = value!);
                      },
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 6),

            /// Responsive list: tablet (>= 800px) uses GridView, phone uses ListView
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final bool isTablet = constraints.maxWidth >= 800;
                  if (!isTablet) {
                    return ListView.builder(
                      itemCount: visibleMovies.length,
                      itemBuilder: (_, i) => MovieCard(
                        movie: visibleMovies[i],
                        isTablet: false,
                      ),
                    );
                  } else {
                    return GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 3,
                      children: visibleMovies
                          .map((m) => MovieCard(movie: m, isTablet: true))
                          .toList(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
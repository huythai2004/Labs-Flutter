import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  /// Pass true when rendered in a tablet layout (wide screen)
  final bool isTablet;

  const MovieCard({super.key, required this.movie, this.isTablet = false});

  /// Builds star rating row: filled/half/empty stars + numeric text
  Widget _buildRating(double rating) {
    const int maxStars = 5;
    // Scale 0–10 rating down to 0–5 stars
    final double starScore = rating / 2;
    final int fullStars = starScore.floor();
    final bool hasHalf = (starScore - fullStars) >= 0.5;
    final int emptyStars = maxStars - fullStars - (hasHalf ? 1 : 0);

    return Row(
      children: [
        ...List.generate(
          fullStars,
          (_) => const Icon(Icons.star, color: Colors.amber, size: 16),
        ),
        if (hasHalf)
          const Icon(Icons.star_half, color: Colors.amber, size: 16),
        ...List.generate(
          emptyStars,
          (_) => const Icon(Icons.star_border, color: Colors.amber, size: 16),
        ),
        const SizedBox(width: 6),
        Text(
          rating.toStringAsFixed(1),
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.amber,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Poster sizes: larger on tablet, smaller on phone
    final double imageWidth = isTablet ? 160.0 : 90.0;
    final double imageHeight = imageWidth * 1.5;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Poster
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Image.network(
              movie.imageUrl,
              width: imageWidth,
              height: imageHeight,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: imageWidth,
                height: imageHeight,
                color: Colors.grey.shade200,
                child: const Icon(Icons.broken_image,
                    size: 40, color: Colors.grey),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Info
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    movie.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: isTablet ? 18 : 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // Genres
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: movie.genre
                        .map((g) => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                g,
                                style: TextStyle(
                                  fontSize: isTablet ? 12 : 10,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                ),
                              ),
                            ))
                        .toList(),
                  ),

                  const SizedBox(height: 8),

                  // Star rating + numeric
                  _buildRating(movie.rating),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
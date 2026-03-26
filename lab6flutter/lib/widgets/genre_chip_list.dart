import 'package:flutter/material.dart';

class GenreChipList extends StatelessWidget {
  final List<String> genres;
  final Set<String> selectedGenres;
  final Function(String) onToggle;

  const GenreChipList({
    super.key,
    required this.genres,
    required this.selectedGenres,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: genres.map((genre) {
        return FilterChip(
          label: Text(genre),
          selected: selectedGenres.contains(genre),
          onSelected: (_) => onToggle(genre),
        );
      }).toList(),
    );
  }
}
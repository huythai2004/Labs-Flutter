import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  List<Map<String, dynamic>> _books = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadBooksFromAssets();
  }

  Future<void> _loadBooksFromAssets() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/data/books.json');
      final List<dynamic> decoded = jsonDecode(jsonString);
      setState(() {
        _books = decoded.cast<Map<String, dynamic>>();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Color _genreColor(String genre) {
    switch (genre) {
      case 'Programming':
        return const Color(0xFF6C63FF);
      case 'Software Engineering':
        return const Color(0xFF06B6D4);
      case 'JavaScript':
        return const Color(0xFFF59E0B);
      case 'Computer Science':
        return const Color(0xFF10B981);
      case 'Career':
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF8B5CF6);
    }
  }

  Widget _buildStars(double rating) {
    final full = rating.floor();
    final hasHalf = (rating - full) >= 0.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        if (i < full) {
          return const Icon(Icons.star_rounded, color: Color(0xFFFBBF24), size: 16);
        } else if (i == full && hasHalf) {
          return const Icon(Icons.star_half_rounded, color: Color(0xFFFBBF24), size: 16);
        } else {
          return const Icon(Icons.star_outline_rounded, color: Color(0xFFFBBF24), size: 16);
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 9.1 – Assets JSON'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6C63FF), Color(0xFF3B82F6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Reload',
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              setState(() => _isLoading = true);
              _loadBooksFromAssets();
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error_outline, size: 48, color: Colors.red),
                      const SizedBox(height: 12),
                      Text('Error: $_error',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.red)),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: cs.primaryContainer.withOpacity(0.3),
                        border: Border(
                          bottom: BorderSide(
                              color: cs.primary.withOpacity(0.2), width: 1),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline_rounded,
                              color: cs.primary, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            'Loaded ${_books.length} books from assets/data/books.json',
                            style: TextStyle(
                                color: cs.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _books.length,
                        itemBuilder: (context, index) {
                          final book = _books[index];
                          final genre = book['genre'] as String? ?? '';
                          final color = _genreColor(genre);
                          final rating =
                              (book['rating'] as num?)?.toDouble() ?? 0.0;
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 52,
                                    height: 52,
                                    decoration: BoxDecoration(
                                      color: color.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: color.withOpacity(0.4),
                                          width: 1.5),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${index + 1}',
                                        style: TextStyle(
                                            color: color,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          book['title'] ?? '',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          book['author'] ?? '',
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 13),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 3),
                                              decoration: BoxDecoration(
                                                color:
                                                    color.withOpacity(0.15),
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                border: Border.all(
                                                    color: color
                                                        .withOpacity(0.4)),
                                              ),
                                              child: Text(genre,
                                                  style: TextStyle(
                                                      color: color,
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              '${book['year']}',
                                              style: const TextStyle(
                                                  color: Colors.white54,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        Row(
                                          children: [
                                            _buildStars(rating),
                                            const SizedBox(width: 6),
                                            Text(
                                              rating.toStringAsFixed(1),
                                              style: const TextStyle(
                                                  color: Color(0xFFFBBF24),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}

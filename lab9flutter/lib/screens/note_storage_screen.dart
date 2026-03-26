import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class NoteStorageScreen extends StatefulWidget {
  const NoteStorageScreen({super.key});

  @override
  State<NoteStorageScreen> createState() => _NoteStorageScreenState();
}

class _NoteStorageScreenState extends State<NoteStorageScreen> {
  static const String _fileName = 'notes.json';

  List<Map<String, dynamic>> _notes = [];
  bool _isLoading = true;
  bool _isSaving = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_fileName');
  }

  Future<void> _loadData() async {
    try {
      final file = await _getLocalFile();
      if (await file.exists()) {
        final contents = await file.readAsString();
        final List<dynamic> decoded = jsonDecode(contents);
        setState(() {
          _notes = decoded.cast<Map<String, dynamic>>();
          _isLoading = false;
        });
      } else {
        await file.writeAsString(jsonEncode([]));
        setState(() => _isLoading = false);
      }
    } catch (e) {
      setState(() => _isLoading = false);
      _showSnackBar('Failed to load data: $e', isError: true);
    }
  }

  Future<void> _saveData() async {
    setState(() => _isSaving = true);
    try {
      final file = await _getLocalFile();
      await file.writeAsString(jsonEncode(_notes));
      _showSnackBar('Data saved successfully!');
    } catch (e) {
      _showSnackBar('Failed to save: $e', isError: true);
    } finally {
      setState(() => _isSaving = false);
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
            isError ? Colors.red.shade700 : const Color(0xFF06B6D4),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(12),
      ),
    );
  }

  void _addNote() {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();
    if (title.isEmpty) {
      _showSnackBar('Please enter a title.', isError: true);
      return;
    }
    setState(() {
      _notes.insert(0, {
        'id': DateTime.now().millisecondsSinceEpoch,
        'title': title,
        'content': content,
        'createdAt': DateTime.now().toIso8601String(),
      });
    });
    _titleController.clear();
    _contentController.clear();
    _showSnackBar('Note added. Press "Save" to persist.');
  }

  void _deleteNote(int index) {
    setState(() => _notes.removeAt(index));
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 9.2 – Device Storage'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF06B6D4), Color(0xFF0891B2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          _isSaving
              ? const Padding(
                  padding: EdgeInsets.all(14),
                  child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white)),
                )
              : IconButton(
                  tooltip: 'Save to device',
                  icon: const Icon(Icons.save_rounded),
                  onPressed: _saveData,
                ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerHighest.withOpacity(0.4),
                    border: Border(
                      bottom: BorderSide(
                          color: cs.primary.withOpacity(0.2), width: 1),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Add a Note',
                          style: TextStyle(
                              color: cs.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          hintText: 'Title',
                          fillColor: cs.surfaceContainerHighest,
                          prefixIcon: const Icon(Icons.title_rounded),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _contentController,
                        maxLines: 2,
                        decoration: InputDecoration(
                          hintText: 'Content (optional)',
                          fillColor: cs.surfaceContainerHighest,
                          prefixIcon: const Icon(Icons.notes_rounded),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _addNote,
                              icon: const Icon(Icons.add_rounded),
                              label: const Text('Add Note'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF06B6D4),
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _isSaving ? null : _saveData,
                              icon: const Icon(Icons.save_rounded),
                              label: const Text('Save to File'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0891B2),
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  child: Row(
                    children: [
                      Icon(Icons.storage_rounded,
                          size: 16, color: cs.primary),
                      const SizedBox(width: 6),
                      Text(
                        '${_notes.length} note${_notes.length != 1 ? 's' : ''} stored in notes.json',
                        style: TextStyle(
                            color: cs.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 13),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: _notes.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.note_add_rounded,
                                  size: 64,
                                  color: cs.primary.withOpacity(0.3)),
                              const SizedBox(height: 12),
                              Text('No notes yet. Add one above!',
                                  style: TextStyle(
                                      color: Colors.white54, fontSize: 15)),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _notes.length,
                          itemBuilder: (context, index) {
                            final note = _notes[index];
                            final rawDate = note['createdAt'] as String? ?? '';
                            String dateStr = '';
                            if (rawDate.isNotEmpty) {
                              try {
                                final dt = DateTime.parse(rawDate).toLocal();
                                dateStr =
                                    '${dt.day}/${dt.month}/${dt.year}  ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
                              } catch (_) {}
                            }
                            return Card(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                leading: CircleAvatar(
                                  backgroundColor:
                                      const Color(0xFF06B6D4).withOpacity(0.15),
                                  child: const Icon(Icons.sticky_note_2_rounded,
                                      color: Color(0xFF06B6D4)),
                                ),
                                title: Text(
                                  note['title'] ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if ((note['content'] as String?)
                                            ?.isNotEmpty ==
                                        true)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 4),
                                        child: Text(
                                          note['content'],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 13),
                                        ),
                                      ),
                                    if (dateStr.isNotEmpty)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 4),
                                        child: Text(dateStr,
                                            style: const TextStyle(
                                                color: Colors.white38,
                                                fontSize: 11)),
                                      ),
                                  ],
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete_outline_rounded,
                                      color: Colors.redAccent),
                                  onPressed: () => _deleteNote(index),
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

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../models/student.dart';
import '../widgets/student_card.dart';
import '../widgets/student_form_dialog.dart';

class StudentCrudScreen extends StatefulWidget {
  const StudentCrudScreen({super.key});

  @override
  State<StudentCrudScreen> createState() => _StudentCrudScreenState();
}

class _StudentCrudScreenState extends State<StudentCrudScreen> {
  static const String _fileName = 'students.json';

  List<Student> _all = [];
  List<Student> _filtered = [];
  bool _isLoading = true;
  int _nextId = 1;

  final TextEditingController _searchController = TextEditingController();

  Future<File> _getFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$_fileName');
  }

  Future<void> _loadData() async {
    try {
      final file = await _getFile();
      if (await file.exists()) {
        final contents = await file.readAsString();
        final List<dynamic> decoded = jsonDecode(contents);
        final students = decoded
            .map((e) => Student.fromJson(e as Map<String, dynamic>))
            .toList();
        setState(() {
          _all = students;
          _filtered = List.from(_all);
          _nextId = _all.isEmpty
              ? 1
              : _all.map((s) => s.id).reduce((a, b) => a > b ? a : b) + 1;
          _isLoading = false;
        });
      } else {
        _all = _seedData();
        _nextId = _all.length + 1;
        _filtered = List.from(_all);
        await _saveData();
        setState(() => _isLoading = false);
      }
    } catch (e) {
      setState(() => _isLoading = false);
      _snack('Load error: $e', isError: true);
    }
  }

  Future<void> _saveData() async {
    try {
      final file = await _getFile();
      await file.writeAsString(
          jsonEncode(_all.map((s) => s.toJson()).toList()));
    } catch (e) {
      _snack('Save error: $e', isError: true);
    }
  }

  List<Student> _seedData() => [
        Student(id: 1, name: 'Alice Nguyen', major: 'Computer Science', gpa: 3.8),
        Student(id: 2, name: 'Bob Tran', major: 'Information Technology', gpa: 3.5),
        Student(id: 3, name: 'Carol Le', major: 'Software Engineering', gpa: 3.9),
        Student(id: 4, name: 'David Pham', major: 'Data Science', gpa: 3.2),
        Student(id: 5, name: 'Eva Ho', major: 'Computer Science', gpa: 3.7),
      ];

  void _onSearch(String query) {
    final q = query.toLowerCase();
    setState(() {
      _filtered = _all
          .where((s) =>
              s.name.toLowerCase().contains(q) ||
              s.major.toLowerCase().contains(q))
          .toList();
    });
  }

  Future<void> _addStudent(Student s) async {
    setState(() => _all.insert(0, s));
    _onSearch(_searchController.text);
    await _saveData();
    _snack('Student added & saved.');
  }

  Future<void> _editStudent(Student updated) async {
    final idx = _all.indexWhere((s) => s.id == updated.id);
    if (idx != -1) {
      setState(() => _all[idx] = updated);
      _onSearch(_searchController.text);
      await _saveData();
      _snack('Student updated & saved.');
    }
  }

  Future<void> _deleteStudent(Student s) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Student'),
        content: Text('Remove "${s.name}" from the database?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Delete',
                  style: TextStyle(color: Colors.redAccent))),
        ],
      ),
    );
    if (confirmed == true) {
      setState(() => _all.removeWhere((x) => x.id == s.id));
      _onSearch(_searchController.text);
      await _saveData();
      _snack('🗑  Student deleted.');
    }
  }

  void _openDialog({Student? existing}) {
    showDialog(
      context: context,
      builder: (_) => StudentFormDialog(
        existing: existing,
        nextId: _nextId,
        onSubmit: (s) => existing == null ? _addStudent(s) : _editStudent(s),
      ),
    );
  }

  void _snack(String msg, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor:
          isError ? Colors.red.shade700 : const Color(0xFF8B5CF6),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(12),
    ));
  }

  @override
  void initState() {
    super.initState();
    _loadData();
    _searchController.addListener(() => _onSearch(_searchController.text));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 9.3 – JSON CRUD'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF8B5CF6), Color(0xFFD946EF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: Chip(
                label: Text('${_all.length} records',
                    style: const TextStyle(fontSize: 11)),
                backgroundColor: Colors.white.withOpacity(0.15),
                labelStyle: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _isLoading ? null : _openDialog,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add Student'),
        backgroundColor: const Color(0xFF8B5CF6),
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search by name or major…',
                      fillColor: cs.surfaceContainerHighest,
                      prefixIcon: const Icon(Icons.search_rounded),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear_rounded),
                              onPressed: () {
                                _searchController.clear();
                                _onSearch('');
                              },
                            )
                          : null,
                    ),
                  ),
                ),

                if (_searchController.text.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                    child: Row(
                      children: [
                        Icon(Icons.filter_list_rounded,
                            size: 15, color: cs.primary),
                        const SizedBox(width: 6),
                        Text(
                          '${_filtered.length} result${_filtered.length != 1 ? 's' : ''} found',
                          style: TextStyle(
                              color: cs.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),

                Expanded(
                  child: _filtered.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.person_search_rounded,
                                  size: 64,
                                  color: cs.primary.withOpacity(0.3)),
                              const SizedBox(height: 12),
                              Text(
                                _searchController.text.isEmpty
                                    ? 'No students yet.'
                                    : 'No match found.',
                                style: const TextStyle(
                                    color: Colors.white54, fontSize: 15),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding:
                              const EdgeInsets.fromLTRB(16, 0, 16, 90),
                          itemCount: _filtered.length,
                          itemBuilder: (context, index) {
                            final s = _filtered[index];
                            return StudentCard(
                              student: s,
                              onEdit: () => _openDialog(existing: s),
                              onDelete: () => _deleteStudent(s),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}

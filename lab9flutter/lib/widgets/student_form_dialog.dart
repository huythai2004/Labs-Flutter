import 'package:flutter/material.dart';
import '../models/student.dart';

class StudentFormDialog extends StatefulWidget {
  final Student? existing;
  final int nextId;
  final void Function(Student student) onSubmit;

  const StudentFormDialog({
    super.key,
    this.existing,
    required this.nextId,
    required this.onSubmit,
  });

  @override
  State<StudentFormDialog> createState() => _StudentFormDialogState();
}

class _StudentFormDialogState extends State<StudentFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _majorCtrl;
  late final TextEditingController _gpaCtrl;

  bool get _isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.existing?.name ?? '');
    _majorCtrl = TextEditingController(text: widget.existing?.major ?? '');
    _gpaCtrl = TextEditingController(
      text: widget.existing != null ? widget.existing!.gpa.toString() : '',
    );
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _majorCtrl.dispose();
    _gpaCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final student = Student(
        id: _isEdit ? widget.existing!.id : widget.nextId,
        name: _nameCtrl.text.trim(),
        major: _majorCtrl.text.trim(),
        gpa: double.parse(_gpaCtrl.text.trim()),
      );
      Navigator.pop(context);
      widget.onSubmit(student);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isEdit ? 'Edit Student' : 'Add Student'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                prefixIcon: Icon(Icons.person_rounded),
              ),
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _majorCtrl,
              decoration: const InputDecoration(
                labelText: 'Major',
                prefixIcon: Icon(Icons.school_rounded),
              ),
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _gpaCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'GPA (0.0 – 4.0)',
                prefixIcon: Icon(Icons.grade_rounded),
              ),
              validator: (v) {
                final parsed = double.tryParse(v ?? '');
                if (parsed == null || parsed < 0 || parsed > 4) {
                  return 'Enter a valid GPA (0.0–4.0)';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                _isEdit ? const Color(0xFF8B5CF6) : const Color(0xFF10B981),
            foregroundColor: Colors.white,
          ),
          onPressed: _submit,
          child: Text(_isEdit ? 'Update' : 'Add'),
        ),
      ],
    );
  }
}

class Student {
  final int id;
  String name;
  String major;
  double gpa;

  Student({
    required this.id,
    required this.name,
    required this.major,
    required this.gpa,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json['id'] as int,
        name: json['name'] as String,
        major: json['major'] as String,
        gpa: (json['gpa'] as num).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'major': major,
        'gpa': gpa,
      };
}

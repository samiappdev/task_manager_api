class Task {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final bool isCompleted;

  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.isCompleted,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    DateTime parsedDate;

    try {
      final rawDate = json['createdAt'];

      if (rawDate is String && DateTime.tryParse(rawDate) != null) {
        parsedDate = DateTime.parse(rawDate);
      } else if (rawDate is int) {
        parsedDate = DateTime.fromMillisecondsSinceEpoch(rawDate * 1000);
      } else if (rawDate is String && int.tryParse(rawDate) != null) {
        parsedDate = DateTime.fromMillisecondsSinceEpoch(
          int.parse(rawDate) * 1000,
        );
      } else {
        parsedDate = DateTime.now();
      }
    } catch (_) {
      parsedDate = DateTime.now();
    }

    return Task(
      id: json['id'].toString(),
      title: json['title'] as String? ?? 'Untitled',
      description: json['description'] as String? ?? '',
      createdAt: parsedDate,
      isCompleted: json['isCompleted'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }

  Task copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  String toString() {
    return 'Task(id: $id, title: $title, createdAt: $createdAt, isCompleted: $isCompleted)';
  }
}

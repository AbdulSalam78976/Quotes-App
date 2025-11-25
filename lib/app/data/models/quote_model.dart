class Quote {
  const Quote({
    required this.id,
    required this.content,
    required this.author,
    required this.category,
  });

  final String id;
  final String content;
  final String author;
  final String category;

  factory Quote.fromJson(Map<String, dynamic> json) {
    final tags = (json['tags'] as List<dynamic>? ?? []).cast<String>();
    return Quote(
      id: json['_id'] as String? ?? '',
      content: json['content'] as String? ?? '',
      author: json['author'] as String? ?? 'Unknown',
      category: tags.isNotEmpty ? tags.first : 'General',
    );
  }

  Quote copyWith({
    String? id,
    String? content,
    String? author,
    String? category,
  }) {
    return Quote(
      id: id ?? this.id,
      content: content ?? this.content,
      author: author ?? this.author,
      category: category ?? this.category,
    );
  }
}

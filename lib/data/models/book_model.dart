class Book {
  final int id;
  final String title;
  final String author;
  final String genre;
  final String description;
  final String isbn;
  final String image;
  final String publisher;
  final String published;
  final bool isFavorite;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.genre,
    required this.description,
    required this.isbn,
    required this.image,
    required this.publisher,
    required this.published,
    this.isFavorite = false,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Unknown',
      author: json['author'] ?? 'Unknown',
      genre: json['genre'] ?? '',
      description: json['description'] ?? '',
      isbn: json['isbn'] ?? '',
      image: json['image'] ?? '',
      publisher: json['publisher'] ?? '',
      published: json['published'] ?? '',
    );
  }

  Book copyWith({bool? isFavorite}) {
    return Book(
      id: id,
      title: title,
      author: author,
      genre: genre,
      description: description,
      isbn: isbn,
      image: image,
      publisher: publisher,
      published: published,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

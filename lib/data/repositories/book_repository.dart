import '../models/book_model.dart';

abstract class BookRepository {
  Future<List<Book>> getBooks();
}

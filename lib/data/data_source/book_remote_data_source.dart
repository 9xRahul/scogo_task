import 'package:scogo_task/data/models/book_model.dart';

abstract class BookRemoteDataSource {
  Future<List<Book>> fetchBooks();
  
}

import 'package:scogo_task/data/data_source/book_remote_data_source.dart';

import '../models/book_model.dart';
import 'book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource remoteDataSource;

  BookRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Book>> getBooks() {
    return remoteDataSource.fetchBooks();
  }
  
}

part of 'book_list_bloc.dart';

sealed class BookListState extends Equatable {
  const BookListState();

  @override
  List<Object> get props => [];
}

class BookListLoading extends BookListState {}

class BookListLoaded extends BookListState {
  final List<Book> books;
  const BookListLoaded(this.books);

  @override
  List<Object> get props => [books];
}

class BookListError extends BookListState {
  final String message;
  const BookListError(this.message);

  @override
  List<Object> get props => [message];
}

part of 'book_list_bloc.dart';

sealed class BookListEvent extends Equatable {
  const BookListEvent();

  @override
  List<Object> get props => [];
}

class FetchBooks extends BookListEvent {}

class UpdateBookFavorite extends BookListEvent {
  final int bookId;
  const UpdateBookFavorite(this.bookId);
}


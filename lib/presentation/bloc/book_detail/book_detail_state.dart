part of 'book_detail_bloc.dart';

sealed class BookDetailState extends Equatable {
  const BookDetailState();

  @override
  List<Object> get props => [];
}

class BookDetailLoading extends BookDetailState {}

class BookDetailLoaded extends BookDetailState {
  final Book book;
  const BookDetailLoaded(this.book);
}

class BookDetailError extends BookDetailState {
  final String message;
  const BookDetailError(this.message);
}

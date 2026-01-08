part of 'book_detail_bloc.dart';

sealed class BookDetailEvent extends Equatable {
  const BookDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadBookDetail extends BookDetailEvent {
  final Book book;
  const LoadBookDetail(this.book);
}



import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:scogo_task/data/models/book_model.dart';
import 'package:scogo_task/data/repositories/book_repository.dart';

part 'book_list_event.dart';
part 'book_list_state.dart';

class BookListBloc extends Bloc<BookListEvent, BookListState> {
  final BookRepository repository;

  BookListBloc(this.repository) : super(BookListLoading()) {
    on<FetchBooks>(_onFetchBooks);
    on<UpdateBookFavorite>(_onUpdateFavorite);

  }

  Future<void> _onFetchBooks(
    FetchBooks event,
    Emitter<BookListState> emit,
  ) async {
    if (state is BookListLoaded) return; // avoid duplicate call

    emit(BookListLoading());
    try {
      final books = await repository.getBooks();
      emit(BookListLoaded(books));
    } catch (e) {
      emit(BookListError('Something went wrong'));
    }
  }

  void _onUpdateFavorite(
    UpdateBookFavorite event,
    Emitter<BookListState> emit,
  ) {
    if (state is! BookListLoaded) return;

    final currentState = state as BookListLoaded;

    final updatedBooks = currentState.books.map((book) {
      if (book.id == event.bookId) {
        final updatedBook = book.copyWith(isFavorite: !book.isFavorite);

        debugPrint(
          'Updated book id=${book.id}, '
          'isFavorite=${updatedBook.isFavorite}',
        );

        return updatedBook;
      }

      return book;
    }).toList();

    emit(BookListLoaded(updatedBooks));
  }
  
}

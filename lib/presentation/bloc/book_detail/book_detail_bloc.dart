import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:scogo_task/data/models/book_model.dart';

part 'book_detail_event.dart';
part 'book_detail_state.dart';

class BookDetailBloc extends Bloc<BookDetailEvent, BookDetailState> {
  BookDetailBloc(Book book) : super(BookDetailLoading()) {
    on<LoadBookDetail>((event, emit) {
      emit(BookDetailLoaded(event.book));
    });
  }
}

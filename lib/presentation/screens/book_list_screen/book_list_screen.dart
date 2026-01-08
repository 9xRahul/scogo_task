import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scogo_task/presentation/bloc/book_list/book_list_bloc.dart';
import 'package:scogo_task/presentation/widgets/book_list_item.dart';

class BookListScreen extends StatelessWidget {
  const BookListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Explorer'), centerTitle: true),
      body: BlocBuilder<BookListBloc, BookListState>(
        builder: (context, state) {
          //loding state sows here
          if (state is BookListLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // if there is any error this will load
          if (state is BookListError) {
            return Center(
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  Text(state.message, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      context.read<BookListBloc>().add(FetchBooks());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          ///  this is the Success state shows only if loaded without any error
          if (state is BookListLoaded) {
            //if booklist is empty but loaded without error
            if (state.books.isEmpty) {
              return const Center(
                child: Text(
                  'No books available',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }

            //all books fetched from the api
            return RefreshIndicator(
              onRefresh: () async {
                context.read<BookListBloc>().add(FetchBooks());
              },
              child: ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: state.books.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return BookListItem(book: state.books[index]);
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

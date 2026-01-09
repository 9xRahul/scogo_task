import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scogo_task/data/models/book_model.dart';
import 'package:scogo_task/presentation/bloc/book_list/book_list_bloc.dart';

class BookDetailScreen extends StatelessWidget {
  //getting the book id because we are maintaining a single book list
  final int bookId;

  const BookDetailScreen({super.key, required this.bookId});

  @override
  Widget build(BuildContext context) {
    // fetching the state from the booklist block
    final state = context.read<BookListBloc>().state;

    // this  shows when book list is loading
    if (state is! BookListLoaded) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    //fetching the current selected book from the book list
    final Book book = state.books.firstWhere((b) => b.id == bookId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Details'),

        // here the rebuild of the fav icon happens we doing the fav change the main book list
        // only this icon rebuilds when the user toggles all other widgets are static
        actions: [
          BlocSelector<BookListBloc, BookListState, bool>(
            selector: (state) {
              if (state is BookListLoaded) {
                return state.books.firstWhere((b) => b.id == bookId).isFavorite;
              }
              return false;
            },
            builder: (context, isFavorite) {
              return IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () {
                  context.read<BookListBloc>().add(UpdateBookFavorite(bookId));
                },
              );
            },
          ),
        ],
      ),

      /// BODY BUILT ONCE (NO REBUILD ON TOGGLE)
      body: SingleChildScrollView(
        padding: const .all(16),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            /// Book Image
            Center(
              child: Image.network(
                book.image,
                height: 220,
                errorBuilder: (_, _, _) => Container(
                  height: 220,
                  color: Colors.grey.shade300,
                  child: Image(image: AssetImage('assets/images/noimage.jpg')),
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// Title
            Text(
              book.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            /// Author
            Text(
              'by ${book.author}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),

            const SizedBox(height: 16),

            infoRow('Genre', book.genre),
            infoRow('Publisher', book.publisher),
            infoRow('Published', book.published),
            infoRow('ISBN', book.isbn),

            const SizedBox(height: 16),

            const Text(
              'Description',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(book.description, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget infoRow(String label, String value) {
    return Padding(
      padding: const .only(bottom: 8),
      child: Row(
        crossAxisAlignment: .start,
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

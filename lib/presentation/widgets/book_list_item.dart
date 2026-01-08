import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scogo_task/presentation/bloc/book_list/book_list_bloc.dart';
import 'package:scogo_task/presentation/screens/book_detail_screen/book_detail_screen.dart';
import '../../data/models/book_model.dart';
import '../bloc/book_detail/book_detail_bloc.dart';

class BookListItem extends StatelessWidget {
  final Book book;

  const BookListItem({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    print(book.image);
    return InkWell(
      onTap: () {
        //navigates to the details page id is passed using that id detail is fethced from the Booklist
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => BookDetailBloc(book),
              child: BookDetailScreen(bookId: book.id),
            ),
          ),
        );
      },
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const .all(12),
          child: Row(
            children: [
              /// fetches image if its availabe else it will show an asset image
              ClipRRect(
                borderRadius: .circular(6),
                child: Image.network(
                  book.image,
                  width: 60,
                  height: 90,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 60,
                    height: 90,
                    color: Colors.grey.shade300,
                    child: Image(
                      image: AssetImage('assets/images/noimage.jpg'),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              /// Book Information is showing here
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      book.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      book.author,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),

              /// Favorite Indicator toggles the favourite from the book list screen at it reflects in bookdetails screen also
              if (book.isFavorite)
                InkWell(
                  onTap: () {
                    context.read<BookListBloc>().add(
                      UpdateBookFavorite(book.id),
                    );
                  },
                  child: const Icon(Icons.favorite, color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

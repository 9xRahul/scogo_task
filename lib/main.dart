import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scogo_task/data/data_source/book_remote_data_source_impl.dart';
import 'package:scogo_task/data/repositories/book_repository.dart';
import 'package:scogo_task/data/repositories/book_repository_impl.dart';
import 'package:scogo_task/presentation/bloc/book_list/book_list_bloc.dart';
import 'package:scogo_task/presentation/screens/book_list_screen/book_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final repository = BookRepositoryImpl(BookRemoteDataSourceImpl());

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<BookRepository>(
          create: (_) => BookRepositoryImpl(BookRemoteDataSourceImpl()),
        ),

      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<BookListBloc>(
            create: (context) =>
                BookListBloc(context.read<BookRepository>())..add(FetchBooks()),
          ),
          
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: .fromSeed(seedColor: Colors.deepPurple),
          ),
          home: const BookListScreen(),
        ),
      ),
    );
  }
}

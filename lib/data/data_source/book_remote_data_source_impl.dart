import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:scogo_task/data/data_source/book_remote_data_source.dart';
import 'package:scogo_task/data/models/book_model.dart';

class BookRemoteDataSourceImpl implements BookRemoteDataSource {
  static const _url = 'https://fakerapi.it/api/v2/books?_quantity=10';

  @override
  Future<List<Book>> fetchBooks() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode != 200) {
      throw Exception('Failed to load books');
    }

    final decoded = json.decode(response.body);
    final List list = decoded['data'];

    return list.map((e) => Book.fromJson(e)).toList();
  }
}

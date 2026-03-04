import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'data/datasources/product_remote_datasource.dart';
import 'data/repositories/product_repository_impl.dart';
import 'presentation/viewmodels/product_viewmodel.dart';
import 'presentation/pages/product_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Initialize dependencies
    final dio = Dio();
    final datasource = ProductRemoteDatasource(dio);
    final repository = ProductRepositoryImpl(datasource);
    final viewModel = ProductViewModel(repository);

    return MaterialApp(
      title: 'Product App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: ProductPage(viewModel: viewModel),
    );
  }
}

import 'package:dio/dio.dart';
import '../models/product_model.dart';
import '../../core/network/http_client.dart';

class ProductRemoteDatasource {
  final HttpClient client;

  ProductRemoteDatasource(this.client);

  Future<List<ProductModel>> getProducts() async {
    final data = await client.get("https://fakestoreapi.com/products");
    return (data as List)
        .map((json) => ProductModel.fromJson(json))
        .toList();
  }
}

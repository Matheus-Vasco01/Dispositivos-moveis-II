import 'package:flutter/foundation.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

class ProductViewModel {
  final ProductRepository repository;
  final ValueNotifier<List<Product>> products = ValueNotifier([]);
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<String?> error = ValueNotifier(null);

  ProductViewModel(this.repository);

  Future<void> loadProducts() async {
    isLoading.value = true;
    error.value = null;
    try {
      final result = await repository.getProducts();
      products.value = result;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}

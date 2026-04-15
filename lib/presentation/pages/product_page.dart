import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';
import '../viewmodels/product_viewmodel.dart';
import '../../core/errors/failure.dart';

class ProductPage extends StatefulWidget {
  final ProductViewModel viewModel;

  const ProductPage({super.key, required this.viewModel});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
    // Carrega os produtos na inicialização
    widget.viewModel.loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Products")),
      body: ValueListenableBuilder<bool>(
        valueListenable: widget.viewModel.isLoading,
        builder: (context, isLoading, _) {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return ValueListenableBuilder<Failure?>(
            valueListenable: widget.viewModel.error,
            builder: (context, error, _) {
              if (error != null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Erro: ${error.message}'),
                      ElevatedButton(
                        onPressed: widget.viewModel.loadProducts,
                        child: const Text('Tentar novamente'),
                      ),
                    ],
                  ),
                );
              }
              return ValueListenableBuilder<List<Product>>(
                valueListenable: widget.viewModel.products,
                builder: (context, products, _) {
                  if (products.isEmpty) {
                    return const Center(child: Text('Nenhum produto encontrado.'));
                  }
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ListTile(
                        leading: Image.network(
                          product.image,
                          width: 50,
                          height: 50,
                          fit: BoxFit.contain,
                        ),
                        title: Text(product.title),
                        subtitle: Text("\$${product.price}"),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.viewModel.loadProducts,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

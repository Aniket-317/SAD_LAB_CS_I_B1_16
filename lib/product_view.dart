import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/product.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {

  late Future<http.Response> _response;

  List<Product> products = [];
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();

    Uri url = Uri.https('dummyjson.com', '/products');
    _response = http.get(url);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: const Text("Products"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),

      body: FutureBuilder<http.Response>(
        future: _response,

        builder: (context, snapshot) {

          // 🔄 LOADING
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // ❌ ERROR
          else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          // ✅ DATA
          else if (snapshot.hasData) {

            if (snapshot.data!.statusCode == 200) {

              if (!isLoaded) {
                products = productFromMap(snapshot.data!.body);
                isLoaded = true;
              }

              return ListView.builder(
                itemCount: products.length,

                itemBuilder: (context, index) {

                  Product p = products[index];

                  return Card(
                    margin: const EdgeInsets.all(10),
                    elevation: 4,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // IMAGE + RATING
                        Stack(
                          children: [
                            Container(
                              height: 220,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(p.image),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),

                            Positioned(
                              left: 10,
                              bottom: 10,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                color: Colors.black54,
                                child: Text(
                                  "⭐ ${p.rating}",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              // TITLE
                              Text(
                                p.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),

                              const SizedBox(height: 6),

                              // DESCRIPTION
                              Text(
                                p.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),

                              const SizedBox(height: 10),

                              // CATEGORY + BUTTONS + PRICE
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Text(p.category),

                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.edit, color: Colors.blue),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.delete, color: Colors.red),
                                      ),
                                    ],
                                  ),

                                  Text("₹ ${p.price}")
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }

            return const Center(child: Text("Invalid response"));
          }

          return const Center(child: Text("No data"));
        },
      ),

      // ➕ ADD PRODUCT BUTTON
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            products.add(
              Product(
                id: products.length + 1,
                title: "New Product",
                price: 999,
                description: "Added from app",
                category: "electronics",
                image: "https://dummyimage.com/300",
                rating: 0.0,
              ),
            );
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
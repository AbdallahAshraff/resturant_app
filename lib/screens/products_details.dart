import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resturant_app/screens/reviewing.dart';
import 'package:resturant_app/utils/model.dart';

class ProductDetails extends StatelessWidget {
  final Meals food;

  ProductDetails(this.food, {super.key});

  // Using GetX observable counter for the meal count
  final RxInt mealCount = 1.obs;

  // Using GetX observable for selected extras
  final RxList<String> selectedExtras = <String>[].obs;
  final RxDouble mealprice = 0.0.obs; // Correctly initialized as RxDouble
  final RxDouble extraPrice = 0.0.obs;
  @override
  Widget build(BuildContext context) {
    mealprice.value =
        double.parse(food.price.toString()); // Initialize base price here

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:
            Text(food.name, style: const TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductImage(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                food.name,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                food.description ?? '',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ),
            const SizedBox(height: 20),
            _buildPriceAndReview(context),
            const SizedBox(height: 10),
            //_buildExtras(), // Add the extras section
            const SizedBox(height: 20),
            _buildCounter(), // Add the counter here using Obx
            const SizedBox(height: 20),
            _buildAddToCartButton(), // Add the Add to Cart button
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Build the product image
  Widget _buildProductImage() {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(food.imageUrl ?? ''),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 15),
    );
  }

  // Build the price and review section
  Widget _buildPriceAndReview(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() {
            double totalPrice = (mealprice.value * mealCount.value) +
                extraPrice.value; // Access .value for total calculation
            return Text(
              "\$ ${totalPrice.toStringAsFixed(2)}", // Format to 2 decimal places
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          }),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.orange, size: 20),
              const SizedBox(width: 5),
             /* Text(
                '${product['rate']} (${product['rate_number']} reviews)',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),*/
            ],
          ),
          TextButton(
            onPressed: () {
              // Handle add review logic here
             Navigator.of(context).push(MaterialPageRoute(builder: (context) => RateOrderScreen(meal: food,) ));
            },
            child: const Text(
              'Add Review',
              style: TextStyle(fontSize: 14, color: Colors.orange),
            ),
          ),
        ],
      ),
    );
  }

  // Build the counter using Obx from GetX
  Widget _buildCounter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Quantity',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  // Use GetX's obs and decrement the counter safely
                  if (mealCount.value > 1) {
                    mealCount.value--;
                  }
                },
              ),
              // Use Obx to make the counter reactive
              Obx(() => Text(
                    mealCount.value.toString(),
                    style: const TextStyle(fontSize: 18),
                  )),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  mealCount.value++;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Build the extras section
  /*Widget _buildExtras() {
    // Check if the product has extras
    if (product.containsKey('extras') &&
        product['extras'] is List &&
        product['extras'].isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Extras',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Column(
              children: List.generate(product['extras'].length, (index) {
                final extra = product['extras'][index];
                return Obx(() {
                  return CheckboxListTile(
                    activeColor: const Color(0xFFFF7D31),
                    title: Text('${extra['name']} (+\$${extra['price']})'),
                    value: selectedExtras.contains(extra['name']),
                    onChanged: (bool? value) {
                      if (value == true) {
                        selectedExtras.add(extra['name']);

                        extraPrice.value += double.parse(extra['price']);
                      } else {
                        selectedExtras.remove(extra['name']);

                        extraPrice.value -= double.parse(extra['price']);
                      }
                    },
                  );
                });
              }),
            ),
          ],
        ),
      );
    }
    return const SizedBox.shrink(); // If no extras, return an empty widget
  }*/

  // Build the "Add to Cart" button
  Widget _buildAddToCartButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: SizedBox(
        width: double.infinity, // Make the button full width
        child: ElevatedButton(
          onPressed: () {
            // Handle add to cart logic here
            Get.snackbar(
              'Added to Cart',
              '${mealCount.value} ${food.name} added to cart',
              snackPosition: SnackPosition.BOTTOM,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            padding: const EdgeInsets.symmetric(vertical: 15),
          ),
          child: const Text(
            'Add to Cart',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

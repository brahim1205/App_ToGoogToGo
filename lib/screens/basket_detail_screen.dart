import 'package:flutter/material.dart';
import '../models/basket.dart';
import '../models/store.dart';

class BasketDetailScreen extends StatelessWidget {
  final Basket basket;
  final Store store;

  const BasketDetailScreen(
      {super.key, required this.basket, required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(basket.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (basket.images.isNotEmpty)
              Image.network(basket.images[0], height: 200, fit: BoxFit.cover),
            SizedBox(height: 16),
            Text(
              basket.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text('Par ${store.name}'),
            SizedBox(height: 8),
            Text(basket.description),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  '${basket.discountedPrice}€',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  '${basket.originalPrice}€',
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
                'Collecte : ${basket.pickupTime.hour}:${basket.pickupTime.minute.toString().padLeft(2, '0')}'),
            Text('Quantité restante : ${basket.availableQuantity}'),
            SizedBox(height: 16),
            Text('Adresse : ${store.address}'),
            Text('Note : ${store.rating} ⭐'),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement reservation
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Réservation simulée')),
                );
              },
              child: Text('Réserver'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:dailycatch/models/basket.dart';
import 'package:dailycatch/models/store.dart';

final List<Basket> mockBaskets = [
  Basket(
    id: '1',
    storeId: '1',
    name: 'Fresh Bakery Basket',
    description:
        'Assortment of fresh breads, croissants, and pastries from our artisan bakery',
    originalPrice: 15.0,
    discountedPrice: 7.5,
    pickupTime: DateTime.now().add(Duration(hours: 2)),
    availableQuantity: 12,
    images: [
      'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=400&h=300&fit=crop',
      'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=400&h=300&fit=crop',
      'https://images.unsplash.com/photo-1559925393-8be0ec4767c8?w=400&h=300&fit=crop'
    ],
    category: 'Bread & pastries',
  ),
  Basket(
    id: '2',
    storeId: '2',
    name: 'Restaurant Surprise',
    description:
        'Delicious mixed dishes including pasta, salads, and seasonal specials',
    originalPrice: 25.0,
    discountedPrice: 12.5,
    pickupTime: DateTime.now().add(Duration(hours: 3)),
    availableQuantity: 5,
    images: [
      'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=400&h=300&fit=crop',
      'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400&h=300&fit=crop',
      'https://images.unsplash.com/photo-1551218808-94e220e084d2?w=400&h=300&fit=crop'
    ],
    category: 'Meals',
  ),
  Basket(
    id: '3',
    storeId: '3',
    name: 'Grocery Essentials',
    description: 'Fresh fruits, vegetables, dairy, and pantry staples',
    originalPrice: 20.0,
    discountedPrice: 10.0,
    pickupTime: DateTime.now().add(Duration(hours: 1)),
    availableQuantity: 8,
    images: [
      'https://images.unsplash.com/photo-1542838132-92c53300491e?w=400&h=300&fit=crop',
      'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=400&h=300&fit=crop',
      'https://images.unsplash.com/photo-1550583724-b2692b85b150?w=400&h=300&fit=crop'
    ],
    category: 'Groceries',
  ),
  Basket(
    id: '4',
    storeId: '4',
    name: 'Sweet Treats',
    description: 'Decadent cakes, tarts, cookies, and chocolate delights',
    originalPrice: 18.0,
    discountedPrice: 9.0,
    pickupTime: DateTime.now().add(Duration(hours: 4)),
    availableQuantity: 4,
    images: [
      'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=400&h=300&fit=crop',
      'https://images.unsplash.com/photo-1559925393-8be0ec4767c8?w=400&h=300&fit=crop',
      'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=400&h=300&fit=crop'
    ],
    category: 'Bread & pastries',
  ),
  Basket(
    id: '5',
    storeId: '5',
    name: 'Healthy Meals',
    description: 'Nutritious salads, grain bowls, and organic meal prep',
    originalPrice: 22.0,
    discountedPrice: 11.0,
    pickupTime: DateTime.now().add(Duration(hours: 5)),
    availableQuantity: 6,
    images: [
      'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=400&h=300&fit=crop',
      'https://images.unsplash.com/photo-1551218808-94e220e084d2?w=400&h=300&fit=crop',
      'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400&h=300&fit=crop'
    ],
    category: 'Meals',
  ),
  Basket(
    id: '6',
    storeId: '1',
    name: 'Mediterranean Delights',
    description: 'Authentic Cypriot dishes with fresh herbs and olive oil',
    originalPrice: 28.0,
    discountedPrice: 14.0,
    pickupTime: DateTime.now().add(Duration(hours: 6)),
    availableQuantity: 3,
    images: [
      'https://images.unsplash.com/photo-1551782450-a30595b8332e?w=400&h=300&fit=crop',
      'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=400&h=300&fit=crop',
      'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400&h=300&fit=crop'
    ],
    category: 'Meals',
  ),
  Basket(
    id: '7',
    storeId: '6',
    name: 'Vegan Paradise',
    description: 'Plant-based meals, smoothies, and organic snacks',
    originalPrice: 19.0,
    discountedPrice: 9.5,
    pickupTime: DateTime.now().add(Duration(hours: 2)),
    availableQuantity: 7,
    images: [
      'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400&h=300&fit=crop',
      'https://images.unsplash.com/photo-1551218808-94e220e084d2?w=400&h=300&fit=crop',
      'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=400&h=300&fit=crop'
    ],
    category: 'Meals',
  ),
  Basket(
    id: '8',
    storeId: '7',
    name: 'Cheese Lover\'s Dream',
    description: 'Artisanal cheeses, crackers, and gourmet accompaniments',
    originalPrice: 24.0,
    discountedPrice: 12.0,
    pickupTime: DateTime.now().add(Duration(hours: 3)),
    availableQuantity: 5,
    images: [
      'https://images.unsplash.com/photo-1486297678162-eb2a19b0a32d?w=400&h=300&fit=crop',
      'https://images.unsplash.com/photo-1550583724-b2692b85b150?w=400&h=300&fit=crop',
      'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=400&h=300&fit=crop'
    ],
    category: 'Groceries',
  ),
];

final List<Store> mockStores = [
  Store(
    id: '1',
    name: 'Penelope\'s Cypriot',
    address: '123 Main St, London',
    category: 'Restaurant',
    images: [
      'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=200&h=150&fit=crop'
    ],
    rating: 4.3,
    latitude: 51.5074,
    longitude: -0.1278,
  ),
  Store(
    id: '2',
    name: 'Local Bistro',
    address: '456 Oak Ave, London',
    category: 'Restaurant',
    images: [
      'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=200&h=150&fit=crop'
    ],
    rating: 4.1,
    latitude: 51.5074,
    longitude: -0.1278,
  ),
  Store(
    id: '3',
    name: 'City Grocery',
    address: '789 Pine Rd, London',
    category: 'Grocery',
    images: [
      'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=200&h=150&fit=crop'
    ],
    rating: 4.0,
    latitude: 51.5074,
    longitude: -0.1278,
  ),
  Store(
    id: '4',
    name: 'Sweet Corner',
    address: '321 Elm St, London',
    category: 'Bakery',
    images: [
      'https://images.unsplash.com/photo-1559925393-8be0ec4767c8?w=200&h=150&fit=crop'
    ],
    rating: 4.5,
    latitude: 51.5074,
    longitude: -0.1278,
  ),
  Store(
    id: '5',
    name: 'Healthy Eats',
    address: '654 Maple Dr, London',
    category: 'Restaurant',
    images: [
      'https://images.unsplash.com/photo-1551218808-94e220e084d2?w=200&h=150&fit=crop'
    ],
    rating: 4.2,
    latitude: 51.5074,
    longitude: -0.1278,
  ),
  Store(
    id: '6',
    name: 'Green Garden Cafe',
    address: '987 Willow Ln, London',
    category: 'Restaurant',
    images: [
      'https://images.unsplash.com/photo-1551218377-a0a4c5a3e6b8?w=200&h=150&fit=crop'
    ],
    rating: 4.4,
    latitude: 51.5074,
    longitude: -0.1278,
  ),
  Store(
    id: '7',
    name: 'Artisan Cheese Shop',
    address: '147 Birch St, London',
    category: 'Grocery',
    images: [
      'https://images.unsplash.com/photo-1550583724-b2692b85b150?w=200&h=150&fit=crop'
    ],
    rating: 4.6,
    latitude: 51.5074,
    longitude: -0.1278,
  ),
];

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dailycatch/mock_data.dart';
import 'package:dailycatch/models/basket.dart';
import 'package:dailycatch/models/store.dart';
import 'package:dailycatch/screens/basket_detail_screen.dart';

class DeliveryScreen extends StatefulWidget {
  @override
  _DeliveryScreenState createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  String selectedCategory = 'All';
  int _selectedIndex = 2; // Delivery is selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Delivery',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF00A082),
        elevation: 4,
        shadowColor: Color(0xFF00D4AA).withOpacity(0.3),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Categories section
            Container(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                children: [
                  _buildCategoryButton('Breakfast', Icons.restaurant, 9,
                      selectedCategory == 'Breakfast'),
                  SizedBox(width: 16),
                  _buildCategoryButton(
                      'Treats', Icons.cookie, 7, selectedCategory == 'Treats'),
                  SizedBox(width: 16),
                  _buildCategoryButton('Snacks', Icons.fastfood, 7,
                      selectedCategory == 'Snacks'),
                ],
              ),
            ),

            // Chocolate Parcel main card
            _buildChocolateParcelCard(),

            // All products section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'All products',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),

            // Products list with horizontal scrolling sections
            _buildHorizontalProductSection(
                'Recommended for you', _getFilteredProducts().take(4).toList()),
            SizedBox(height: 16),
            _buildHorizontalProductSection('Popular baskets',
                _getFilteredProducts().skip(4).take(4).toList()),
            SizedBox(height: 16),

            // All products vertical list
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'All products',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _getFilteredProducts().length,
              itemBuilder: (context, index) {
                final basket = _getFilteredProducts()[index];
                final store =
                    mockStores.firstWhere((s) => s.id == basket.storeId);
                return _buildProductCard(basket, store, index == 0);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Browse',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delivery_dining),
            label: 'Delivery',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF0A6A65),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          // TODO: Implement navigation to other screens
          if (index != 2) {
            // Not Delivery
            Navigator.of(context).pop(); // Go back to home for now
          }
        },
      ),
    );
  }

  Widget _buildCategoryButton(
      String title, IconData icon, int count, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = isSelected ? 'All' : title;
        });
      },
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF00A082) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Color(0xFF00A082),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Color(0xFF00A082),
              size: 28,
            ),
            SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Color(0xFF00A082),
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
            Text(
              '$count items',
              style: TextStyle(
                color: isSelected
                    ? Colors.white.withOpacity(0.8)
                    : Colors.grey[600],
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChocolateParcelCard() {
    return Container(
      margin: EdgeInsets.all(16),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF00D4AA).withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // Large product image
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1549007994-cb92caebd54b?w=400&h=300&fit=crop'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Price banner
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFF0A6A65),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '£40.00',
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '£18.99',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Chocolate Parcel',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(Basket basket, Store store, bool isFirst) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                BasketDetailScreen(basket: basket, store: store),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 4,
        shadowColor: Color(0xFF00D4AA).withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              // Product image
              Stack(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(basket.images.isNotEmpty
                            ? basket.images[0]
                            : 'https://via.placeholder.com/80'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (isFirst)
                    Positioned(
                      top: 4,
                      left: 4,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'New 50+ saved today',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(width: 16),
              // Product details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isFirst ? 'Surprise Parcel' : basket.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF00A082),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      store.name,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: Colors.orange[600],
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Collecte : ${basket.pickupTime.hour}:${basket.pickupTime.minute.toString().padLeft(2, '0')}',
                          style: TextStyle(
                            color: Colors.orange[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Price
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '£${basket.originalPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey[500],
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '£${basket.discountedPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF0A6A65),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Basket> _getFilteredProducts() {
    if (selectedCategory == 'All') {
      return mockBaskets;
    }

    // Map categories to basket categories
    Map<String, String> categoryMap = {
      'Breakfast': 'Bread & pastries',
      'Treats': 'Bread & pastries',
      'Snacks': 'Groceries',
    };

    String basketCategory = categoryMap[selectedCategory] ?? selectedCategory;
    return mockBaskets
        .where((basket) => basket.category == basketCategory)
        .toList();
  }

  Widget _buildHorizontalProductSection(String title, List<Basket> products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Navigate to full list
                },
                child: Text(
                  'See all',
                  style: TextStyle(
                    color: Color(0xFF00A082),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final basket = products[index];
              final store =
                  mockStores.firstWhere((s) => s.id == basket.storeId);
              return _buildHorizontalProductCard(basket, store);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHorizontalProductCard(Basket basket, Store store) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                BasketDetailScreen(basket: basket, store: store),
          ),
        );
      },
      child: Container(
        width: 140,
        margin: EdgeInsets.only(right: 12),
        child: Card(
          elevation: 4,
          shadowColor: Color(0xFF00D4AA).withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image
              Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(basket.images.isNotEmpty
                        ? basket.images[0]
                        : 'https://via.placeholder.com/140x80'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      basket.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Color(0xFF00A082),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2),
                    Text(
                      store.name,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 10,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '£${basket.originalPrice.toStringAsFixed(2)}',
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey[500],
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              '£${basket.discountedPrice.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Color(0xFF0A6A65),
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: Color(0xFF00A082),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dailycatch/mock_data.dart';
import 'package:dailycatch/models/basket.dart';
import 'package:dailycatch/models/store.dart';
import 'package:dailycatch/screens/basket_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Basket> baskets = mockBaskets;
  List<Store> stores = mockStores;
  int _selectedIndex = 0;
  String selectedFilter = 'All';
  int _bottomNavIndex = 0; // Discover selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dailycatch',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF00A082), // Too Good To Go dark green
        elevation: 4,
        shadowColor: Color(0xFF00D4AA).withOpacity(0.3),
        actions: [
          IconButton(
            icon: Icon(
              Icons.location_on,
              color: Colors.white,
            ),
            onPressed: () {
              // TODO: Implement location change
            },
          ),
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: () {
              // TODO: Implement notifications
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Educational banner
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFFBEFE6),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFF0A6A65), width: 1),
              ),
              child: Row(
                children: [
                  Icon(Icons.restaurant, color: Color(0xFF0A6A65)),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'FOOD FROM BAKERIES, RESTAURANTS AND STORES',
                      style: TextStyle(
                        color: Color(0xFF0A6A65),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.info_outline, color: Color(0xFF0A6A65)),
                    onPressed: () {
                      // TODO: Open explanatory page
                    },
                  ),
                ],
              ),
            ),
            // Search bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search stores or basket types...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            // TOP PICKS near you section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'TOP PICKS near you',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16),
            _buildTopPickCard(),
            SizedBox(height: 24),

            // Current location bar
            GestureDetector(
              onTap: () {
                // TODO: Implement location change
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Color(0xFFFBEFE6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.location_on, color: Color(0xFF00A082)),
                    SizedBox(width: 8),
                    Text(
                      'Current location',
                      style: TextStyle(
                        color: Color(0xFF00A082),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'London',
                      style: TextStyle(
                        color: Color(0xFF00A082),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down, color: Color(0xFF0A6A65)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Filters
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildFilterChip('All', selectedFilter == 'All'),
                  _buildFilterChip('Meals', selectedFilter == 'Meals'),
                  _buildFilterChip(
                      'Bread & pastries', selectedFilter == 'Bread & pastries'),
                  _buildFilterChip('Groceries', selectedFilter == 'Groceries'),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Recommended for you section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recommended for you',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Open full recommendations list
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
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: baskets.length,
                itemBuilder: (context, index) {
                  final basket = baskets[index];
                  final store =
                      stores.firstWhere((s) => s.id == basket.storeId);
                  return _buildRecommendedCard(basket, store);
                },
              ),
            ),
            SizedBox(height: 16),

            // All baskets list
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'All available baskets',
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
              itemCount: _getFilteredBaskets().length,
              itemBuilder: (context, index) {
                final basket = _getFilteredBaskets()[index];
                final store = stores.firstWhere((s) => s.id == basket.storeId);
                return _buildBasketCard(basket, store);
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
        currentIndex: _bottomNavIndex,
        selectedItemColor: Color(0xFF0A6A65),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
          if (index == 1) {
            // Browse
            Navigator.pushNamed(context, '/browse');
          } else if (index == 2) {
            // Delivery
            Navigator.pushNamed(context, '/delivery');
          }
          // TODO: Implement navigation to other screens
        },
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Color(0xFF0A6A65),
            fontWeight: FontWeight.w500,
          ),
        ),
        selected: isSelected,
        onSelected: (bool selected) {
          setState(() {
            selectedFilter = label;
          });
        },
        backgroundColor: Colors.white,
        selectedColor: Color(0xFF0A6A65),
        checkmarkColor: Colors.white,
        side: BorderSide(
          color: Color(0xFF00A082),
          width: 1,
        ),
      ),
    );
  }

  Widget _buildTopPickCard() {
    if (baskets.isEmpty) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        height: 250,
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text('No baskets available'),
          ),
        ),
      );
    }
    final basket = baskets[0];
    final store = stores.firstWhere((s) => s.id == basket.storeId);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      height: 250,
      child: Stack(
        children: [
          // Third shadow card (back)
          Positioned(
            left: 12,
            top: 12,
            child: Transform.rotate(
              angle: -0.15,
              child: Container(
                width: MediaQuery.of(context).size.width - 56,
                height: 220,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage(basket.images.length > 2
                        ? basket.images[2]
                        : basket.images.isNotEmpty
                            ? basket.images[0]
                            : 'https://via.placeholder.com/300'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.3),
                      BlendMode.darken,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Second shadow card (middle)
          Positioned(
            left: 8,
            top: 8,
            child: Transform.rotate(
              angle: -0.08,
              child: Container(
                width: MediaQuery.of(context).size.width - 48,
                height: 230,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage(basket.images.length > 1
                        ? basket.images[1]
                        : basket.images.isNotEmpty
                            ? basket.images[0]
                            : 'https://via.placeholder.com/300'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.2),
                      BlendMode.darken,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // First shadow card (front)
          Positioned(
            left: 4,
            top: 4,
            child: Transform.rotate(
              angle: -0.03,
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 240,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage(basket.images.isNotEmpty
                        ? basket.images[0]
                        : 'https://via.placeholder.com/300'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.1),
                      BlendMode.darken,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Main card
          GestureDetector(
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
              elevation: 12,
              shadowColor: Color(0xFF00D4AA).withOpacity(0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [Colors.white, Color(0xFFE8F5E8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image with overlay
                    Expanded(
                      flex: 3,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16)),
                              image: DecorationImage(
                                image: NetworkImage(basket.images.isNotEmpty
                                    ? basket.images[0]
                                    : 'https://via.placeholder.com/300'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // Rating badge
                          Positioned(
                            top: 12,
                            right: 12,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.star,
                                      size: 16, color: Colors.amber),
                                  SizedBox(width: 4),
                                  Text('4.3',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                          // Store logo
                          Positioned(
                            bottom: 12,
                            left: 12,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(color: Colors.white, width: 2),
                              ),
                              child:
                                  Icon(Icons.store, color: Color(0xFF0A6A65)),
                            ),
                          ),
                          // Favorite icon
                          Positioned(
                            bottom: 12,
                            right: 12,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.favorite_border,
                                  color: Color(0xFFE57373)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Content
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                store.name,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0A6A65),
                                ),
                              ),
                              Text(
                                basket.category,
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Collect today ${basket.pickupTime.hour}:${basket.pickupTime.minute.toString().padLeft(2, '0')}–${(basket.pickupTime.hour + 1) % 24}:${basket.pickupTime.minute.toString().padLeft(2, '0')}',
                                style: TextStyle(
                                    color: Colors.orange[600],
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '2.1 km',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    '${(basket.discountedPrice * 0.85).toStringAsFixed(2)}\$ ${basket.discountedPrice.toStringAsFixed(2)}€',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Color(0xFF0A6A65),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    '${basket.originalPrice}€',
                                    style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey[500],
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedCard(Basket basket, Store store) {
    return Container(
      width: 160,
      margin: EdgeInsets.only(right: 12),
      child: Stack(
        children: [
          // Third shadow layer (back)
          Positioned(
            left: 6,
            top: 6,
            child: Container(
              width: 148,
              height: 176,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          // Second shadow layer (middle)
          Positioned(
            left: 3,
            top: 3,
            child: Container(
              width: 154,
              height: 182,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          // First shadow layer (front)
          Positioned(
            left: 1.5,
            top: 1.5,
            child: Container(
              width: 157,
              height: 185,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          // Main card
          Card(
            elevation: 8,
            shadowColor: Color(0xFF00D4AA).withOpacity(0.4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image with favorite icon
                Stack(
                  children: [
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(12)),
                        image: DecorationImage(
                          image: NetworkImage(basket.images.isNotEmpty
                              ? basket.images[0]
                              : 'https://via.placeholder.com/150'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Icon(Icons.favorite_border,
                          color: Colors.white, size: 20),
                    ),
                  ],
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
                          fontSize: 14,
                          color: Color(0xFF00A082),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        store.name,
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            '${(basket.discountedPrice * 0.85).toStringAsFixed(2)}\$ ${basket.discountedPrice.toStringAsFixed(2)}€',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(0xFF00A082),
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            '${basket.originalPrice}€',
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey[500],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasketCard(Basket basket, Store store) {
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
        elevation: 6,
        shadowColor: Color(0xFF00D4AA).withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Color(0xFFFBEFE6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                if (basket.images.isNotEmpty)
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF00D4AA).withOpacity(0.3),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        basket.images[0],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        basket.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xFF00A082),
                        ),
                      ),
                      Text(
                        store.name,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            '${(basket.discountedPrice * 0.85).toStringAsFixed(2)}\$ ${basket.discountedPrice.toStringAsFixed(2)}€',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFF0A6A65),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            '${basket.originalPrice}€',
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey[500],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 16,
                            color: Colors.orange[600],
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Collecte : ${basket.pickupTime.hour}:${basket.pickupTime.minute.toString().padLeft(2, '0')}',
                            style: TextStyle(
                              color: Colors.orange[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: basket.availableQuantity > 0
                              ? Color(0xFFFBEFE6)
                              : Colors.red[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${basket.availableQuantity} restants',
                          style: TextStyle(
                            color: basket.availableQuantity > 0
                                ? Color(0xFF0A6A65)
                                : Colors.red[800],
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Basket> _getFilteredBaskets() {
    if (selectedFilter == 'All') {
      return baskets;
    }
    return baskets
        .where((basket) => basket.category == selectedFilter)
        .toList();
  }
}

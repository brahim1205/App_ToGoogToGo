import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dailycatch/mock_data.dart';
import 'package:dailycatch/models/basket.dart';
import 'package:dailycatch/models/store.dart';
import 'package:dailycatch/screens/basket_detail_screen.dart';

class FavouritesScreen extends StatefulWidget {
  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  // In a real app, this would be loaded from user preferences or database
  List<String> favouriteBasketIds = ['1', '3', '5']; // Mock favourite basket IDs
  int _selectedIndex = 3; // Favourites selected

  @override
  Widget build(BuildContext context) {
    final favouriteBaskets = mockBaskets
        .where((basket) => favouriteBasketIds.contains(basket.id))
        .toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'My Favourites',
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
      body: favouriteBaskets.isEmpty
          ? _buildEmptyState()
          : _buildFavouritesList(favouriteBaskets),
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
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 0) {
            Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/browse');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/delivery');
          } else if (index == 4) {
            Navigator.pushReplacementNamed(context, '/profile');
          }
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 80,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16),
          Text(
            'No favourites yet',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Tap the heart icon on baskets you love\nto add them to your favourites',
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF00A082),
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Explore Baskets',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavouritesList(List<Basket> favouriteBaskets) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: favouriteBaskets.length,
      itemBuilder: (context, index) {
        final basket = favouriteBaskets[index];
        final store = mockStores.firstWhere((s) => s.id == basket.storeId);
        return Container(
          margin: EdgeInsets.only(bottom: 16),
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
            child: InkWell(
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
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Basket image
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(
                              basket.images.isNotEmpty ? basket.images[0] : ''),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: basket.images.isEmpty
                          ? Icon(
                              Icons.restaurant,
                              color: Color(0xFF00A082),
                              size: 40,
                            )
                          : null,
                    ),
                    SizedBox(width: 16),
                    // Basket details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  basket.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Color(0xFF00A082),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.favorite,
                                  color: Colors.red[400],
                                ),
                                onPressed: () {
                                  _removeFromFavourites(basket.id);
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
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
                                '${basket.discountedPrice.toStringAsFixed(2)}€',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFF0A6A65),
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                '${basket.originalPrice.toStringAsFixed(2)}€',
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
                                'Collect: ${basket.pickupTime.hour}:${basket.pickupTime.minute.toString().padLeft(2, '0')}',
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
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _removeFromFavourites(String basketId) {
    setState(() {
      favouriteBasketIds.remove(basketId);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Removed from favourites'),
        backgroundColor: Color(0xFF00A082),
      ),
    );
  }
}
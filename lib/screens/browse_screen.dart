import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dailycatch/mock_data.dart';
import 'package:dailycatch/models/store.dart';
import 'package:flutter_map/flutter_map.dart' as flutter_map;
import 'package:latlong2/latlong.dart';

class BrowseScreen extends StatefulWidget {
  @override
  _BrowseScreenState createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  int _selectedIndex = 1; // Browse selected
  bool _isMapView = true; // Default to Map view
  Store? _selectedStore; // Selected store for bottom card
  List<flutter_map.Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    _selectedStore = mockStores[0]; // Default selected store
    _createMarkers();
  }

  void _createMarkers() {
    _markers = mockStores
        .map((store) {
          return flutter_map.Marker(
            point: LatLng(store.latitude, store.longitude),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedStore = store;
                });
              },
              child: Icon(
                Icons.location_on,
                color: Color(0xFF0A6A65),
                size: 40,
              ),
            ),
          );
        })
        .toList()
        .cast<flutter_map.Marker>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content
          Column(
            children: [
              // Top bar with search and filters
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 16,
                    left: 16,
                    right: 16,
                    bottom: 16),
                color: Colors.white,
                child: Row(
                  children: [
                    // Search bar
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Rechercher un magasin...',
                            prefixIcon: Icon(Icons.search, color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    // Filter button
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.tune, color: Colors.grey[600]),
                        onPressed: () {
                          // TODO: Open filters modal
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // List/Map toggle
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildToggleButton('List', !_isMapView),
                    SizedBox(width: 8),
                    _buildToggleButton('Map', _isMapView),
                  ],
                ),
              ),
              // Map or List view
              Expanded(
                child: _isMapView ? _buildMapView() : _buildListView(),
              ),
            ],
          ),
          // Bottom sheet (only in Map view)
          if (_isMapView && _selectedStore != null)
            Positioned(
              bottom: 56, // Glued to navigation bar
              left: 16,
              right: 16,
              child: Dismissible(
                key: Key(_selectedStore!.name),
                direction: DismissDirection.down,
                onDismissed: (direction) {
                  setState(() {
                    _selectedStore = null;
                  });
                },
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedStore = null;
                    });
                  },
                  child: _buildBottomSheet(_selectedStore!),
                ),
              ),
            ),
        ],
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
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 0) {
            // Discover
            Navigator.pushNamed(context, '/home');
          } else if (index == 2) {
            // Delivery
            Navigator.pushNamed(context, '/delivery');
          }
          // TODO: Implement navigation to other screens
        },
      ),
    );
  }

  Widget _buildToggleButton(String text, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isMapView = text == 'Map';
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Color(0xFF0A6A65) : Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMapView() {
    return flutter_map.FlutterMap(
      options: flutter_map.MapOptions(
        center: LatLng(51.5074, -0.1278), // London coordinates
        zoom: 12,
      ),
      children: [
        flutter_map.TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        flutter_map.MarkerLayer(markers: _markers),
      ],
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: mockStores.length,
      itemBuilder: (context, index) {
        return _buildStoreCard(mockStores[index]);
      },
    );
  }

  Widget _buildBottomSheet(Store store) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Store name
          Text(
            store.name,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0A6A65),
            ),
          ),
          SizedBox(height: 8),
          // Distance and address
          Row(
            children: [
              Icon(Icons.location_on, size: 14, color: Colors.grey[600]),
              SizedBox(width: 4),
              Text(
                '1.4 km | ${store.address}',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          // Category
          Text(
            store.category,
            style: TextStyle(
              color: Color(0xFF00A082),
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 4),
          // Availability
          Row(
            children: [
              Icon(Icons.access_time, size: 14, color: Colors.orange[600]),
              SizedBox(width: 4),
              Text(
                'Tomorrow 18:30 - 20:00',
                style: TextStyle(
                  color: Colors.orange[600],
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          // Rating and price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.star, size: 16, color: Colors.amber),
                  SizedBox(width: 4),
                  Text(
                    '${store.rating}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF0A6A65),
                    ),
                  ),
                ],
              ),
              Text(
                '4,50 €',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0A6A65),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStoreCard(Store store) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to store detail or basket list
      },
      child: Card(
        elevation: 8,
        shadowColor: Color(0xFF00D4AA).withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: EdgeInsets.all(16),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [Colors.white, Color(0xFFFBEFE6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              // Store image placeholder
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200],
                ),
                child: Center(
                  child: Icon(
                    Icons.store,
                    size: 32,
                    color: Color(0xFF0A6A65),
                  ),
                ),
              ),
              SizedBox(width: 16),
              // Store details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Store name
                    Text(
                      store.name,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0A6A65),
                      ),
                    ),
                    SizedBox(height: 4),
                    // Distance and address
                    Row(
                      children: [
                        Icon(Icons.location_on,
                            size: 14, color: Colors.grey[600]),
                        SizedBox(width: 4),
                        Text(
                          '1.4 km | ${store.address}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    // Category
                    Text(
                      store.category,
                      style: TextStyle(
                        color: Color(0xFF00A082),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    // Availability
                    Row(
                      children: [
                        Icon(Icons.access_time,
                            size: 14, color: Colors.orange[600]),
                        SizedBox(width: 4),
                        Text(
                          'Tomorrow 18:30 - 20:00',
                          style: TextStyle(
                            color: Colors.orange[600],
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    // Rating and price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star, size: 14, color: Colors.amber),
                            SizedBox(width: 4),
                            Text(
                              '+ ${store.rating}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color(0xFF0A6A65),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '4,50 €',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0A6A65),
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
    );
  }
}

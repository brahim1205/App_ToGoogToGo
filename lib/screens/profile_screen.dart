import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 4; // Profile selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF00A082),
        elevation: 4,
        shadowColor: Color(0xFF00D4AA).withOpacity(0.3),
        actions: [
          TextButton(
            onPressed: _logout,
            child: Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            // Profile Picture
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Color(0xFF00A082),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF00D4AA).withOpacity(0.3),
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Icon(
                Icons.person,
                size: 60,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'John Doe', // In real app, get from user data
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0A6A65),
              ),
            ),
            Text(
              'john.doe@example.com', // In real app, get from user data
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
            SizedBox(height: 32),

            // Menu Items
            _buildMenuItem(
              icon: Icons.shopping_bag,
              title: 'My Orders',
              onTap: () {
                // TODO: Navigate to orders screen
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Orders screen coming soon!')),
                );
              },
            ),
            _buildMenuItem(
              icon: Icons.favorite,
              title: 'Favourites',
              onTap: () {
                Navigator.pushNamed(context, '/favourites');
              },
            ),
            _buildMenuItem(
              icon: Icons.location_on,
              title: 'Addresses',
              onTap: () {
                // TODO: Navigate to addresses screen
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Addresses screen coming soon!')),
                );
              },
            ),
            _buildMenuItem(
              icon: Icons.payment,
              title: 'Payment Methods',
              onTap: () {
                // TODO: Navigate to payment methods screen
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Payment methods screen coming soon!')),
                );
              },
            ),
            _buildMenuItem(
              icon: Icons.notifications,
              title: 'Notifications',
              onTap: () {
                // TODO: Navigate to notifications settings
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Notifications settings coming soon!')),
                );
              },
            ),
            _buildMenuItem(
              icon: Icons.help,
              title: 'Help & Support',
              onTap: () {
                // TODO: Navigate to help screen
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Help & Support coming soon!')),
                );
              },
            ),
            _buildMenuItem(
              icon: Icons.info,
              title: 'About',
              onTap: () {
                _showAboutDialog();
              },
            ),

            SizedBox(height: 32),

            // Stats Section
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFFFBEFE6),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Color(0xFF0A6A65), width: 1),
              ),
              child: Column(
                children: [
                  Text(
                    'Your Impact',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0A6A65),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatItem('12', 'Baskets Saved'),
                      _buildStatItem('€45', 'Money Saved'),
                      _buildStatItem('8kg', 'Food Saved'),
                    ],
                  ),
                ],
              ),
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
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 0) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          } else if (index == 1) {
            Navigator.pushNamed(context, '/browse');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/delivery');
          } else if (index == 3) {
            Navigator.pushNamed(context, '/favourites');
          }
        },
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: Color(0xFF00A082)),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xFF0A6A65),
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0A6A65),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'About Dailycatch',
            style: TextStyle(color: Color(0xFF0A6A65)),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Version 1.0.0'),
              SizedBox(height: 8),
              Text(
                'Dailycatch helps reduce food waste by connecting you with surplus food from local businesses at discounted prices.',
              ),
              SizedBox(height: 16),
              Text(
                'Together, we can make a difference!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00A082),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Close',
                style: TextStyle(color: Color(0xFF00A082)),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error logging out'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

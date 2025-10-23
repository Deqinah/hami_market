import 'package:flutter/material.dart';

// Profile Screen
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF2E7D32), Color(0xFF4CAF50)],
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40, color: Color(0xFF2E7D32)),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Isticmaale Hami',
                    style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'hami@customer.com',
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            _buildMenuButton(Icons.person, 'Profilekaaga', () {}),
            _buildMenuButton(Icons.shopping_bag, 'Dalabkaaga', () {}),
            _buildMenuButton(Icons.favorite, 'Kuwa aad jeceshahay', () {}),
            _buildMenuButton(Icons.settings, 'Dejinta', () {}),
            _buildMenuButton(Icons.help, 'Gargaar', () {}),
            _buildMenuButton(Icons.logout, 'Ka bax', () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(IconData icon, String title, VoidCallback onTap) {
    return Card(
      margin: EdgeInsets.only(bottom: 10),
      elevation: 1,
      child: ListTile(
        leading: Icon(icon, color: Color(0xFF2E7D32)),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}

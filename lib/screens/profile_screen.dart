import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController(text: 'Douglas Emmanuel');
  final TextEditingController _emailController = TextEditingController(text: 'emmnaueldouglas2121@gmail.com');

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    // Implement your save logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profile saved!')),
    );
  }

  void _logout() {
    // Implement logout logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Logged out!')),
    );
    // For example, navigate to login screen or clear user session
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage('../../assets/images/Douglas.jpeg'),
            ),
            SizedBox(height: 20),
            _buildTextField(label: 'Name', controller: _nameController),
            SizedBox(height: 16),
            _buildTextField(label: 'Email', controller: _emailController),
            SizedBox(height: 32),
            ElevatedButton(
            onPressed: _saveProfile,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,       
              foregroundColor: Colors.white,        
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: Text('Save Changes'),
          ),

            Spacer(),
            OutlinedButton.icon(
              onPressed: _logout,
              icon: Icon(Icons.logout, color: Colors.red),
              label: Text('Logout', style: TextStyle(color: Colors.red)),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.red),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, required TextEditingController controller}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}

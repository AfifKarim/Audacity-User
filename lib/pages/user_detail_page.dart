import 'package:flutter/material.dart';
import '../models/user.dart';

class UserDetailPage extends StatelessWidget {
  final User user;

  UserDetailPage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.firstName} ${user.lastName} Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              user.profilePicture,
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text('Email: ${user.email}'),
            Text('Phone: ${user.phone}'),
            Text('Gender: ${user.gender}'),
            Text('Date of Birth: ${user.dateOfBirth}'),
            Text('Job: ${user.job}'),
            Text('City: ${user.city}'),
            Text('State: ${user.state}'),
            Text('Country: ${user.country}'),
          ],
        ),
      ),
    );
  }
}

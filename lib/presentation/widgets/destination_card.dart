import 'package:flutter/material.dart';
import '../../data/models/destination.dart';

class DestinationCard extends StatelessWidget {
  final Destination destination;
  final VoidCallback onEdit;

  const DestinationCard({
    Key? key,
    required this.destination,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(
          destination.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(destination.description),
        trailing: IconButton(icon: Icon(Icons.edit), onPressed: onEdit),
        onTap: () {
          // Placeholder for Google Maps action
        },
      ),
    );
  }
}

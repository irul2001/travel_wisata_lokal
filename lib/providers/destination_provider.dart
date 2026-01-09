import 'package:flutter/material.dart';
import '../data/models/destination.dart';
import '../data/repositories/destination_repository.dart';

class DestinationProvider with ChangeNotifier {
  final DestinationRepository _repository = DestinationRepository();
  List<Destination> _destinations = [];

  List<Destination> get destinations => _destinations;

  Future<void> fetchDestinations() async {
    _destinations = await _repository.getDestinations();
    notifyListeners();
  }
}

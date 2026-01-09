class Destination {
  final int? id;
  final String name;
  final String description;
  final String address;
  final double latitude;
  final double longitude;

  Destination({
    this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  Destination copyWith({
    int? id,
    String? name,
    String? description,
    String? address,
    double? latitude,
    double? longitude,
  }) {
    return Destination(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Destination.fromMap(Map<String, dynamic> map) {
    return Destination(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      address: map['address'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }
}

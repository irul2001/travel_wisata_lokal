import '../models/destination.dart';

class DestinationService {
  /// ===============================
  /// SIMPANAN SEMENTARA (MOCK DB)
  /// ===============================
  static final List<Destination> _destinations = [];

  /// ===============================
  /// GET SEMUA DATA
  /// ===============================
  static Future<List<Destination>> getAll() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _destinations;
  }

  /// ===============================
  /// INSERT
  /// ===============================
  static Future<void> insert(Destination destination) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _destinations.add(
      destination.copyWith(id: DateTime.now().millisecondsSinceEpoch),
    );
  }

  /// ===============================
  /// UPDATE
  /// ===============================
  static Future<void> update(Destination destination) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _destinations.indexWhere((d) => d.id == destination.id);
    if (index != -1) {
      _destinations[index] = destination;
    }
  }

  /// ===============================
  /// DELETE
  /// ===============================
  static Future<void> delete(int id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _destinations.removeWhere((d) => d.id == id);
  }

  /// ===============================
  /// PARSE GOOGLE MAPS LINK (TANPA API)
  /// SUPPORT:
  /// - maps.app.goo.gl (yang sudah dibuka)
  /// - google.com/maps
  /// ===============================
  static Map<String, String>? parseGoogleMapsLink(String url) {
    try {
      // Contoh format:
      // https://www.google.com/maps/place/Alun-Alun+Kota+Malang/@-7.9826,112.6308,17z
      // atau:
      // ...!3d-7.9826!4d112.6308

      // Ambil koordinat dari format @lat,lng
      final regLatLng = RegExp(r'@(-?\d+\.\d+),(-?\d+\.\d+)');
      final match = regLatLng.firstMatch(url);

      if (match == null) {
        // Fallback: format !3dLAT!4dLNG
        final altReg = RegExp(r'!3d(-?\d+\.\d+)!4d(-?\d+\.\d+)');
        final altMatch = altReg.firstMatch(url);
        if (altMatch == null) return null;

        return {
          'lat': altMatch.group(1)!,
          'lng': altMatch.group(2)!,
          'name': _extractPlaceName(url),
          'address': _extractPlaceName(url),
        };
      }

      return {
        'lat': match.group(1)!,
        'lng': match.group(2)!,
        'name': _extractPlaceName(url),
        'address': _extractPlaceName(url),
      };
    } catch (e) {
      print("Parse Google Maps error: $e");
      return null;
    }
  }

  /// ===============================
  /// AMBIL NAMA TEMPAT DARI URL
  /// ===============================
  static String _extractPlaceName(String url) {
    try {
      final uri = Uri.parse(url);

      if (uri.pathSegments.contains("place")) {
        final index = uri.pathSegments.indexOf("place");
        if (index + 1 < uri.pathSegments.length) {
          return uri.pathSegments[index + 1]
              .replaceAll("+", " ")
              .replaceAll("%20", " ");
        }
      }
    } catch (_) {}

    return "Lokasi Wisata";
  }
}

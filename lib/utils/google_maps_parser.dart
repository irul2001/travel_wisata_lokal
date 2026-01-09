import 'package:http/http.dart' as http;

/// Ambil latitude, longitude, dan nama tempat dari Google Maps link
Future<Map<String, dynamic>> getPlaceFromGoogleMapsLink(String url) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final finalUrl = response.request!.url.toString();
    final body = response.body;

    /// Ambil koordinat dari URL
    final coordRegex = RegExp(r'@(-?\d+\.\d+),(-?\d+\.\d+)');
    final coordMatch = coordRegex.firstMatch(finalUrl);

    if (coordMatch == null) {
      throw Exception("Koordinat tidak ditemukan dalam URL");
    }

    final lat = double.parse(coordMatch.group(1)!);
    final lng = double.parse(coordMatch.group(2)!);

    /// Ambil nama tempat dari title HTML
    /// Biasanya: <title>Nama Tempat - Google Maps</title>
    String placeName = "Lokasi Wisata";

    final titleRegex = RegExp(r'<title>(.*?)</title>');
    final titleMatch = titleRegex.firstMatch(body);

    if (titleMatch != null) {
      placeName = titleMatch.group(1)!;
      placeName = placeName.replaceAll(" - Google Maps", "").trim();
    }

    return {"lat": lat, "lng": lng, "name": placeName};
  } else {
    throw Exception("Gagal membuka link Google Maps");
  }
}

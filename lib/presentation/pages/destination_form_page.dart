import 'package:flutter/material.dart';
import '../../data/models/destination.dart';
import '../../data/repositories/destination_repository.dart';

class DestinationFormPage extends StatefulWidget {
  final Destination? destination;

  const DestinationFormPage({super.key, this.destination});

  @override
  State<DestinationFormPage> createState() => _DestinationFormPageState();
}

class _DestinationFormPageState extends State<DestinationFormPage> {
  final _formKey = GlobalKey<FormState>();
  final DestinationRepository _repository = DestinationRepository();

  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _addressController = TextEditingController();
  final _mapLinkController = TextEditingController();

  double? _latitude;
  double? _longitude;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    if (widget.destination != null) {
      _nameController.text = widget.destination!.name;
      _descController.text = widget.destination!.description;
      _addressController.text = widget.destination!.address;
      _latitude = widget.destination!.latitude;
      _longitude = widget.destination!.longitude;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _addressController.dispose();
    _mapLinkController.dispose();
    super.dispose();
  }

  /// ===============================
  /// PREVIEW DARI LINK GOOGLE MAPS
  /// ===============================
  Future<void> _previewFromMapLink() async {
    final link = _mapLinkController.text.trim();

    if (link.isEmpty) {
      _showMessage("Masukkan link Google Maps terlebih dahulu");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final result = await _extractLocationFromGoogleMapsLink(link);

      if (result == null) {
        _showMessage("Link Google Maps tidak valid");
      } else {
        setState(() {
          _nameController.text = result['name']!;
          _addressController.text = result['address']!;
          _latitude = double.parse(result['lat']!);
          _longitude = double.parse(result['lng']!);
        });

        _showMessage("Preview lokasi berhasil");
      }
    } catch (e) {
      _showMessage("Gagal membaca link Google Maps");
    }

    setState(() => _isLoading = false);
  }

  /// ===============================
  /// EXTRACT DATA DARI LINK MAPS
  /// TANPA API (GRATIS)
  /// ===============================
  Future<Map<String, String>?> _extractLocationFromGoogleMapsLink(
    String url,
  ) async {
    try {
      final uri = Uri.parse(url);

      // Terima semua format Google Maps
      if (!(uri.host.contains("google.com") ||
          uri.host.contains("goo.gl") ||
          uri.host.contains("maps.app.goo.gl"))) {
        return null;
      }

      final finalUrl = url; // langsung pakai URL yang dimasukkan user

      // 1️⃣ Ambil koordinat dari format: !3dLAT!4dLNG
      final latLngReg = RegExp(r'!3d(-?\d+\.\d+)!4d(-?\d+\.\d+)');
      final latLngMatch = latLngReg.firstMatch(finalUrl);

      if (latLngMatch == null) return null;

      final lat = latLngMatch.group(1)!;
      final lng = latLngMatch.group(2)!;

      // 2️⃣ Ambil nama tempat dari /maps/place/NAMA_TEMPAT
      String name = "Lokasi Wisata";
      String address = "Alamat tidak tersedia";

      final placeReg = RegExp(r'/maps/place/([^/]+)');
      final placeMatch = placeReg.firstMatch(finalUrl);

      if (placeMatch != null) {
        name = Uri.decodeComponent(placeMatch.group(1)!).replaceAll("+", " ");
        address = name;
      }

      return {'name': name, 'address': address, 'lat': lat, 'lng': lng};
    } catch (e) {
      print("Parse error: $e");
      return null;
    }
  }

  /// ===============================
  /// SIMPAN DATA (KE DATABASE)
  /// ===============================
  void _saveDestination() async {
    if (!_formKey.currentState!.validate()) return;

    if (_latitude == null || _longitude == null) {
      _showMessage("Preview lokasi dari link Google Maps dulu bro");
      return;
    }

    final destination = Destination(
      id: widget.destination?.id,
      name: _nameController.text,
      description: _descController.text,
      address: _addressController.text,
      latitude: _latitude!,
      longitude: _longitude!,
    );

    if (widget.destination == null) {
      await _repository.insertDestination(destination);
      _showMessage("Destinasi berhasil ditambahkan");
    } else {
      await _repository.updateDestination(destination);
      _showMessage("Destinasi berhasil diperbarui");
    }

    if (mounted) Navigator.pop(context, true);
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  /// ===============================
  /// UI
  /// ===============================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.destination == null ? "Tambah Destinasi" : "Edit Destinasi",
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _mapLinkController,
                decoration: const InputDecoration(
                  labelText: "Link Google Maps",
                  hintText: "https://maps.app.goo.gl/xxxx",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isLoading ? null : _previewFromMapLink,
                  icon: const Icon(Icons.location_searching),
                  label: _isLoading
                      ? const Text("Memproses...")
                      : const Text("Preview Lokasi dari Link"),
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Nama Tempat",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Nama tempat wajib diisi" : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(
                  labelText: "Deskripsi",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) =>
                    value!.isEmpty ? "Deskripsi wajib diisi" : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: "Alamat",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Alamat wajib diisi" : null,
              ),
              const SizedBox(height: 12),

              if (_latitude != null && _longitude != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Preview Lokasi:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text("Latitude  : $_latitude"),
                      Text("Longitude : $_longitude"),
                    ],
                  ),
                ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveDestination,
                  child: const Text("Simpan Destinasi"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

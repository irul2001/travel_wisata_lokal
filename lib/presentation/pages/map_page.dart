import 'package:flutter/material.dart';
import '../../data/repositories/destination_repository.dart';
import '../../data/models/destination.dart';
import 'destination_form_page.dart';
import 'destination_detail_page.dart';

class DestinationListPage extends StatefulWidget {
  const DestinationListPage({super.key});

  @override
  State<DestinationListPage> createState() => _DestinationListPageState();
}

class _DestinationListPageState extends State<DestinationListPage> {
  final DestinationRepository repository = DestinationRepository();

  late Future<List<Destination>> _futureDestinations;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  /// ===============================
  /// LOAD DATA DARI REPOSITORY
  /// ===============================
  void _loadData() {
    _futureDestinations = repository.getDestinations();
  }

  /// ===============================
  /// REFRESH SETELAH TAMBAH / EDIT / HAPUS
  /// ===============================
  Future<void> _refresh() async {
    setState(() {
      _loadData();
    });
  }

  /// ===============================
  /// BOTTOM SHEET EDIT / DELETE
  /// ===============================
  void _showOptions(Destination destination) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text("Edit"),
            onTap: () async {
              Navigator.pop(context);
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DestinationFormPage(destination: destination),
                ),
              );
              if (result == true) _refresh();
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text("Hapus"),
            onTap: () async {
              await repository.deleteDestination(destination.id!);
              Navigator.pop(context);
              _refresh();
            },
          ),
        ],
      ),
    );
  }

  /// ===============================
  /// UI
  /// ===============================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Destinasi'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DestinationFormPage(),
                ),
              );
              if (result == true) _refresh();
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Destination>>(
        future: _futureDestinations,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Belum ada destinasi"));
          }

          final destinations = snapshot.data!;

          return ListView.builder(
            itemCount: destinations.length,
            itemBuilder: (context, index) {
              final d = destinations[index];
              return ListTile(
                title: Text(d.name),
                subtitle: Text(d.description),
                trailing: IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () => _showOptions(d),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DestinationDetailPage(destination: d),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

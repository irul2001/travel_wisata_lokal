import 'package:flutter/material.dart';
import 'package:travel_wisata_lokal/presentation/pages/destination_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Wisata Lokal',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        hintColor: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selamat Datang di Travel Wisata Lokal"),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Naik ke halaman daftar destinasi
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DestinationListPage()),
            );
          },
          child: Text("Masuk"),
        ),
      ),
    );
  }
}

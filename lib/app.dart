import 'package:flutter/material.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/destination_list_page.dart';
import 'presentation/pages/destination_form_page.dart';
import 'presentation/pages/map_page.dart';
import 'routes/app_routes.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Wisata Lokal',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (context) => HomePage(),
        AppRoutes.destinationForm: (context) => DestinationFormPage(),
      },
    );
  }
}

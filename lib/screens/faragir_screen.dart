import 'package:flutter/material.dart';
import '../navigation/app_drawer.dart';
//------------------------------------------------------------------------------------------------------------------------------

class FaragirScreen extends StatefulWidget {
  // ---------------- feilds ------------------
  static const routeName = '/faragir';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<FaragirScreen> createState() => _FaragirScreenState();
}

class _FaragirScreenState extends State<FaragirScreen> {
  // ---------------- state ------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget._scaffoldKey,
      appBar: AppBar(
        title: const Text('داشبورد فراگیر', style: TextStyle(fontSize: 18)),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () => widget._scaffoldKey.currentState!.openDrawer(),
        ),
      ),
      drawer: const AppDrawer(),
    );
  }
}

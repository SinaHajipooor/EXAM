import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/exams_overview_screen.dart';
import '../providers/Auth.dart';
import '../screens/login_screen.dart';
import '../screens/profile_screen.dart';

//---------------------------------------------------------------------------------------------
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(
          title: const Text('داشبورد فراگیر', style: TextStyle(fontSize: 17)),
          automaticallyImplyLeading: false,
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('پروفایل'),
          onTap: () {
            Navigator.of(context).pushNamed(ProfileScreen.routeName);
          },
        ),
        const Divider(),
        ListTile(
          leading: Icon(Icons.quiz, color: Colors.orange[200]),
          title: const Text('آزمون ها'),
          onTap: () {
            Navigator.of(context).pushNamed(ExamsOverviewScreen.routeName);
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.exit_to_app, color: Colors.red),
          title: const Text('خروج از حساب  کاربری'),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
            Provider.of<Auth>(context, listen: false).logout();
          },
        ),
      ]),
    );
  }
}

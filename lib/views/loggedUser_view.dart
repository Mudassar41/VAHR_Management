import 'package:expense_trackr/models/dashboard.dart';
import 'package:expense_trackr/views/auth_view.dart';
import 'package:expense_trackr/views/dash_board.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoggedUserView extends StatefulWidget {
  const LoggedUserView({super.key});

  @override
  State<LoggedUserView> createState() => _LoggedState();
}

class _LoggedState extends State<LoggedUserView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.data == null) {
                return const LoginView();
              } else {
                return const DasboardView();
              }
            }
          })),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/app/home/permission_controller.dart';
import 'package:flutter_steps_tracker/app/login_page/sign_in_page.dart';
import 'package:flutter_steps_tracker/services/auth.dart';
import 'package:flutter_steps_tracker/services/database.dart';
import 'package:flutter_steps_tracker/widgets/loading_screen.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<UserModel?>(
      stream: auth.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          UserModel? user = snapshot.data;
          if (user == null) {
            return SignInPage.create(context);
          }
          return FutureBuilder<String>(
              future: auth.currentUserName(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const LoadingScreen();
                }
                return Provider<UserModel>.value(
                  value: UserModel(displayName: snapshot.data, uid: user.uid),
                  child: Provider<Database>(
                    create: (_) => FirestoreDatabase(uid: user.uid!),
                    child: const PermissionController(),
                  ),
                );
              });
        } else {
          return const Scaffold(body: LoadingScreen());
        }
      },
    );
  }
}

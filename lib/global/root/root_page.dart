import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/app/cubit/auth_cubit.dart';
import 'package:user_app/features/base/presentation/pages/base_page.dart';
import 'package:user_app/pages/welcome.dart';
import 'package:user_app/service_locator/service_locator.dart';


class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  FirebaseMessaging firebaseMessaging = locator<FirebaseMessaging>();

  @override
  void initState() {
    super.initState();
    firebaseMessaging.getInitialMessage().then(
          (value) => setState(
            () {
              // _resolved = true;
              // initialMessage = value?.data.toString();
            },
          ),
        );
    // FirebaseMessaging.onMessage.listen(showFlutterNotification);
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // print('A new onMessageOpenedApp event was published!');
      // Navigator.pushNamed(
      //   context,
      //   '/message',
      //   arguments: MessageArguments(message, true),
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    // final AuthService authService = locator<AuthService>();

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state.user == null) {
          return const Welcome();
        } else {
          return const BasePage();
        }
      },
    );
  }
}

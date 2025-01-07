import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/constant/app_constant.dart';
import 'package:user_app/custom/text_custom.dart';
import 'package:user_app/features/home/presentation/Home.dart';
import 'package:user_app/features/map-page/presentation/pages/map_page.dart';
import 'package:user_app/features/notifications/presnetation/pages/notification_page.dart';
import 'package:user_app/features/profile/presentation/pages/profile.dart';
import 'package:user_app/features/setting/presnetation/pages/settings.dart';
import 'package:user_app/features/wallet/presentation/pages/walle.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  // List<Widget> pages = [
  //   const Home(),
  //   const Home(),
  //   const Home(),
  // ];
  // int currentIndex = 0;
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       leading: const Text(''),
  //       title: TextCustomWidget(
  //         text: "Hi user welcome!",
  //         fontWeight: FontWeight.w800,
  //         fontSize: 17.sp,
  //       ),
  //       backgroundColor: whiteCOlor,
  //       surfaceTintColor: whiteCOlor,
  //       elevation: 2.sp,
  //       shadowColor: Colors.grey,
  //     ),
  //     body: pages[currentIndex],
  //     bottomNavigationBar: BottomNavigationBar(
  //         onTap: (value) {
  //           setState(() {
  //             currentIndex = value;
  //           });
  //         },
  //         items: const [
  //           BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: ""),
  //           BottomNavigationBarItem(icon: Icon(CupertinoIcons.map), label: ""),
  //           BottomNavigationBarItem(icon: Icon(CupertinoIcons.bus), label: ""),
  //           BottomNavigationBarItem(
  //               icon: Icon(CupertinoIcons.settings), label: ""),
  //         ]),
  //   );
  // }

  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  Widget _getPage(int page) {
    switch (page) {
      case 0:
        return const Home();
      case 1:
        return const MapPage();
      case 2:
        return const SettingPage();
      case 3:
        return const Profile();

      default:
        return const Home();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: TextCustomWidget(
          text: 'Hi Swabeeh!',
          fontSize: 19.sp,
          fontWeight: FontWeight.w500,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WalletScreen(),
                    ));
              },
              icon: const Icon(
                Icons.wallet,
                color: Colors.red,
              )),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationPage(),
                    ));
              },
              icon: const Icon(
                Icons.notifications,
                color: Colors.red,
              )),
        ],
      ),
      backgroundColor: Colors.white,
      body: _getPage(_page),
      // ignore: deprecated_member_use
      bottomNavigationBar: CurvedNavigationBar(
        color: primaryColor.withOpacity(.3),
        backgroundColor: Colors.transparent,
        key: _bottomNavigationKey,
        index: _page,
        height: 60,
        items: <Widget>[
          Icon(
            CupertinoIcons.home,
            size: 25,
            color: (_page == 0) ? Colors.white : Colors.red,
          ),
          Icon(
            CupertinoIcons.map,
            size: 25,
            color: (_page == 1) ? Colors.white : Colors.red,
          ),
          Icon(
            CupertinoIcons.settings,
            size: 25,
            color: (_page == 2) ? Colors.white : Colors.red,
          ),
          Icon(
            CupertinoIcons.person,
            size: 25,
            color: (_page == 3) ? Colors.white : Colors.red,
          ),
        ],
        // ignore: deprecated_member_use
        buttonBackgroundColor: primaryColor.withOpacity(.3),
        animationCurve: Curves.easeInOut,
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}

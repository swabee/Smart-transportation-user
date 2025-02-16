import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user_app/constant/app_constant.dart';
import 'package:user_app/features/booking/presnetatioin/pages/all_booking/all_booking_page.dart';
import 'package:user_app/features/customer_setting/presentation/pages/customer_setting_page.dart';
import 'package:user_app/features/home/presentation/Home.dart';
import 'package:user_app/features/qr_scanner/qr_base_screen.dart';
import 'package:user_app/features/wallet/presentation/pages/walle.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final List<Widget> currentPage = [
    const Home(),
    const AllBookingPage(),
    const QrBaseScreen(),  // Add Offstage here
    const WalletScreen(),
    const CustomerSettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _page,
        children: currentPage,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _page = 2;
          });
        },
        backgroundColor: Colors.green,
        shape: const CircleBorder(),
        child: const Icon(Icons.qr_code_scanner, size: 32, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: primaryColor.withOpacity(.3),
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: CurvedNavigationBar(
          color: Colors.transparent,
          backgroundColor: Colors.transparent,
          key: _bottomNavigationKey,
          index: _page,
          height: 60,
          items: <Widget>[
            Icon(
              CupertinoIcons.home,
              size: 25,
              color: (_page == 0) ? Colors.lightGreen : Colors.green,
            ),
            Icon(
              CupertinoIcons.map,
              size: 25,
              color: (_page == 1) ? Colors.lightGreen : Colors.green,
            ),
            const SizedBox.shrink(), // Empty space for the FAB
            Icon(
              Icons.wallet,
              size: 25,
              color: (_page == 3) ? Colors.lightGreen : Colors.green,
            ),
            Icon(
              CupertinoIcons.settings,
              size: 25,
              color: (_page == 4) ? Colors.lightGreen : Colors.green,
            ),
          ],
          buttonBackgroundColor: primaryColor.withOpacity(.3),
          animationCurve: Curves.easeInOut,
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
      ),
    );
  }
}

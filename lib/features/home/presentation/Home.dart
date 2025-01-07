import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/constant/app_constant.dart';
import 'package:user_app/custom/button_custom.dart';
import 'package:user_app/custom/container_custom.dart';
import 'package:user_app/custom/textfield_custom.dart';
import 'package:user_app/features/booking/presnetatioin/pages/booking_page.dart';
import 'package:user_app/features/home/widgets/date_pick_list.dart';
import 'package:user_app/features/home/widgets/offer_tile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteCOlor,

      body: Column(
        children: [
          ContainerCustom(
            marginTop: 50.h,
            child: Column(
              children: [
                TextFieldCustom(
                  width: 450.w,
                  fillColor: primaryColor.withOpacity(.1),
                  border: BorderSide(color: primaryColor),
                  borderRadius: BorderRadius.circular(13.sp),
                  labelText: 'Select Pickup',
                  textAlign: TextAlign.center,
                  labelstyle: TextStyle(
                    color: primaryColor,
                    letterSpacing: 1,
                  ),
                ),
                ContainerCustom(
                  marginRight: 20.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            CupertinoIcons.arrow_up_arrow_down_circle_fill,
                            size: 35.sp,
                            color: primaryColor,
                          ))
                    ],
                  ),
                ),
                TextFieldCustom(
                  marginTop: 0.h,
                  width: 450.w,
                  fillColor: primaryColor.withOpacity(.1),
                  border: BorderSide(color: primaryColor),
                  borderRadius: BorderRadius.circular(13.sp),
                  labelText: 'Select Destination',
                  textAlign: TextAlign.center,
                  labelstyle: TextStyle(
                    color: primaryColor,
                    letterSpacing: 1,
                  ),
                ),
                const DatePickList(),
                ContainerCustom(
                  marginLeft: 10.w,
                  child: Row(
                    children: [
                      ButtonCustom(
                        margin:
                            EdgeInsets.only(left: 30.w, right: 30, top: 20.h),
                        btnHeight: 40.h,
                        borderRadius: BorderRadius.circular(11.r),
                        btnWidth: 400.w,
                        textColor: whiteCOlor,
                        text: 'Search',
                        callback: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BookingPage(),
                              ));
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Divider(
            color: boarderPrimaryColor,
            thickness: 2.sp,
          ),
          ContainerCustom(
            height: 90.h,
            marginTop: 15.h,
            marginLeft: 10.w,
            marginRight: 10.w,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return const OfferTile();
              },
            ),
          )
        ],
      ),

      //   child: Container(
      //     color: Colors.white,
      //     child: Column(
      //       children: <Widget>[
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: <Widget>[
      //             IconButton(
      //               icon: const Icon(
      //                 Icons.person_outline,
      //                 color: Colors.white,
      //               ),
      //               onPressed: () {},
      //             ),
      //             IconButton(
      //               icon: const Icon(
      //                 Icons.person_outline,
      //                 size: 30,
      //                 color: Colors.white,
      //               ),
      //               onPressed: () {
      //               },
      //             ),
      //           ],
      //         ),
      //         const SizedBox(
      //           height: 10,
      //         ),
      //         Align(
      //           alignment: Alignment.topLeft,
      //           child: Padding(
      //             padding: const EdgeInsets.only(left: 8.0),
      //             child: RichText(
      //               text: const TextSpan(
      //                   children: [
      //                     TextSpan(
      //                         text: 'Hello, ',
      //                         style: TextStyle(
      //                             fontSize: 32,
      //                             fontWeight: FontWeight.w700,
      //                             color: Colors.red)),
      //                     TextSpan(text: 'Get your \nBUS TICKETS \nHERE!')
      //                   ],
      //                   style: TextStyle(
      //                       fontSize: 32,
      //                       fontWeight: FontWeight.w500,
      //                       color: Colors.black)),
      //             ),
      //           ),
      //         ),
      //         const SizedBox(
      //           height: 20,
      //         ),
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: <Widget>[
      //             ElevatedButton(
      //               onPressed: () => {},
      //               // color: Colors.white,
      //               // padding: const EdgeInsets.all(10.0),
      //               child: const Column( // Replace with a Row for horizontal icon + text
      //                 children: <Widget>[
      //                   Icon(Icons.arrow_downward, color: Colors.red),
      //                   Text("Check In")
      //                 ],
      //               ),
      //             ),
      //             ElevatedButton(
      //               onPressed: (){
      //                 Navigator.push(context,
      //                     MaterialPageRoute(builder: (context) => directions()),);
      //               },
      //               // color: Colors.white,
      //               // padding: const EdgeInsets.all(10.0),
      //               child: const Column( // Replace with a Row for horizontal icon + text
      //                 children: <Widget>[
      //                   Icon(Icons.directions, color: Colors.red),
      //                   Text("Directions")
      //                 ],
      //               ),
      //             ),
      //             ElevatedButton(
      //               onPressed: () => {},
      //               // color: Colors.white,
      //               // padding: const EdgeInsets.all(10.0),
      //               child: const Column( // Replace with a Row for horizontal icon + text
      //                 children: <Widget>[
      //                   Icon(Icons.directions_bus, color: Colors.red),
      //                   Text("Prev Rides")
      //                 ],
      //               ),
      //             ),
      //             ElevatedButton(
      //               onPressed: () {
      //               Navigator.push(
      //               context,
      //               MaterialPageRoute(builder: (context) => complaints()),);
      //               },
      //               // color: Colors.white,
      //               // padding: const EdgeInsets.all(10.0),
      //               child: const Column( // Replace with a Row for horizontal icon + text
      //                 children: <Widget>[
      //                   Icon(Icons.bookmark, color: Colors.red),
      //                   Text("Complaints")
      //                 ],
      //               ),
      //             ),
      //           ],
      //         ),
      //         const SizedBox(
      //           height: 10,
      //         ),
      //         const Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: <Widget>[
      //             Padding(
      //               padding: EdgeInsets.only(left: 8.0),
      //               child: Text(
      //                 'RIDES',
      //                 style:
      //                     TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      //               ),
      //             ),
      //           ],
      //         ),
      //         const SizedBox(
      //           height: 10,
      //         ),
      //         Expanded(child: Container(child: const ImageCards())),
      //         const SizedBox(
      //           height: 25,
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}

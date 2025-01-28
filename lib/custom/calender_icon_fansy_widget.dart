// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:user_app/custom/container_custom.dart';

// class CalenderIconFansyWidget extends StatelessWidget {
//   const CalenderIconFansyWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ContainerCustom(
//       width: 100.w,
//       height: 100.h,
//       child: Stack(
//         alignment: Alignment.bottomCenter,
//         children: [
//           ContainerCustom(
//             height: 95.sp,
//             width: 95.w,
//             child: Image.asset(
//               ImagePath.calenderImage,
//               height: 95.sp,
//               width: 95.w,
//               fit: BoxFit.cover,
//             ),
//           ),
//           ContainerCustom(
//             borderRadius: BorderRadius.circular(12.r),
//             marginBottom: 8.h,
//             height: 49.sp,
//             width: 75.w,
//             bgColor: const Color.fromARGB(255, 255, 185, 73),
//             child: Column(
//               children: [
//                 TextCustomWidget(
//                   containerAlignment: Alignment.center,
//                   text: 'December',
//                   fontSize: 12.sp,
//                   fontWeight: FontWeight.w600,
//                 ),
//                 TextCustomWidget(
//                   textColor: whiteColor,
//                   containerAlignment: Alignment.center,
//                   text: '21',
//                   fontSize: 20.sp,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ],
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               IconButton(
//                   onPressed: () {},
//                   icon: Icon(
//                     Icons.edit,
//                     size: 15.sp,
//                     color: primary300,
//                   )),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

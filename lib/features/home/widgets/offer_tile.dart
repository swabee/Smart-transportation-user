import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/constant/app_constant.dart';
import 'package:user_app/custom/container_custom.dart';
import 'package:user_app/custom/text_custom.dart';

class OfferTile extends StatelessWidget {
  const OfferTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerCustom(
      // margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),

      // border: Border.all(color: boarderPrimaryColor),
      child: DottedBorder(dashPattern: const [3,5],
        strokeWidth: 2.w,
        radius: Radius.circular(132.r),
        color: primaryOfferColor.withOpacity(.7),
        child: ContainerCustom(
          height: 70.h,
          margin: EdgeInsets.all(6.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCustomWidget(
                    marginTop: 10.h,
                    text: "Get upto 30% offer",
                    textColor: primaryOfferColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                  ),
                  TextCustomWidget(
                    text:
                        "for superfast and ordinary bus for your first booking",
                    textColor: primaryOfferColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ],
              ),
              SizedBox(
                width: 10.w,
              ),
              Icon(
                CupertinoIcons.percent,
                color: primaryOfferColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}

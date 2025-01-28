import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/app/cubit/auth_cubit.dart';
import 'package:user_app/app/domain/usecase/get_current_user_usecase.dart';
import 'package:user_app/features/booking/data/cubit/all_booking_cubit.dart';
import 'package:user_app/features/customer_setting/customer_profile/presentation/bloc/user_data_bloc.dart';
import 'package:user_app/features/home/presentation/search-for-booking-cubit/search_for_booking_cubit.dart';
import 'package:user_app/global/root/root_page.dart';
import 'package:user_app/service_locator/service_locator.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      child: BlocProvider(
        create: (context) => AuthCubit(
          locator<GetCurrentUserUsecase>(),
        ),
        child: Builder(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                     BlocProvider(
                  create: (context) => UserDataBloc(
                    authCubit: context.read<AuthCubit>(),
                  ),
                  lazy: false,
                ),
                BlocProvider(
                  create: (context) => SearchForBookingCubit(),
                  lazy: false,
                ),
                BlocProvider(
                  create: (context) => AllBookingCubit(),
                  lazy: false,
                ),
                // BlocProvider(
                //   create: (context) => AppDataBloc(
                //     authCubit: context.read<AuthCubit>(),
                //   ),
                //   lazy: false,
                // ),
              ],
              child: MaterialApp(
                theme: ThemeData(
                    scaffoldBackgroundColor: Colors.white,
                    appBarTheme:
                        const AppBarTheme(backgroundColor: Colors.white)),
                // localizationsDelegates: AppLocalizations.localizationsDelegates,
                // supportedLocales: AppLocalizations.supportedLocales,
                home: const RootPage(),
              ),
            );
          },
        ),
      ),
    );
  }
}

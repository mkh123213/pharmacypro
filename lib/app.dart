import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacypro/core/app/app_cubit/app_cubit.dart';
import 'package:pharmacypro/core/app/connectivity_controller.dart';
import 'package:pharmacypro/core/di/dependency_injection.dart';
import 'package:pharmacypro/core/language/app_localizations_setup.dart';
import 'package:pharmacypro/core/routing/app_names_routers.dart';
import 'package:pharmacypro/core/screens/no_network_screen.dart';
import 'package:pharmacypro/core/services/shared_pref/pref_keys.dart';
import 'package:pharmacypro/core/services/shared_pref/shared_pref.dart';
import 'package:pharmacypro/core/style/theme/app_theme.dart';

class PharmaChainApp extends StatelessWidget {
  const PharmaChainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ConnectivityController.instance.isConnected,
      builder: (_, value, _) {
        if (value) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<AppCubit>()
                  ..changeAppThemeMode(
                    sharedMode: SharedPref().getBoolean(PrefKeys.themeMode),
                  )
                  ..getSavedLanguage(),
              ),
            ],
            child: ScreenUtilInit(
              designSize: const Size(375, 812),
              minTextAdapt: true,
              child: BlocBuilder<AppCubit, AppState>(
                buildWhen: (previous, current) {
                  return previous != current;
                },
                builder: (context, state) {
                  final cubit = context.read<AppCubit>();
                  return MaterialApp.router(
                    title: 'Asroo Store',
                    debugShowCheckedModeBanner: false,
                    theme: themeLight(),
                    locale: Locale(cubit.currentLangCode),
                    supportedLocales: AppLocalizationsSetup.supportedLocales,
                    localizationsDelegates:
                        AppLocalizationsSetup.localizationsDelegates,
                    localeResolutionCallback:
                        AppLocalizationsSetup.localeResolutionCallback,
                    builder: (context, widget) {
                      return GestureDetector(
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        child: Scaffold(
                          body: Builder(
                            builder: (context) {
                              ConnectivityController.instance.init();
                              return widget!;
                            },
                          ),
                        ),
                      );
                    },
                    routerConfig: appRouter,
                  );
                },
              ),
            ),
          );
        } else {
          return MaterialApp(
            title: 'No NetWork ',
            debugShowCheckedModeBanner: false,
            home: const NoNetWorkScreen(),
          );
        }
      },
    );
  }
}

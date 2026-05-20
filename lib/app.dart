import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import './core/app/app_cubit/app_cubit.dart';
import './core/app/connectivity_controller.dart';
import './core/di/dependency_injection.dart';
import './core/language/app_localizations_setup.dart';
import './core/routing/app_names_routers.dart';
import './core/screens/no_network_screen.dart';
import './core/services/shared_pref/pref_keys.dart';
import './core/services/shared_pref/shared_pref.dart';
import './core/style/theme/app_theme.dart';

class PharmaChainApp extends StatelessWidget {
  const PharmaChainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: ConnectivityController.instance.isConnected,
      builder: (_, isConnected, _) {
        if (!isConnected) {
          return MaterialApp(
            title: 'PharmaChain',
            debugShowCheckedModeBanner: false,
            home: const NoNetWorkScreen(),
          );
        }

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
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                final cubit = context.read<AppCubit>();

                return MaterialApp.router(
                  title: 'PharmaChain',
                  debugShowCheckedModeBanner: false,
                  theme: themeLight(),
                  locale: Locale(cubit.currentLangCode),
                  supportedLocales: AppLocalizationsSetup.supportedLocales,
                  localizationsDelegates:
                      AppLocalizationsSetup.localizationsDelegates,
                  localeResolutionCallback:
                      AppLocalizationsSetup.localeResolutionCallback,
                  routerConfig: appRouter,
                  builder: (context, widget) {
                    ConnectivityController.instance.init();

                    return GestureDetector(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: widget ?? const SizedBox.shrink(),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import './core/app/app_cubit/app_cubit.dart';
import './core/app/connectivity_controller.dart';
import './core/di/dependency_injection.dart';
import './core/common/widgets/offline_indicator_banner.dart';
import './core/language/app_localizations_setup.dart';
import './core/routing/app_names_routers.dart';
import './core/screens/no_network_screen.dart';
import './core/style/theme/app_theme.dart';
import './features/auth/presentation/cubit/auth_cubit.dart';

class PharmaChainApp extends StatefulWidget {
  const PharmaChainApp({super.key});

  @override
  State<PharmaChainApp> createState() => _PharmaChainAppState();
}

class _PharmaChainAppState extends State<PharmaChainApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = createAppRouter(getIt<AuthCubit>());
  }

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => getIt<AppCubit>()
              ..getSavedThemeMode()
              ..getSavedLanguage(),
          ),
          BlocProvider.value(value: getIt<AuthCubit>()),
        ],
        child: BlocBuilder<AppCubit, AppState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            final cubit = context.read<AppCubit>();

            return MaterialApp.router(
              title: 'PharmaChain',
              debugShowCheckedModeBanner: false,
              theme: themeLight(),
              darkTheme: themeDark(),
              themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
              locale: Locale(cubit.currentLangCode),
              supportedLocales: AppLocalizationsSetup.supportedLocales,
              localizationsDelegates:
                  AppLocalizationsSetup.localizationsDelegates,
              localeResolutionCallback:
                  AppLocalizationsSetup.localeResolutionCallback,
              routerConfig: _router,
              builder: (context, widget) {
                ConnectivityController.instance.init();

                return ValueListenableBuilder<bool>(
                  valueListenable: ConnectivityController.instance.isConnected,
                  builder: (_, isConnected, __) {
                    return Scaffold(
                      body: Column(
                        children: [
                          if (!isConnected) const OfflineIndicatorBanner(),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                              child: widget ?? const SizedBox.shrink(),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

import 'package:kobo_kobo/providers.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

class ProductApp extends StatefulWidget {
  const ProductApp({super.key});

  @override
  State<ProductApp> createState() => _ProductAppState();
}

class _ProductAppState extends State<ProductApp> {
  final ukAudRouter = getBaseRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      builder: (context, child) => OverlaySupport.global(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: MultiProvider(
            providers: providers,
            child: MaterialApp.router(
              title: 'Kobo Kobo',
              theme: AppTheme.defaultTheme(context),
              debugShowCheckedModeBanner: false,
              routerConfig: ukAudRouter,
              builder: (context, child) {
                return child!;
              },
            ),
          ),
        ),
      ),
    );
  }
}

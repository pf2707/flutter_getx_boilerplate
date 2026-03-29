import 'package:app_links/app_links.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getx_boilerplate/global_binding.dart';
import 'package:flutter_getx_boilerplate/manager/ads_manager.dart';
import 'package:flutter_getx_boilerplate/manager/setting_manager.dart';
import 'package:flutter_getx_boilerplate/screen/dashboard/dashboard_screen.dart';
import 'package:flutter_getx_boilerplate/service/restful_data_provider.dart';
import 'package:flutter_getx_boilerplate/support/navigation_helper.dart';
import 'package:flutter_getx_boilerplate/utils/helper.dart';
import 'package:flutter_getx_boilerplate/utils/my_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    runApp(const EntranceApp());
  } else {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarBrightness: Brightness.light) // Or Brightness.dark
    );
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) async {
      // resignKeyboard();

      await Firebase.initializeApp();
      await AdsManager.shared.prepare();
      await SettingManager.shared.prepare();
      await RestfulDataProvider.shared.initProvider();

      _handleAppLinks();
      runApp(const EntranceApp());
    });
  }
}

_handleAppLinks() async {
  final appLinks = AppLinks();

  // Handle link when app is already open
  appLinks.uriLinkStream.listen((uri) {
    _handleDeepLink(uri);
  });

  // Handle link when app is launched from closed/killed state
  final initialUri = await appLinks.getInitialLink();
  if (initialUri != null) {
    _handleDeepLink(initialUri);
  }
}

void _handleDeepLink(Uri uri) {
  // Example: <your_scheme>://join?code=ABC123  or  https://<your-domain>/join?code=ABC123
  if (uri.host.contains('your_scheme') || uri.host.contains('your-domain')) {
    if (uri.pathSegments.contains('join') || uri.queryParameters.containsKey('code')) {
      final code = uri.queryParameters['code']?.toUpperCase() ?? '';
      if (code.isNotEmpty) {
        // Navigate to join screen and pass code
        debugLog('Join with code: $code');
        // Your logic here: join the match via API or socket
        NavigationHelper.goToScreenA(code: code);
      }
    }
  }
}

class AppBuilder extends StatefulWidget {
  final Function(BuildContext) builder;

  const AppBuilder(
      {super.key, required this.builder});

  @override
  AppBuilderState createState() => AppBuilderState();

  static void restart(BuildContext context) {
    return context.findAncestorStateOfType<AppBuilderState>()?.rebuild();
  }
}

class AppBuilderState extends State<AppBuilder> {
  Key key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.builder(context),
    );
    // return widget.builder(context);
  }

  void rebuild() {
    setState(() {
      key = UniqueKey();
    });
  }
}

class EntranceApp extends StatefulWidget {
  const EntranceApp({super.key});

  @override
  State<EntranceApp> createState() => _EntranceAppState();
}

class _EntranceAppState extends State<EntranceApp> {

  DashboardScreen? _dashboardScreen;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NavigationHelper.initialize(NavigationIdentifier.screenDashboard);
  }

  @override
  Widget build(BuildContext context) {
    return AppBuilder(
      builder: (ctx) => ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        child: Obx(() => GetMaterialApp(
          useInheritedMediaQuery: true,
          title: 'Justice Scale',
          locale: Locale(SettingManager.shared.appLanguageCode.value),
          fallbackLocale: Locale(SettingManager.shared.appLanguageCode.value),
          translations: MyLocalization(),
          debugShowCheckedModeBanner: false,
          initialBinding: GlobalBind.shared,
          routes: {
            '/': (context) {
              return _dashboardScreen ??= const DashboardScreen();
            },
          }
        )),
      ),
    );
  }
}
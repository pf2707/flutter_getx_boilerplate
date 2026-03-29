# flutter_getx_boilerplate

Boilerplate to start a brand new project using GetX state management

## Getting Started

This project is a starting point for a Flutter application.

## Instruction

### Android
- Go to `android/app/build.gradle.kts`, change `applicationId`
- Go to `AndroidManifest.xml` and find `android:label` to change App Name
- Generate keystore for submission
```
keytool -genkey -v -keystore <output path. ex: ~/Downloads/keystore.jks> -keyalg RSA -keysize 2048 -validity 10000 -alias <name the key alias. ex: keyxyz>
```
   then generate pkcs12 keystore
```
keytool -importkeystore -srckeystore <path of original keystore> -destkeystore <output path pkcs12 keystore> -deststoretype pkcs12
```

### iOS
- Configure bundleId on XCode project
- Update App Name and App Icons

### Splashscreen
- For iOS, go to XCode and configure directly on LaunchScreen.storyboard
- For Android, go to `pubspec.yaml`, section `flutter_native_splash`
  + Configure all parameters
  + Run command
    ```
    dart run flutter_native_splash:create
    ```
    
### Font
- Add font resource files to folder `assets/font`.
- Go to `pubspec.yaml`, section `font`
- Go to `lib/utils/common_utils.dart` to configure your font methods

### Firebase
- Run flutterfire command for automatically configuration from Firebase
```
flutterfire configure
```
- If you want to connect more than two Firebase projects for different environments, use this code to check which is current env
```
final firebaseProjectId = DefaultFirebaseOptions.currentPlatform.projectId;
if (firebaseProjectId == "<firebase_production_project_id") {
  // Production
  ... Do you task
} else {
  // Other environments such as Staging, Dev, ...
  ... Do you task
}
```

### Localization
- Add new localization file to folder `lib/utils/localization`
- Go to `lib/utils/my_localization.dart` to configure new language

### Universal Links
- Go to `https://pub.dev/packages/app_links` for discrete configuration for each platform `ios` and `android`
- Go to `lib/main.dart`, look for method `_handleDeepLink(Uri uri)` to handle arrived universal links

### Google Ads Mob
- Update Google Ads AppId
  - For Android, go to `AndroidManifest.xml` and find the meta-data tag
  ```
    <meta-data
        android:name="com.google.android.gms.ads.APPLICATION_ID"
        android:value="ca-app-pub-xxxxxxxxxxxxxx~yyyyyyyyy"/>
  ```
  - For iOS, go to `Info.plist`, and find property `GADApplicationIdentifier`
- Update Ads Ids for Banner, Interstitial Ads, Reward Ads,... on `lib/constant/ads_constant.dart`
- Update Test Device Id on `lib/manager/ads_manager.dart`
- View `lib/screen/a/a_controller.dart` and `lib/screen/a/a_screen.dart` for more detail how to show ads
- Note: BannerAds should be wrapped inside Stack widget

### Others
- Provide Firebase Firestore data listener to handle data change from firestore. View `lib/service/firebase_data_listener.dart` for more detail
- Provide API Restful communication via `lib/service/restful_data_provider.dart` and `lib/service/restful_data_provider_impl.dart`
- Provide some widgets such as
  - Animated fade / scale text
  - Curve Word
  - Fireworks
  - Blinking widget
  - Some helpful extension on `lib/utils/helper.dart`
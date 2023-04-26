import 'dart:convert';
import 'package:deasy_config/deasy_config.dart';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/routes/bumblebee_app_routes.dart';
import 'package:kreditplus_deasy_mobile/core/constant/enum.dart';
import 'package:newwg/config/data_config.dart';
/// Initialize firebase messaging
final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;


class FirebaseConfig {

  static Future<void> initialMessageHandler() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
  }


  static Future<void> showLocalNotification(RemoteMessage message) async {
    if (message.data['image'] != null) {
        final ByteArrayAndroidBitmap largeIcon = ByteArrayAndroidBitmap(
            await _getByteArrayFromUrl('${message.data['image']}'));
        final ByteArrayAndroidBitmap bigPicture = ByteArrayAndroidBitmap(
            await _getByteArrayFromUrl('${message.data['image']}'));

        final BigPictureStyleInformation bigPictureStyleInformation =
            BigPictureStyleInformation(bigPicture,
            htmlFormatContentTitle: true,
            htmlFormatSummaryText: true);
        final AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails(
                'high_importance_channel', // id
                'High Importance Notifications', // title
                styleInformation: bigPictureStyleInformation);
        final NotificationDetails platformChannelSpecifics =
            NotificationDetails(android: androidPlatformChannelSpecifics);
        await flutterLocalNotificationsPlugin.show(
          message.ttl!,
          message.notification!.title,
          message.notification!.body,
          platformChannelSpecifics,
          payload: jsonEncode(message.data),
        );
      } else {
        flutterLocalNotificationsPlugin.show(
          message.ttl!,
          message.notification!.title,
          message.notification!.body,
          platformChannelSpecifics,
          payload: jsonEncode(message.data),
        );
      }
  }

  static Future<void> showNotificationForeground() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async{
      await FirebaseConfig.showLocalNotification(message);
    });
  }
  static openNotificationForeground(NotificationResponse notificationResponse) {
    if (notificationResponse.payload == null) {
      return;
    }

    final Map<String, dynamic> data = jsonDecode(notificationResponse.payload!);
    if(data["action"] == ActionNotifType.EDIT_SUBMISSION.name){
      log("foreground: navigate to ubah pesanan $data");
      // navigate to ubah pesanan with prospect_id
      goToEditSubmission(data['prospect_id']);
    }
  }

  static Future<void> openNotificationOnTerminated() async {
    RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage == null ){
      return;
    }

    if(initialMessage.data["action"] == ActionNotifType.EDIT_SUBMISSION.name){
      log("terminated: navigate to ubah pesanan $initialMessage.data");
      // navigate to ubah pesanan with prospect_id
      goToEditSubmission(initialMessage.data['prospect_id']);
    }
  }


  /// Define a top-level named handler which background/terminated messages will
  /// call.
  ///
  /// To verify things are working, check out the native platform logs.
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();
    Map<String, dynamic> data = message.data;
    if (data.isNotEmpty) {
      log('PAYLOAD DATA : Navigate to other screen $data');
    }
    log('Handling a background message ${message.messageId}');
  }

  static Future<void> onMessageOpenApp() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      Map<String, dynamic> data = message.data;
      if (data.isEmpty) {
        return;
      }

      if(data["action"] == ActionNotifType.EDIT_SUBMISSION.name){
      log("background navigate to ubah pesanan: $data}");
      // todo: navigate to ubah pesanan with prospect_id
      goToEditSubmission(data['prospect_id']);
    }
    });
  }

  static goToEditSubmission(String prospectID) {
    DataConfig.instance.prospectId = prospectID;
    DataConfig.instance.isShowIndicator = false;
    DataConfig.instance.isEditOrder = true;
    Get.toNamed(
        BumblebeeRoutes.HUMAN_VERIFICATION_NEW_WG
    );
  }
}

Future<void> topLevelHandler() async {

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(FirebaseConfig.firebaseMessagingBackgroundHandler);

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
    onDidReceiveNotificationResponse: FirebaseConfig.openNotificationForeground,
  );

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await _firebaseMessaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  await _firebaseMessaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: false,
    criticalAlert: true,
    provisional: false,
    sound: true,
  );
}


/// Create a [AndroidNotificationChannel] for heads up notifications
const androidPlatformChannelSpecifics = AndroidNotificationDetails(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  icon: '@mipmap/ic_launcher',
  importance: Importance.max,
  priority: Priority.high,
  showWhen: false,
);

/// Initialize the [FlutterLocalNotificationsPlugin] package.
final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

const initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

final initializationSettingsIOS = DarwinInitializationSettings();

final initializationSettings = InitializationSettings(
  android: initializationSettingsAndroid,
  iOS: initializationSettingsIOS,
);

const platformChannelSpecifics = NotificationDetails(
  android: androidPlatformChannelSpecifics,
);


const channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  importance: Importance.max,
  showBadge: true,
);

Future<Uint8List> _getByteArrayFromUrl(String url) async {
  final http.Response response = await http.get(Uri.parse(url));
  return response.bodyBytes;
}
Future<dynamic> fcmSubscribe(String supplierId) async{
  if(!kIsWeb){
    final flavor = flavorConfiguration!.flavorName;
    final topic = "$flavor-orders-$supplierId";

    await _firebaseMessaging.subscribeToTopic(topic);
  }
}

Future<dynamic> fcmUnSubscribe(String supplierId) async{
   if(!kIsWeb){
    final flavor = flavorConfiguration!.flavorName;
    final topic = "$flavor-orders-$supplierId";

    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }
}

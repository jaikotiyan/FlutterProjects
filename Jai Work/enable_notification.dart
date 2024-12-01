import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:io/common/utils/colors.dart';
import 'package:io/common/router/locator.dart';
import '../../common/widgets/button_widget.dart';
import 'package:io/common/router/navigation_routes.dart';
import 'package:io/common/router/navigation_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:permission_handler/permission_handler.dart';

class EnableNotification extends StatefulWidget {
  const EnableNotification({super.key});

  @override
  State<EnableNotification> createState() => _EnableNotificationState();
}

class _EnableNotificationState extends State<EnableNotification> {
  Future<void> _openAppSettings() async {
    await openAppSettings();
    checkNotificatioStatus();
  }

  void checkNotificatioStatus() async {
    PermissionStatus? statusNotification = await Permission.notification.status;
    if (!statusNotification.isGranted) {
      await FirebaseAnalytics.instance.logEvent(name: 'allow_notification', parameters: {
        'status' : 'granted'
      });
      checkLocation();
    } else {
      locator<NavigationService>().clearAndNavigateTo(homeRoute);
      await FirebaseAnalytics.instance.logEvent(name: 'allow_notification', parameters: {
        'status' : 'denied'
      });
    }
  }

  checkLocation() async {
    locator<NavigationService>().navigateToReplace(homeRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Padding(
            padding: const EdgeInsets.all(24.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Spacer(),
              SvgPicture.asset("assets/images/enableNotification.svg"),
              const SizedBox(
                height: 24,
              ),
              Column(
                children: [
                  Text('Never miss important updates!',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontSize: 24, fontWeight: FontWeight.w700)),
                  const SizedBox(
                    height: 17,
                  ),
                  Text(
                      'Let us notify you when some one shares, request access or share documents.',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontFamily: "WorkSans-Medium.ttf",
                          fontSize: 16,
                          fontWeight: FontWeight.w400))
                ],
              ),
              const Spacer(),
              ButtonWidget("enableNotifications", () async {
                await Permission.notification.isDenied.then((value) async {
                  if (value) {
                    await Permission.notification.request();
                    checkNotificatioStatus();
                  }
                });
              }),
              TextButton(
                  onPressed: () {
                    checkLocation();
                  },
                  child: Text("May be later",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: AppColors.ff199FED,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.ff199FED,
                          )))
            ])));
  }
}

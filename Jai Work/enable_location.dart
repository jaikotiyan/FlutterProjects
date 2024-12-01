import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:io/common/utils/colors.dart';
import 'package:io/common/router/locator.dart';
import '../../common/widgets/button_widget.dart';
import 'package:io/common/router/navigation_routes.dart';
import 'package:io/common/router/navigation_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:permission_handler/permission_handler.dart';

class EnableLocation extends StatefulWidget {
  const EnableLocation({super.key});

  @override
  State<EnableLocation> createState() => _EnableLocation();
}

class _EnableLocation extends State<EnableLocation> {
  checkPermission() async {
    LocationPermission permission;
    await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      await FirebaseAnalytics.instance.logEvent(name: 'allow_location', parameters: {
        'status' : 'denied'
      });
      return Future.error('Location permissions are denied');
    }

    if (permission == LocationPermission.deniedForever) {
      openAppSettings();
      await FirebaseAnalytics.instance.logEvent(name: 'allow_location', parameters: {
        'status' : 'denied_forever'
      });
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    await FirebaseAnalytics.instance.logEvent(name: 'allow_location', parameters: {
      'status' : 'granted'
    });
    checkNotificatioStatus();
  }

  void checkNotificatioStatus() async {
    PermissionStatus? status = await Permission.notification.status;
    if (status != PermissionStatus.granted) {
      locator<NavigationService>().navigateTo(enableNotification);
    } else {
      locator<NavigationService>().clearAndNavigateTo(homeRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            SvgPicture.asset("assets/images/Location-Access.svg"),
            const SizedBox(
              height: 24,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Access to your location',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(fontSize: 24, fontWeight: FontWeight.w700)),
                const SizedBox(
                  height: 17,
                ),
                Text(
                    'Provide the location access so that we can find and bring the best doctors nearby your location.',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontFamily: "WorkSans-Medium.ttf",
                        fontSize: 16,
                        fontWeight: FontWeight.w400))
              ],
            ),
            const Spacer(),
            ButtonWidget("enableLocation", () async {
              checkPermission();
            }),
            TextButton(
                onPressed: () {
                  checkNotificatioStatus();
                },
                child: Text("May be later",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.ff199FED,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.ff199FED,
                        )))
          ],
        ),
      ),
    );
  }
}

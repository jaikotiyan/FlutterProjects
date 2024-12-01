import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:io/common/utils/colors.dart';
import '../../common/widgets/button_widget.dart';


class EnableCamera extends StatefulWidget {
  const EnableCamera({super.key});

  @override
  State<EnableCamera> createState() => _EnableCamera();
}

class _EnableCamera extends State<EnableCamera> {
  // PermissionStatus _cameraPermissionStatus = PermissionStatus.denied;

  // @override
  // void initState() {
  //   super.initState();
  //   _checkPermissionStatus();
  // }

  // Future<void> _checkPermissionStatus() async {
  //   final notificationStatus = await Permission.notification.status;
  //   setState(() {
  //     _notificationPermissionStatus = notificationStatus;
  //   });
  // }

  // Future<void> _openAppSettings() async {
  //   await openAppSettings();
  // }

  // Future<void> _requestNotificationPermission() async {
  //   final status = await Permission.notification.request();
  //   setState(() {
  //     _notificationPermissionStatus = status;
  //   });
  // }

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
            SvgPicture.asset("assets/images/light_camera_enable.svg"),
            const SizedBox(
              height: 24,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Allow Access to Photos',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(fontSize: 24, fontWeight: FontWeight.w700)),
                const SizedBox(
                  height: 17,
                ),
                Text(
                    'To upload your images and PDF files, please grant permission to access your camera and gallery.',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontFamily: "WorkSans-Medium.ttf",
                        fontSize: 16,
                        fontWeight: FontWeight.w400))
              ],
            ),
            const Spacer(),
            ButtonWidget("enableCamera", () {
              // _openAppSettings();
            }),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
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

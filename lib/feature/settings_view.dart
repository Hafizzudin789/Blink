import 'package:blink/widgets/custom_svg_image.dart';
import 'package:flutter/material.dart';
import '../constant/app_color.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import '../constant/constants.dart';


class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: (MediaQuery.of(context).size.height * 0.25)-bottomBarHeight, bottom: 30),
        child: FadingEdgeScrollView.fromScrollView(
          // shouldDisposeScrollController: true,
          gradientFractionOnStart: 0.35,
          gradientFractionOnEnd: 0.2,
          child: ListView(
            controller: _scrollController,
            children: [
              _settingMenuItem(label: "Freeze this card", iconPath: "assets/setting/freeze.svg"),
              _divider(),
              _settingMenuItem(label: "Manage card limits", iconPath: "assets/setting/cardLimit.svg"),
              _divider(),
              _settingMenuItem(label: "Manage card PIN", iconPath: "assets/setting/manage.svg"),
              _divider(),
              _settingMenuItem(label: "View card subscriptions", iconPath: "assets/setting/view.svg"),
              _divider(),
              _settingMenuItem(label: "Request supplementary card", iconPath: "assets/setting/request.svg"),
              _divider(),
              _settingMenuItem(label: "Change credit limit", iconPath: "assets/setting/addCircular.svg"),
              _divider(),
              _settingMenuItem(label: "Convert purchases to instalments", iconPath: "assets/setting/convert.svg"),
              _divider(),
              _settingMenuItem(label: "Change linked mobile number", iconPath: "assets/setting/mobile.svg"),
              _divider(),
              _settingMenuItem(label: "Change country restriction", iconPath: "assets/setting/globe.svg"),
              _divider(),
              _settingMenuItem(label: "Manage settlement", iconPath: "assets/setting/manageSettlement.svg"),
              _divider(),
              _settingMenuItem(label: "Report stolen or lost card", iconPath: "assets/setting/report.svg"),
              _divider(),
              _settingMenuItem(label: "Replace damaged card", iconPath: "assets/setting/damage.svg"),
              _divider(),
              _settingMenuItem(label: "Cancel this card", iconPath: "assets/setting/cancel.svg"),
            ],
          ),
        ),
      ),
    );
  }

  _settingMenuItem({required String label, required String iconPath, VoidCallback? onTap}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 42, vertical: 8),
      leading: SVGImage(assetPath: iconPath),
      onTap: () {
      },
      title: Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
    );
  }

  _divider() {
    return const Divider(color: dividerColor1, indent: 24, endIndent: 24, height: 0);
  }
}

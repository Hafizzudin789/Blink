import 'package:blink/widgets/custom_svg_image.dart';
import 'package:blink/widgets/icon_widget.dart';
import 'package:flutter/material.dart';
import '../../../constant/app_color.dart';
import '../../../constant/constants.dart';


class NewPostPaidBills extends StatefulWidget {
  const NewPostPaidBills({super.key});

  @override
  State<NewPostPaidBills> createState() => _NewPostPaidBillsState();
}

class _NewPostPaidBillsState extends State<NewPostPaidBills> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: (MediaQuery.of(context).size.height * 0.25)-bottomBarHeight, bottom: 20),
        child: ListView(
          children: [
            const Text("New Postpaid Bill", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black), textAlign: TextAlign.center,),
            const SizedBox(height: 16),
            _searchBar(),
            const SizedBox(height: 16),
            _settingMenuItem(label: "Asma", iconPath: "assets/icons/bills/asma.svg"),
            _divider(),
            _settingMenuItem(label: "Associations and Organizations", iconPath: "assets/icons/bill.svg"),
            _divider(),
            _settingMenuItem(label: "AYLA", iconPath: "assets/icons/bills/ayla.svg"),
            _divider(),
            _settingMenuItem(label: "Banks", iconPath: "assets/icons/bills/dollor.svg"),
            _divider(),
            _settingMenuItem(label: "Charities", iconPath: "assets/icons/bills/dollor.svg"),
            _divider(),
            _settingMenuItem(label: "eCommerce", iconPath: "assets/icons/bills/ecomerce.svg"),
            _divider(),
            _settingMenuItem(label: "Education", iconPath: "assets/icons/bills/drop.svg"),
            _divider(),
            _settingMenuItem(label: "eCommerce", iconPath: "assets/icons/bills/ecomerce.svg"),
            _divider(),
            _settingMenuItem(label: "Education", iconPath: "assets/icons/bills/ecomerce.svg"),

          ],
        ),
      ),
    );
  }


  _searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          hintText: "Search category",
          hintStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: gray400Color),
          suffixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0),
            child: SVGImage(assetPath: "assets/icons/search.svg"),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: gray300Color, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: gray300Color, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: gray300Color, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: gray300Color, width: 1),
          ),
        ),
      ),
    );
  }

  _settingMenuItem({required String label, required String iconPath, VoidCallback? onTap}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      leading: IconWidget(svgImage: iconPath),
      onTap: () {},
      title: Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
    );
  }

  _divider() {
    return const Divider(color: dividerColor1, indent: 0, endIndent: 0, height: 0);
  }
}

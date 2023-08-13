import 'package:blink/widgets/custom_svg_image.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import '../../../constant/app_color.dart';
import '../../../data.dart';
import '../../../widgets/check_box.dart';
import '../../../widgets/icon_widget.dart';
// import '../../dashboard/dashboard_view_model.dart';


class MyPostPaidBills extends StatefulWidget {
  const MyPostPaidBills({super.key});

  @override
  State<MyPostPaidBills> createState() => _MyPostPaidBillsState();
}

class _MyPostPaidBillsState extends State<MyPostPaidBills> {


  List<bool> _selectedList = [];
  @override
  void initState() {
    super.initState();
    _selectedList = List.filled(postPaidBills.length, false);
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //context.read<DashboardViewModel>().animateReverseTransactionPage();
        return true;
      },
      child: Scaffold(
        backgroundColor: blackColor,
        body: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text("My Bills", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white), textAlign: TextAlign.center,),
              ),
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 24),
                      padding: const EdgeInsets.only(top: 48),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)),
                      ),
                      child: CustomScrollView(
                        slivers: [
                          ///Search bar
                          SliverList(
                            delegate: SliverChildListDelegate(
                              [
                                Padding(
                                  padding: const EdgeInsets.only(right: 24, left: 24, bottom: 16),
                                  child: _searchBar(),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: gray100Color,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SVGImage(assetPath: "assets/icons/bulb.svg"),
                                        SizedBox(width: 8),
                                        Text(
                                          "Swipe any bill to the left to remove",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: gray400Color),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),


                          SliverList.separated(
                            itemCount: postPaidBills.length,
                            itemBuilder: (BuildContext context, int index) {
                              PostPaidBill bill =  postPaidBills[index];
                              return ListTile(
                                leading: IconWidget(svgImage: bill.iconPath),
                                title: Text(bill.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                                subtitle: Text(bill.subTitle, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
                                trailing: CheckBoxWidget(
                                  value: _selectedList[index],
                                  onChanged: (bool? value) {
                                    if(value != null) {
                                      setState(() {
                                        _selectedList[index] = value;
                                      });
                                    }
                                  },
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) => const Divider(color: dividerColor,),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      child: InkWell(
                        onTap: () {
                          // context.read<DashboardViewModel>().animateReverseTransactionPage();
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 48,
                          width: 48,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(color: gray200Color, width: 1),
                              boxShadow: const [
                                BoxShadow(color: Colors.black26, blurRadius: 5, spreadRadius: 0.1, offset: Offset(0, 4))
                              ]
                          ),
                          child: const SVGImage(assetPath: "assets/icons/down.svg"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _searchBar() {
    return TextField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        hintText: "Search bill",
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
    );
  }
}

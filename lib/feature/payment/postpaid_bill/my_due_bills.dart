import 'package:blink/feature/payment/payment/payment_view_model.dart';
import 'package:blink/widgets/custom_button.dart';
import 'package:blink/widgets/custom_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';
import '../../../constant/app_color.dart';
import '../../../data.dart';
import '../../../widgets/check_box.dart';
import '../../../widgets/icon_widget.dart';
import 'package:collection/collection.dart';


class MyDueBills extends StatefulWidget {
  const MyDueBills({super.key});

  @override
  State<MyDueBills> createState() => _MyDueBillsState();
}

class _MyDueBillsState extends State<MyDueBills> {

  List<bool> _selectedList = [];

  double totalDue = 0;
  @override
  void initState() {
    super.initState();
    _selectedList = List.filled(postPaidBills.length, true);
    totalDue = postPaidBills.map((e) => e.dueAmount).toList().sum;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<PaymentViewModel>().animateReverseUpAndScalePage();
        return true;
      },
      child: Scaffold(
        backgroundColor: blackColor,
        body: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text("Pay All Bills", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white), textAlign: TextAlign.center,),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: CustomScrollView(
                              slivers: [
                                ///Search bar
                                SliverList(
                                  delegate: SliverChildListDelegate(
                                    [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 24, left: 24, bottom: 24),
                                        child: _searchBar(),
                                      ),
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
                                      subtitle: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(bill.subTitle, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
                                          Text.rich(
                                            TextSpan(
                                              text: "Due",
                                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                                              children: [
                                                TextSpan(
                                                  text: " ${postPaidBills[index].dueAmount} JOD",
                                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)
                                                ),
                                              ]
                                            ),
                                          ),
                                          const Text.rich(
                                            TextSpan(
                                              text: "Fee",
                                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                                              children: [
                                                TextSpan(
                                                  text: " 5.00 JOD",
                                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)
                                                ),
                                              ]
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: CheckBoxWidget(
                                        value: _selectedList[index],
                                        onChanged: (bool? value) {
                                          if(value != null) {
                                            setState(() {
                                              _selectedList[index] = value;
                                              totalDue = getAllSelectedTotalDue();
                                            });
                                          }
                                        },
                                      ),
                                    );
                                  },
                                  separatorBuilder: (BuildContext context, int index) => const Divider(color: dividerColor),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 12),
                            child: CustomButton(
                              label: "Pay ${totalDue.toStringAsFixed(3)} JOD",
                              fontSize: 14,
                              verticalPadding: 16,
                              onTap: () {},
                              buttonColor: primaryButtonColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      child: InkWell(
                        onTap: () {
                          context.read<PaymentViewModel>().animateReverseUpAndScalePage();
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

  double getAllSelectedTotalDue() {
    List<PostPaidBill> selectedDueBills = postPaidBills.where((e) =>  _selectedList[postPaidBills.indexOf(e)]).toList();
    return selectedDueBills.map((e) => e.dueAmount).toList().sum;
  }
}

import 'package:blink/widgets/custom_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constant/app_color.dart';
import '../payment/payment_view_model.dart';


class PrePaidBillsHistory extends StatefulWidget {
  const PrePaidBillsHistory({super.key});

  @override
  State<PrePaidBillsHistory> createState() => _PrePaidBillsHistoryState();
}

class _PrePaidBillsHistoryState extends State<PrePaidBillsHistory> {
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
                child: Text("Bills History", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white), textAlign: TextAlign.center,),
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
                          SliverList(delegate: SliverChildListDelegate([
                            Padding(padding: const EdgeInsets.only(right: 24, left: 24, bottom: 16), child: _searchBar(),),
                          ]),),
                          SliverList(delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 16.0, horizontal: 24),
                                      child: Text(
                                        "12 September",
                                        style: TextStyle(
                                            color: blackColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 24),
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.shade200,
                                              blurRadius: 10,
                                              spreadRadius: 0.05,
                                              offset: const Offset(0,2)
                                          )
                                        ],
                                      ),
                                      child: ListView.separated(
                                        separatorBuilder: (context, index)=>const Divider(color: dividerColor, thickness: 1, height: 32),
                                        itemCount: 4,
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return const Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 24,
                                            ),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Prepaid Tariq",
                                                        style: TextStyle(
                                                            color: blackColor,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                      Text(
                                                        "8:32PM",
                                                        style: TextStyle(
                                                            color: gray300Color,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Align(
                                                    alignment: Alignment.centerRight,
                                                    child: Text.rich(TextSpan(
                                                        text: "-20.000",
                                                        style: TextStyle(
                                                            color: darkRedColor,
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w700),
                                                        children: [
                                                          TextSpan(
                                                            text: " JOD",
                                                            style: TextStyle(
                                                                color: gray300Color,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                FontWeight.w600),
                                                          )
                                                        ])),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                );
                              }, childCount: 10),
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
        hintText: "What are you looking for?",
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

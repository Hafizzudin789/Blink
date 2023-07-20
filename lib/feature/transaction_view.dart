import 'package:blink/widgets/custom_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constant/app_color.dart';
import 'dashboard/dashboard_view_model.dart';


class TransactionView extends StatefulWidget {
  const TransactionView({super.key});

  @override
  State<TransactionView> createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<DashboardViewModel>().animateReverseTransactionPage();
        return true;
      },
      child: Scaffold(
        backgroundColor: pinkColor,
        body: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 60),
                    Expanded(child: Text("My Credit Card", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white), textAlign: TextAlign.center,)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: SVGImage(assetPath: "assets/icons/download.svg"),
                    ),
                  ],
                ),
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
                                                      "Host International Inc Dubai AED 533.03",
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
                                                child: Column(
                                                  children: [
                                                    Text.rich(TextSpan(
                                                        text: "-102.900",
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
                                                    Text.rich(TextSpan(
                                                        text: "7,334.100",
                                                        style: TextStyle(
                                                            color: gray300Color,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w600),
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
                                                  ],
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
                          context.read<DashboardViewModel>().animateReverseTransactionPage();
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
    return Row(
      children: [
        Expanded(
          child: TextField(
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
          ),
        ),
        const SizedBox(width: 24),
        const SVGImage(assetPath: "assets/icons/filter.svg")
      ],
    );
  }
}

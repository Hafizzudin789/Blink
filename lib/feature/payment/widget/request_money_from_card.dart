import 'package:blink/feature/payment/payment_view_model.dart';
import 'package:blink/feature/payment/receive_money_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constant/app_color.dart';
import '../../../data.dart';
import '../../../widgets/custom_icon_button.dart';
import '../../../widgets/custom_svg_image.dart';
import '../../../widgets/elevated_button.dart';
import '../../dashboard/dashboard_view_model.dart';

class RequestMoneyFromCard extends StatelessWidget {
  final PaymentViewModel readPaymentViewModel;
  const RequestMoneyFromCard({super.key, required this.readPaymentViewModel});

  @override
  Widget build(BuildContext context) {
    double horizontalSpacing = MediaQuery.of(context).size.width * 0.035;
    return Container(
      margin: EdgeInsets.only(left: horizontalSpacing, right: horizontalSpacing, bottom: 44, top: 28),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: yellowColor,
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SVGImage(assetPath: "assets/icons/star.svg", color: Colors.black,),
                    SizedBox(width: 4),
                    Text("Request money from", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),),
                  ],
                ),
              ),
              CustomIconButton(
                svgIconPath: "assets/icons/add.svg",
                buttonColor: yellowColor,
                buttonBorderColor: lightYellowColor,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Flexible(
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 8,
              childAspectRatio: 0.85,
              children: [
                ...users.map((e) => InkWell(
                  onTap: () {
                    readPaymentViewModel.goToReceiveMoneyView(true, context.read<DashboardViewModel>());
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>const ReceiveMoneyView()));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(e.image),
                        radius: 32,
                      ),
                      Text(
                        e.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 10,
                          color: Colors.black
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ElevatedCustomButton(
            label: "See all contacts",
            buttonColor: yellowColor,
            buttonBorderColor: lightYellowColor,
            foregroundColor: blueColor,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

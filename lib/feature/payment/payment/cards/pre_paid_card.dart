import 'package:blink/feature/payment/payment/payment_view_model.dart';
import 'package:blink/feature/payment/prepaid_bill/pre_paid_bills_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../constant/app_color.dart';
import '../../../../utils/navigation_transitions.dart';
import '../../../../widgets/custom_icon_button.dart';
import '../../../../widgets/elevated_button.dart';


class PrePaidCard extends StatelessWidget {
  final PaymentViewModel readPaymentViewModel;
  const PrePaidCard({super.key, required this.readPaymentViewModel});

  @override
  Widget build(BuildContext context) {
    double horizontalSpacing = MediaQuery.of(context).size.width * 0.035;
    return Container(
      margin: EdgeInsets.only(left: horizontalSpacing, right: horizontalSpacing, bottom: 44, top: 28),
      padding: const EdgeInsets.only(right: 24, left: 24, bottom: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.black,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Text("My Prepaid Bill", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white),),
              ),
              CustomIconButton(
                onTap: () {
                  Navigator.of(context).push(slideBottomToTop(nextPage: const PrePaidBillsHistory()));
                },
                svgIconPath: "assets/icons/history.svg",
                buttonColor: blackColor,
                buttonBorderColor: borderColor,
                borderShadowColor: borderColor,
              ),
            ],
          ),


          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: yellowColor,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset("assets/image/logoeFawateer.svg"),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "How would you like to\npay your prepaid bills?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),


          ElevatedCustomButton(
            label: "Manage and pay my bills",
            buttonColor: Colors.black,
            buttonBorderColor: Colors.white,
            foregroundColor: Colors.white,
            buttonWidth: double.infinity,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

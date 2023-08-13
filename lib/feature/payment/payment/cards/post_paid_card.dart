import 'package:blink/feature/payment/payment/payment_view_model.dart';
import 'package:blink/feature/payment/postpaid_bill/my_due_bills.dart';
import 'package:blink/feature/payment/postpaid_bill/my_postpaid_bills.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../constant/app_color.dart';
import '../../../../utils/navigation_transitions.dart';
import '../../../../widgets/custom_icon_button.dart';
import '../../../../widgets/elevated_button.dart';
import '../../postpaid_bill/post_paid_bills_history.dart';


class PostPaidCard extends StatelessWidget {
  final PaymentViewModel readPaymentViewModel;
  const PostPaidCard({super.key, required this.readPaymentViewModel});

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
                child: Text("My Postpaid Bill", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white),),
              ),
              CustomIconButton(
                onTap: () {
                  Navigator.of(context).push(slideBottomToTop(nextPage: const PostPaidBillsHistory()));
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
                    color: pinkColor,
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
                  "How would you like to\npay your postpaid bills?",
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


          Column(
            children: [
              ElevatedCustomButton(
                onTap: () {
                  Navigator.of(context).push(slideBottomToTop(nextPage: const MyPostPaidBills()));
                },
                label: "view my bills",
                buttonColor: Colors.black,
                buttonBorderColor: Colors.white,
                foregroundColor: Colors.white,
                buttonWidth: double.infinity,
              ),
              const SizedBox(height: 8),
              ElevatedCustomButton(
                onTap: () {
                  Navigator.of(context).push(slideBottomToTop(nextPage: const MyDueBills()));
                },
                label: "view and pay your due bills",
                buttonColor: primaryButtonColor,
                buttonBorderColor: Colors.transparent,
                foregroundColor: Colors.white,
                buttonWidth: double.infinity,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

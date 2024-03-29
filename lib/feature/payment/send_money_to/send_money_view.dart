import 'package:auto_size_text/auto_size_text.dart';
import 'package:blink/constant/app_color.dart';
import 'package:blink/feature/payment/payment/payment_view_model.dart';
import 'package:blink/feature/payment/send_money_to/send_money_view_model.dart';
import 'package:blink/widgets/custom_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constant/constants.dart';
import '../../../utils/format_string_amout.dart';


class SendMoneyView extends StatefulWidget {
  const SendMoneyView({super.key});

  @override
  State<SendMoneyView> createState() => _SendMoneyViewState();
}

class _SendMoneyViewState extends State<SendMoneyView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SendMoneyViewModel>(
      create: (_) => SendMoneyViewModel(),
      builder: (context, child) {
        return Scaffold(
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            margin: EdgeInsets.only(top: (MediaQuery.of(context).size.height * 0.3)-bottomBarHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                context.watch<PaymentViewModel>().sendTo !=null
                    ? CircleAvatar(
                        backgroundImage: AssetImage(context.watch<PaymentViewModel>().sendTo!.image),
                        radius: 28,
                      )
                    : const SizedBox(height: 56),
                Text(context.watch<PaymentViewModel>().sendTo !=null?"Send money to":"Send money", style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),),
                context.watch<PaymentViewModel>().sendTo != null
                    ? Text(context.watch<PaymentViewModel>().sendTo!.name, style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),)
                    : const SizedBox(),

                context.watch<PaymentViewModel>().sendTo !=null
                    ? Container(
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        decoration: BoxDecoration(
                            border: Border.all(color: gray200Color),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Transaction Purpose", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: gray400Color),),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: Text("Personal\nTransfer to Friend or Family", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),)),
                                Text("Edit", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: primaryButtonColor),)
                              ],
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(height: 80),

                _amountTextField(context),

                _actualBalance(),

                _keyPad(context.read<SendMoneyViewModel>()),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _amountTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Row(
        children: [
          const SizedBox(width: 50),
          Expanded(
            child: AutoSizeText.rich(
              TextSpan(
                //text: formatStringToAmount(context.watch<SendMoneyViewModel>().actualAmount),
                text: context.watch<SendMoneyViewModel>().actualAmount,
                children: const [
                  TextSpan(
                    text: " JOD",
                    style: TextStyle(fontSize: 14, color: Color(0XFFBCBCBC), fontWeight: FontWeight.w700),
                  ),
                ]
              ),
              style: const TextStyle(fontSize: 32, color: Colors.black, fontWeight: FontWeight.w700),
              minFontSize: 20,
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              context.read<SendMoneyViewModel>().removeAmount();
            },
            child: const SVGImage(assetPath: "assets/icons/closeBack.svg", width: 20)),
        ],
      ),
    );
  }

  Widget _actualBalance() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Actual Balance", style: TextStyle(color: gray400Color, fontSize: 10, fontWeight: FontWeight.w600),),
          Text.rich(
            style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
            TextSpan(
              text: formatStringToAmount("123456.94"),
              children: const [
                TextSpan(
                  style: TextStyle(color: gray300Color, fontSize: 10, fontWeight: FontWeight.w600),
                  text: " JOD",
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _keyPad(SendMoneyViewModel viewModel) {
    return Flexible(
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        childAspectRatio: 1.5,
        children: [
          _number(1, viewModel),
          _number(2, viewModel),
          _number(3, viewModel),
          _number(4, viewModel),
          _number(5, viewModel),
          _number(6, viewModel),
          _number(7, viewModel),
          _number(8, viewModel),
          _number(9, viewModel),
          _dot(".", viewModel),
          _number(0,viewModel),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: primaryButtonColor,
                shape: BoxShape.circle,
              ),
              child: const SVGImage(assetPath: "assets/icons/send.svg"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _number(int number, SendMoneyViewModel viewModel) {
    return Container(
      color: Colors.white,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          viewModel.editAmount("$number");
        },
        child: Center(child: Text("$number", style: const TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.w400),)),
      ),
    );
  }

  Widget _dot(String value, SendMoneyViewModel viewModel) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        viewModel.editAmount(value);
      },
      child: Center(child: Text(value, style: const TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.w500),)),
    );
  }
}
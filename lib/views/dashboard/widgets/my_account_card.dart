import 'package:flutter/material.dart';
import '../../../constant/app_color.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_svg_image.dart';
import '../../../widgets/elevated_button.dart';


class MyAccountCard extends StatelessWidget {
  const MyAccountCard({super.key});

  @override
  Widget build(BuildContext context) {
    double horizontalSpacing = MediaQuery.of(context).size.width * 0.035;
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: horizontalSpacing, vertical: 44),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: const DecorationImage(
              image: AssetImage("assets/image/cardAccount.png"),
              fit: BoxFit.cover,
            )
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text("My Account", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Zein Malhas", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),

                      SizedBox(height: screenHeight*0.05),

                      const Text.rich(
                        TextSpan(
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                            children: [
                              TextSpan(
                                  text: "7,896.00"
                              ),
                              TextSpan(
                                text: " JOD",
                                style: TextStyle(color: gray300Color, fontSize: 14, fontWeight: FontWeight.w700),

                              ),
                            ]
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text("AVAILABLE BALANCE", style: TextStyle(color: gray400Color, fontSize: 10, fontWeight: FontWeight.w600),),

                      SizedBox(height: screenHeight*0.03),

                      const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("851.91", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),),
                          SizedBox(width: 8),
                          SVGImage(assetPath: "assets/icons/copyPaste.svg"),
                        ],
                      ),
                      const Text("ACCOUNT NUMBER", style: TextStyle(color: gray400Color, fontSize: 10, fontWeight: FontWeight.w600),),

                      SizedBox(height: screenHeight*0.03),

                      const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(child: Text("JOD120315314513451341234567312", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),maxLines: 1, overflow: TextOverflow.ellipsis,)),
                          SizedBox(width: 8),
                          SVGImage(assetPath: "assets/icons/copyPaste.svg"),
                        ],
                      ),
                      const Text("IBAN", style: TextStyle(color: gray400Color, fontSize: 10, fontWeight: FontWeight.w600),),
                    ],
                  ),
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomButton(
                      label: "Add money",
                      buttonColor: primaryButtonColor,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: blackColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: borderColor, blurRadius: 10, spreadRadius: 0.1),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              side: const BorderSide(color: borderColor),
                              borderRadius: BorderRadius.circular(100),
                            ),),
                          elevation: MaterialStateProperty.all(10),
                          foregroundColor: MaterialStateProperty.all(primaryButtonColor),
                        ),
                        icon: const Icon(Icons.share_outlined, size: 32,),
                      ),
                    ),
                  ],
                )

              ],
            ),
          ),
        ),

        ///Button
        Positioned(
          top: 20,
          child: Container(
            height: 48,
            width: 48,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: gray200Color, width: 1)
            ),
            child: const SVGImage(assetPath: "assets/icons/audioWave.svg"),
          ),
        ),

        ///Transactions button
        const Positioned(
          bottom: 20,
          child: ElevatedCustomButton(
            label: "Transactions",
            buttonColor: Colors.white,
            foregroundColor: primaryButtonColor,
          ),
        ),
      ],
    );
  }
}

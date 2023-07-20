import 'package:blink/feature/dashboard/dashboard_view_model.dart';
import 'package:blink/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constant/app_color.dart';
import 'dashboard/dashboard_view.dart';


class TimelineView extends StatefulWidget {
  const TimelineView({super.key});

  @override
  State<TimelineView> createState() => _TimelineViewState();
}

class _TimelineViewState extends State<TimelineView> {


  @override
  Widget build(BuildContext context) {
    double horizontalSpace = 202;
    double horizontalPadding = MediaQuery.of(context).size.width*0.15;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              totalBalance(),
              const SizedBox(height: 16),
              CustomButton(
                label: "Add money",
                foregroundColor: Colors.white,
                buttonColor: primaryButtonColor,
                onTap: () {},
              ),
              SizedBox(
                height: 350,
                child: ListView(
                  controller: context.read<DashboardViewModel>().controller,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(vertical: 36),
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 80.0, horizontal: MediaQuery.of(context).size.width*0.2),
                          child: Image.asset("assets/image/elementSwirl.png"),
                        ),
                        Positioned(
                          left: MediaQuery.of(context).size.width*0.15,
                          top: 0,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _timelineText("Credit card\ndelivered"),
                              _timelineDate("6 Jan"),
                            ],
                          ),
                        ),

                        Positioned(
                          left: horizontalSpace,
                          bottom: 0,
                          child: Column(
                            children: [
                              _timelineText("Debit card\ndelivered"),
                              _timelineDate("6 Jan"),
                            ],
                          ),
                        ),

                        Positioned(
                          left: (horizontalSpace * 2) - horizontalPadding,
                          top: 0,
                          child: Column(
                            children: [
                              _timelineText("Credit card\nactivated"),
                              _timelineDate("6 Jan"),
                            ],
                          ),
                        ),

                        Positioned(
                          left: (horizontalSpace * 3) - (horizontalPadding * 2),
                          bottom: 0,
                          child: Column(
                            children: [
                              _timelineText("Debit card\ndelivered"),
                              _timelineDate("6 Jan"),
                            ],
                          ),
                        ),

                        Positioned(
                          left: (horizontalSpace * 4) - (horizontalPadding * 3),
                          top: 0,
                          child: Column(
                            children: [
                              _timelineText("Credit card\nactivated"),
                              _timelineDate("6 Jan"),
                            ],
                          ),
                        ),

                        Positioned(
                          left: (horizontalSpace * 5) - (horizontalPadding * 4),
                          bottom: 0,
                          child: Column(
                            children: [
                              _timelineText("Debit card\ndelivered"),
                              _timelineDate("6 Jan"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Image.asset("assets/image/img.png"),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.2,)
            ],
          ),
        ),
      ),
    );
  }


  Widget _timelineText(String title) {
    return Text(title, style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600),textAlign: TextAlign.center,);
  }

  Widget _timelineDate(String date) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Text(date, style: const TextStyle(color: gray300Color, fontSize: 12, fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
    );
  }
}
import 'package:blink/feature/layout/layout_view_model.dart';
import 'package:blink/feature/dashboard/dashboard_view_model.dart';
import 'package:blink/feature/layout/main_menu_view.dart';
import 'package:blink/feature/payment/payment_view.dart';
import 'package:blink/feature/payment/payment_view_model.dart';
import 'package:blink/widgets/custom_svg_image.dart';
import 'package:blink/feature/dashboard/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constant/app_color.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> with SingleTickerProviderStateMixin{


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LayoutViewModel>(
      create: (_) => LayoutViewModel(),
      lazy: true,
      builder: (context, child) {
        return Scaffold(
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ///Main View
                context.watch<LayoutViewModel>().bottomBarIndex == BottomBarIndex.home
                    ? const DashboardView()
                    : context.watch<LayoutViewModel>().bottomBarIndex == BottomBarIndex.payment
                        ? const PaymentView()
                        : const DashboardView(),

              ///Bottom Navigation Bar
              AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: context.watch<DashboardViewModel>().settings || context.watch<DashboardViewModel>().timelinePage
                 || context.watch<PaymentViewModel>().showSendMoneyView || context.watch<PaymentViewModel>().showReceiveMoneyView
                    ? 0
                    : 1,
                child: Theme(
                  data: ThemeData(
                    splashColor: Colors.transparent,
                    dividerColor: Colors.transparent,
                  ),
                  child: SizedBox(
                    height: context.watch<DashboardViewModel>().bottomNavbarHeight,
                    child: BottomNavigationBar(
                      currentIndex: 0,
                      elevation: 0,
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      enableFeedback: false,
                      backgroundColor: context.watch<LayoutViewModel>().showMainMenu
                          ? Colors.black26
                          : Colors.white,
                      onTap: (int value) {
                        onTap(value, context.read<LayoutViewModel>());
                      },
                      type: BottomNavigationBarType.fixed,
                      items: [
                        const BottomNavigationBarItem(
                          label: "Home",
                          icon: SVGImage(assetPath: "assets/icons/home.svg"),
                        ),
                        BottomNavigationBarItem(
                          label: "Main",
                          icon: Stack(
                            alignment: Alignment.center,
                            children: [
                              const SVGImage(assetPath: "assets/icons/mainButton.svg"),
                              context.watch<LayoutViewModel>().showMainMenu
                                    ? Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(Icons.close, color: primaryButtonColor),
                                      )
                                    : const SizedBox(),
                            ],
                          ),
                        ),

                        const BottomNavigationBarItem(
                          label: "Support",
                          icon: SVGImage(assetPath: "assets/icons/headPhone.svg"),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              ///Main Menu
              context.watch<LayoutViewModel>().showMainMenu
                  ? const MainMenuView()
                  : const SizedBox(),
            ],
          ),
        );
      }
    );
  }

  onTap(int bottomIndex, LayoutViewModel viewModel) {
    switch(bottomIndex) {
      case 0:
        viewModel.changeBottomBarIndex(BottomBarIndex.home, context);
        break;
      case 1:
        viewModel.openMainMenu();
        break;
      case 2:
        // if(viewModel.showMainMenu) {return;}
        break;
      default:
        // if(viewModel.showMainMenu) {return;}
        break;
    }
  }
}

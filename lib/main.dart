import 'package:blink/feature/layout/layout_view.dart';
import 'package:blink/feature/dashboard/dashboard_view_model.dart';
import 'package:blink/feature/layout/layout_view_model.dart';
import 'package:blink/feature/payment/payment/payment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LayoutViewModel()),
        ChangeNotifierProvider(create: (_) => DashboardViewModel()),
        ChangeNotifierProvider(create: (_) => PaymentViewModel()),
      ],
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MaterialApp(
          title: 'Blink',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: "Montserrat",
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            textTheme: const TextTheme(
              bodyMedium: TextStyle(
                color: Colors.white,
              )
            ),
            scaffoldBackgroundColor: Colors.white
          ),
          home: const LayoutView(),
        ),
      ),
    );
  }
}

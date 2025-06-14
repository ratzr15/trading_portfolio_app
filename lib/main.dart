import 'package:flutter/material.dart';
import 'package:trading_portfolio_app/src/di/portfolio_screen_provider.dart';

void main() {
  const initialRoute = '/home';
  const title = 'Portfolio';

  runApp(
    MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: initialRoute,
      routes: {
        initialRoute: (context) => const PortfolioScreenProvider(),
      },
    ),
  );
}

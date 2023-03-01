import '../db/auth_repository.dart';
import '../provider/auth_provider.dart';
import '../routes/router_delegate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common/url_strategy.dart';
import 'routes/route_information_parser.dart';

void main() {
  usePathUrlStrategy();
  runApp(const QuotesApp());
}

class QuotesApp extends StatefulWidget {
  const QuotesApp({Key? key}) : super(key: key);

  @override
  State<QuotesApp> createState() => _QuotesAppState();
}

class _QuotesAppState extends State<QuotesApp> {
  late MyRouterDelegate myRouterDelegate;
  late MyRouteInformationParser myRouteInformationParser;

  /// todo 6: add variable for create instance
  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    final authRepository = AuthRepository();

    authProvider = AuthProvider(authRepository);

    /// todo 7: inject auth to router delegate
    myRouterDelegate = MyRouterDelegate(authRepository);

    myRouteInformationParser = MyRouteInformationParser();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => authProvider,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Quotes App',
        routerDelegate: myRouterDelegate,
        routeInformationParser: myRouteInformationParser,
        backButtonDispatcher: RootBackButtonDispatcher(),
      ),
    );
  }
}

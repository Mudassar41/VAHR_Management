import 'package:expense_trackr/providers/assets_provider.dart';
import 'package:expense_trackr/providers/auth_provider.dart';
import 'package:expense_trackr/providers/department_provider.dart';
import 'package:expense_trackr/providers/employee_provider.dart';
import 'package:expense_trackr/providers/expense_provider.dart';
import 'package:expense_trackr/shared/app_routes.dart';
import 'package:expense_trackr/shared/app_themses.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (BuildContext context) {
            return AuthProvider();
          },
        ),
        ChangeNotifierProvider<EmployeeProvider>(
          create: (BuildContext context) {
            return EmployeeProvider();
          },
        ),
        ChangeNotifierProvider<AssetsProvider>(
          create: (BuildContext context) {
            return AssetsProvider();
          },
        ),
        ChangeNotifierProvider<ExpenseProvider>(
          create: (BuildContext context) {
            return ExpenseProvider();
          },
        ),
         ChangeNotifierProvider<DepartmentProvider>(
          create: (BuildContext context) {
            return DepartmentProvider();
          },
        ),
      ],
      child: MaterialApp.router(
        title: 'Vasol',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.grey,
            appBarTheme: appBarTheme,
            inputDecorationTheme: inputDecorationTheme,
            textTheme: textTheme,
            cardTheme: cardTheme,
            bottomSheetTheme: bottomSheetThemeData),
        routerDelegate: AppRoute.router.routerDelegate,
        routeInformationProvider: AppRoute.router.routeInformationProvider,
        routeInformationParser: AppRoute.router.routeInformationParser,
      ),
    );
  }
}

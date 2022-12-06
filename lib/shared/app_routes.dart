import 'package:expense_trackr/models/assets.dart';
import 'package:expense_trackr/models/department.dart';
import 'package:expense_trackr/models/employee.dart';
import 'package:expense_trackr/models/expense.dart';
import 'package:expense_trackr/views/add_department.dart';
import 'package:expense_trackr/views/add_employees_view.dart';
import 'package:expense_trackr/views/add_expense_view.dart';
import 'package:expense_trackr/views/assets_view.dart';
import 'package:expense_trackr/views/dash_board.dart';
import 'package:expense_trackr/views/departments_view.dart';
import 'package:expense_trackr/views/employees_view.dart';
import 'package:expense_trackr/views/expense_view.dart';
import 'package:expense_trackr/views/loggedUser_view.dart';
import 'package:expense_trackr/views/projects_view.dart';
import 'package:expense_trackr/views/reports_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:expense_trackr/components/route_error.dart' as e;

import '../views/add_assets_view.dart';

class AppRoute {
  static final GoRouter router = GoRouter(
      routes: [
        GoRoute(
            path: "/",
            builder: (BuildContext context, GoRouterState state) {
              return const LoggedUserView();
            }),
        GoRoute(
            path: "/home",
            builder: (BuildContext context, GoRouterState state) {
              return const DasboardView();
            }),
        GoRoute(
            path: "/assets",
            builder: (BuildContext context, GoRouterState state) {
              return const AssetsView();
            }),
        GoRoute(
            name: 'addAsset',
            path: "/addAsset/:isUpdating/:assetId/:employeeName",
            builder: (BuildContext context, GoRouterState state) {
              return AddAssetsView(
                isUpdating: state.params["isUpdating"].toString(),
                assetsId: state.params['assetId'].toString(),
                emploeeName: state.params['employeeName'].toString(),
                data: state.extra as Assets,
              );
            }),
        GoRoute(
            path: "/employees",
            builder: (BuildContext context, GoRouterState state) {
              return const EmployeeView();
            }),
        GoRoute(
            name: 'addEmployee',
            path: "/addEmployee/:isUpdating/:employeeId/:departmentName",
            builder: (BuildContext context, GoRouterState state) {
              return AddEmployeeView(
                isUpdating: state.params["isUpdating"].toString(),
                employeeId: state.params['employeeId'].toString(),
                departmantName: state.params['departmentName'].toString(),
                data: state.extra as Employee,
              );
            }),
        GoRoute(
            path: "/Departments",
            builder: (BuildContext context, GoRouterState state) {
              return DepartmentsView();
            }),
        GoRoute(
            path: "/expenses",
            builder: (BuildContext context, GoRouterState state) {
              return const ExpensesView();
            }),
        GoRoute(
            name: 'addExpense',
            path: "/addExpense/:isUpdating/:expenseId",
            builder: (BuildContext context, GoRouterState state) {
              return AddExpenseView(
                isUpdating: state.params["isUpdating"].toString(),
                expenseId: state.params['expenseId'].toString(),
                data: state.extra as Expense,
              );
            }),
        GoRoute(
            name: 'addDepartment',
            path: "/addDepartment/:isUpdating/:departmentId",
            builder: (BuildContext context, GoRouterState state) {
              return AddDepartmentView(
                isUpdating: state.params["isUpdating"].toString(),
                departmentId: state.params['departmentId'].toString(),
                data: state.extra as Department,
              );
            }),
        GoRoute(
            path: "/projects",
            builder: (BuildContext context, GoRouterState state) {
              return const ProjectsView();
            }),
        GoRoute(
            path: "/reports",
            builder: (BuildContext context, GoRouterState state) {
              return const ReportsView();
            }),
      ],
      errorBuilder: (context, state) {
        return e.ErrorWidget(error: state.error.toString());
      });
}

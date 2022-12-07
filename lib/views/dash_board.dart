// ignore_for_file: prefer_const_constructors

import 'package:expense_trackr/components/responsive.dart';
import 'package:expense_trackr/service/auth_service.dart';
import 'package:expense_trackr/service/remote_db_service.dart';
import 'package:expense_trackr/shared/string_extensions.dart';
import 'package:expense_trackr/shared/app_colors.dart';
import 'package:expense_trackr/shared/app_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/animate.dart';
import 'package:flutter_animate/effects/effects.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../models/dashboard.dart';

class DasboardView extends StatefulWidget {
  const DasboardView({super.key});

  @override
  State<DasboardView> createState() => _DasboardViewState();
}

//vasol
class _DasboardViewState extends State<DasboardView> {
  var dashBoardList = [
    DashBoard('expenses', FontAwesomeIcons.moneyBillTrendUp),
    DashBoard('assets', FontAwesomeIcons.coins),
    DashBoard('employees', FontAwesomeIcons.peopleGroup),
    DashBoard('departments', FontAwesomeIcons.houseLaptop),
    DashBoard('projects', FontAwesomeIcons.list),
    DashBoard('reports', FontAwesomeIcons.chartSimple),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print('i am build');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Mudassar"),
      // ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(ResponsiveWidget.isLargeScreen(context)
              ? 40
              : ResponsiveWidget.isMediumScreen(context)
                  ? 20
                  : 8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Welcome to",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "VA HR Management",
                                style: TextStyle(
                                    fontFamily: AppFonts.poppinsBold,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                    fontSize: 20),
                              ),
                              TextButton(
                                  onPressed: () async {
                                    await AuthService.googleSignIn.signOut();
                                    await FirebaseAuth.instance.signOut();


                                  
                                  },
                                  child: Text(
                                    'Sign out',
                                    style: TextStyle(
                                        fontFamily: AppFonts.poppinsBold,
                                        color: AppColors.primaryColor),
                                  ))
                            ],
                          ),
                        ],
                      )),
                ),
                GridView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: ResponsiveWidget.isLargeScreen(context)
                        ? 4
                        : ResponsiveWidget.isMediumScreen(context)
                            ? 3
                            : 2,
                  ),
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: (() {
                          context.push('/${dashBoardList[index].itemName}');
                        }),
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  Colors.white,
                                  AppColors.primaryColor,
                                  Colors.white
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.topRight),
                            color: Colors.white12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 75,
                                width: 75,
                                decoration: BoxDecoration(
                                    color: AppColors.secondaryColor,
                                    border: Border.all(
                                        color: AppColors.secondaryColor),
                                    shape: BoxShape.circle),
                                child: Center(
                                  child: Icon(
                                    dashBoardList[index].dashBoardIcon,
                                    size: 30,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  dashBoardList[index]
                                      .itemName
                                      .capitalizeFirstLetter,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: dashBoardList.length,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:expense_trackr/shared/app_colors.dart';
import 'package:expense_trackr/shared/app_fonts.dart';
import 'package:expense_trackr/shared/string_extensions.dart';
import 'package:flutter/material.dart';

class SearchFilterContainer extends StatelessWidget {
  final String searchBarTitle;
  final IconData searchBarIcon;
  final Function() onTap;

  const SearchFilterContainer(
      {super.key,
      required this.onTap,
      required this.searchBarTitle,
      required this.searchBarIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
              color: AppColors.whiteShade,
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  searchBarTitle.capitalizeFirstLetterOFSentence,
                  style: TextStyle(
                      fontFamily: AppFonts.poppinsRegular,
                      color: Colors.black54),
                ),
                Icon(
                  searchBarIcon,
                  color: AppColors.secondaryColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

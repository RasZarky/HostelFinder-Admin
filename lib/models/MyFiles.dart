import 'package:hostel_finder_admin/constants.dart';
import 'package:flutter/material.dart';

class CloudStorageInfo {
  final String? svgSrc, title, totalStorage;

  final Color? color;

  CloudStorageInfo({
    this.svgSrc,
    this.title,
    this.totalStorage,

    this.color,
  });
}

List demoMyFiles = [
  CloudStorageInfo(
    title: "Add Hostel",

    svgSrc: "assets/icons/Documents.svg",
    totalStorage: "",
    color: primaryColor,
  ),
  CloudStorageInfo(
    title: "Bookings",

    svgSrc: "assets/icons/google_drive.svg",
    totalStorage: "",
    color: Color(0xFFFFA113),
  ),
  CloudStorageInfo(
    title: "Add Rooms",

    svgSrc: "assets/icons/one_drive.svg",
    totalStorage: "",
    color: Color(0xFFA4CDFF),
  ),
  CloudStorageInfo(
    title: "View Rooms",

    svgSrc: "assets/icons/drop_box.svg",
    totalStorage: "",
    color: Color(0xFF007EE5),
  ),
  CloudStorageInfo(
    title: "View Hostels",

    svgSrc: "assets/icons/drop_box.svg",
    totalStorage: "",
    color: Color(0xFFff5f5f) ,
  ),
];

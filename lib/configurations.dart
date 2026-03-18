import 'attendance_model.dart';
import 'package:flutter/material.dart';

class Configurations {

 static List<Map<String,String>> credentials = [
   {'userid':'vit1@vit.edu','password':'Vit@1234'},
   {'userid':'1321a@viit.ac.in','password':'Vit@1321a'}
 ];

 static List<Attendance> attendance = [
    Attendance(date: "02-02-2026", status: 1),
    Attendance(date: "09-02-2026", status: 0),
    Attendance(date: "16-02-2026", status: 1),
    Attendance(date: "22-02-2026", status: 0),
    Attendance(date: "23-02-2026", status: 1),
    Attendance(date: "23-02-2026", status: 0),
    Attendance(date: "24-02-2026", status: 1),
    Attendance(date: "26-02-2026", status: 1),
    Attendance(date: "01-03-2026", status: 0),
    Attendance(date: "02-03-2026", status: 1),
    Attendance(date: "03-03-2026", status: 1),
    Attendance(date: "04-03-2026", status: 1),
    Attendance(date: "05-03-2026", status: 1),
    Attendance(date: "08-03-2026", status: 1),
    Attendance(date: "08-03-2026", status: 0),
    Attendance(date: "15-03-2026", status: 0),
    Attendance(date: "19-03-2026", status: 1),
    Attendance(date: "20-03-2026", status: 1),
    Attendance(date: "21-03-2026", status: 1),
    Attendance(date: "22-03-2026", status: 0),
    Attendance(date: "23-03-2026", status: 1),
    Attendance(date: "24-03-2026", status: 1),
    Attendance(date: "25-03-2026", status: 1),
  ];

  static ValueNotifier<List<Attendance>> attendanceNotifier =
    ValueNotifier(attendance);

 static bool validateEmail(String text) {
   return RegExp(
     r"^[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*@[a-zA-Z0-9]+(\.[a-zA-Z]{2,4}){1,2}$",
   ).hasMatch(text);
 }

static bool validateLogin(String userid, String password) {
  for (var cred in credentials) {
    if (cred['userid'] == userid && cred['password'] == password) {
      return true;
    }
  }
  return false;
}

static bool isUserUnique(String userid) {
  for (var cred in credentials) {
    if (cred['userid'] == userid) {
      return false; // already exists
    }
  }
  return true; // unique
}

//  static bool validatePassword(String text) {
//    return RegExp(
//      r"^[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*@[a-zA-Z0-9]+(\.[a-zA-Z]{2,4}){1,2}$",
//    ).hasMatch(text);
//  }


}
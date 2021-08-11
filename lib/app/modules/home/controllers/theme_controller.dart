import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TemaController extends GetxController {
  SharedPreferences preferences;

  String prefkey = "isDarkModeKey";
  

  void temaClaro() {
    Get.changeTheme(
      ThemeData.light().copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
    );
    preferences.setBool(prefkey, false);
  }

  void temaOscuro() {
    Get.changeTheme(
      ThemeData.dark().copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(),
        
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.pinkAccent),
          ),
        ),
        accentColor: Colors.pinkAccent,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.pinkAccent, foregroundColor: Colors.white),
      ),
    );
    preferences.setBool(prefkey, true);
  }

  @override
  void onInit() {
    cargarPreferencias().then((value) => cargarTema());

    super.onInit();
  }

  void cargarTema() {
    bool isDarkMode = preferences.getBool(prefkey);


    if (isDarkMode == null) {
      preferences.setBool(prefkey, false);
      isDarkMode = false;
    }

    (isDarkMode) ? temaOscuro() : temaClaro();
  }

  Future<void> cargarPreferencias() async {
    preferences = await Get.putAsync<SharedPreferences>(
        () async => await SharedPreferences.getInstance());
  }
}
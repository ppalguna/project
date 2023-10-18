
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class ThemeService{
  final _box = GetStorage();
  final _key = 'isDarkMode';
  _saveYhemeToBox(bool isDarkMode)=>_box.write(_key, isDarkMode);
  bool _loadThemeFromBox()=> _box.read(_key)??false; //?? jika disana ada value kembalikan value tersebut dengan true
  ThemeMode get theme=> _loadThemeFromBox()?ThemeMode.dark:ThemeMode.light;

  void switchTheme(){
   Get.changeThemeMode(_loadThemeFromBox()?ThemeMode.light:ThemeMode.dark); 
    _saveYhemeToBox(!_loadThemeFromBox());
  }
}
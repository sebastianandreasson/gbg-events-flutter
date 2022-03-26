import 'package:flutter/material.dart';

bool isSingleColumn(BuildContext context) {
  return MediaQuery.of(context).size.width <= 800;
}

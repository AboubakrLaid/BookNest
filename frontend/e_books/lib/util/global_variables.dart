

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';


final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

final kWidth =
    MediaQuery.of(scaffoldMessengerKey.currentState!.context).size.width;
final kHeight =
    MediaQuery.of(scaffoldMessengerKey.currentState!.context).size.height;

final Logger logger = Logger();
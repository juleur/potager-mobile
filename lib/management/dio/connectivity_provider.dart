import 'package:connectivity/connectivity.dart';
import 'package:flutter_riverpod/all.dart';

final connectivityProvider = Provider<Connectivity>((ref) => Connectivity());

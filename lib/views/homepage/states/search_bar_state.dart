import 'package:flutter_riverpod/all.dart';

enum SearchBarStatus { active, inactive }

final searchBarProvider = StateProvider((ref) => SearchBarStatus.inactive);

import 'package:flutter_riverpod/all.dart';
import './../../../repository/login_repositiory.dart';

final loginRepository =
    Provider<LoginRepository>((ref) => LoginRepository(ref.read));

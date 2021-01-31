import 'package:riverpod/all.dart';
import './../../services/open_street_map.dart';

final osmServiceProvider = Provider((ref) => OpenStreetMapService(ref.read));

import 'package:flutter_riverpod/all.dart';
import '../../services/geo_permission_service.dart';

final geoPermissionProvider = Provider((ref) => GeoPermissionService(ref.read));

enum SystemeEchange {
  don,
  troc,
  vente,
}

extension SystemeEchangeExtension on SystemeEchange {
  static const names = {
    SystemeEchange.don: 'Don',
    SystemeEchange.troc: 'Troc',
    SystemeEchange.vente: 'Vente',
  };

  String get name => names[this];
}

List<SystemeEchange> convertSystemeEchange(List<dynamic> sysEch) {
  final List<SystemeEchange> systemeEchange = [];
  for (final v in sysEch) {
    for (final se in SystemeEchange.values) {
      if (se.name == v) systemeEchange.add(se);
    }
  }
  return systemeEchange;
}

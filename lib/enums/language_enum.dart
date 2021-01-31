enum Language {
  basque,
  breton,
  francais,
  alsacien,
  flamand,
  francique,
  croissant,
  gascon,
  languedocien,
  nordOccitan,
  provencal,
  angevin,
  bourguignonMorvandiau,
  catalan,
  centraux,
  champenois,
  corse,
  francComtois,
  francoProvencal,
  gallo,
  ligure,
  lorrainRoman,
  mainiot,
  normand,
  picard,
  poitevinSaintongeais,
  wallon,
}

extension LanguageExtension on Language {
  static const languageCodes = {
    Language.basque: 'ba_BAS',
    Language.breton: 'br_BRE',
    Language.francais: 'fr_FR',
    Language.alsacien: 'gr_ALS',
    Language.flamand: 'gr_FLA',
    Language.francique: 'gr_FRA',
    Language.croissant: 'oc_CRO',
    Language.gascon: 'oc_GAS',
    Language.languedocien: 'oc_LAN',
    Language.nordOccitan: 'oc_NOC',
    Language.provencal: 'oc_PRO',
    Language.angevin: 'ro_ANG',
    Language.bourguignonMorvandiau: 'ro_BOU',
    Language.catalan: 'ro_CAT',
    Language.centraux: 'ro_CEN',
    Language.champenois: 'ro_CHA',
    Language.corse: 'ro_COR',
    Language.francComtois: 'ro_FRC',
    Language.francoProvencal: 'ro_FRP',
    Language.gallo: 'ro_GAL',
    Language.ligure: 'ro_LIG',
    Language.lorrainRoman: 'ro_LOR',
    Language.mainiot: 'ro_MAI',
    Language.normand: 'ro_NOR',
    Language.picard: 'ro_PIC',
    Language.poitevinSaintongeais: 'ro_POI',
    Language.wallon: 'ro_WAL',
  };

  String get languageCode => languageCodes[this];
}

Language findLanguage(String langue) {
  for (final Language lang in Language.values) {
    if (lang.languageCode == langue) return lang;
  }
  return Language.francais;
}

bool isLanguageExists(String lang) {
  for (final key in Language.values) {
    if (key.languageCode == lang) {
      return true;
    }
  }
  return false;
}

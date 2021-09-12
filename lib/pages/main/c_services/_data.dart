import 'package:flutter/material.dart' show IconData, Icons;

const sectionTitle = 'Dienstleistungen';
const sectionDescription =
    'Unser Service gibt Ihnen Sicherheit. Unser Know-how, unsere Technik und unser Engagement stehen Ihnen bei jedem Ihrer Besuche zur Verfügung. Neben der hohen Qualifikation unserer Mitarbeiter sorgen definierte Arbeitsprozesse und der Einsatz moderner Werkstatttechnologie für fachmännische und effiziente Arbeit. So stellen wir sicher, dass Ihr Fahrzeug zu fairen Preisen zuverlässig gewartet oder repariert wird!';

const sectionData = {
  SectionData(
    iconData: Icons.settings_outlined,
    title: 'Werkstatt',
    items: [
      'Spezialisiert auf US-Car',
      'Täglich TÜV und Abgasuntersuchungen',
      'Unfallinstandsetzung aller Marken',
      'Autoglastausch und Reparatur',
      'Scheibentönung und Fahrzeugbeklebung',
      'Klimaanlagenservice',
      'Inspektion, Reparatur und Instandsetzung',
      'Karosserie und Lack-Reparaturen',
      'Fahrzeugelektrik',
      'Spurvermessung bis 27 Zoll',
      'Reifenmontage und Wuchten bis 30 Zoll',
      'Gas Einbauten, Wartung und Reparatur',
      'Nachrüstungen (Anhängerkupplung, Gasanlagen, Standheizungen etc.)',
    ],
  ),
  SectionData(
    iconData: Icons.speed,
    title: 'Service und Zubehör',
    items: [
      'Verkauf von Original Mopar Ersatzteilen und Zubehör',
      'Teilebeschaffung aller Marken',
      'Pannenhilfe vor Ort',
      'Kunden- und Ersatzfahrzeuge',
      'Stützpunkt für Jeep Hybridfahrzeuge (PHEV)',
      'Recall für Chrysler, Jeep und Dodge Fahrzeuge',
      'Hol & Bring Service',
      'Reifen und Felgen Handel',
      'Rädereinlagerung',
      'Ersatzteileversand aller Marken',
      'Motor- und Fahrzeugtuning',
      'Fahrzeugaufbereitung',
    ],
  ),
  SectionData(
    iconData: Icons.people_alt_outlined,
    title: 'Verkauf und Beratung',
    items: [
      'Offizieller Dodge & RAM Vertragshändler von AEC und KWA',
      'Neu- und Gebrauchtwagenverkauf aller Marken',
      'EU-Neuwagen Verkauf',
      'Gebrauchtwagen Bewertung, individuelle Neu- und Gebrauchtwagen Beratung',
      'Ankauf und Inzahlungnahme aller Marken',
      'Finanzierungs- und Leasingangebote aller Marken',
      'Vermittlung von KFZ-Versicherungen',
      'Abwicklung von Zulassungs- und Abmeldeformalitäten',
      'Garantie und Kulanzabwicklungen',
    ],
  ),
};

class SectionData {
  const SectionData({
    required this.iconData,
    required this.title,
    required this.items,
  });

  final IconData iconData;
  final String title;
  final List<String> items;
}

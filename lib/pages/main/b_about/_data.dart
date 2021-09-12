const sectionTitle = 'Über Uns';
const sectionDescription =
    'Unser Unternehmen besteht seit dem 01.01.1997, damals allerdings mit Firmensitz in dem abseits gelegenen Gewerbegebiet von Nattheim unter dem Namen SST-Automobile. Zusätzlich zu den Marken **Chrysler**, **Jeep** und **Dodge**, waren wir auch Vertragspartner von **Jaguar** Deutschland. Bis heute können wir best ausgebildetes Personal für Zubehör, Know-How und Service dieser Marke vorweisen\n\nUm mehr Kundennähe zu erreichen, zog unser Betrieb zum 01.01.2007 letztendlich unter einem neuen Namen nach Herbrechtingen. Von nun an, erschlossen uns neue Wege und unser Angebot erweiterte sich um den Vertrieb und Serviceleistungen für **Dodge** und **RAM**.';

const sectionData = {
  SectionData(
    asset: 'about-partner',
    title: 'Partner',
    description: 'Bald verfügbar!',
  ),
  SectionData(
    asset: 'about-social',
    title: 'Social Media',
    description: 'Bald verfügbar!',
  ),
  SectionData(
    asset: 'about-promo',
    title: 'Aktionen',
    description: 'Bald verfügbar!',
  ),
};

class SectionData {
  const SectionData({
    required this.asset,
    required this.title,
    required this.description,
  });

  final String asset;
  final String title;
  final String description;
}

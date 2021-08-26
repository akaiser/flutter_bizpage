// ignore_for_file: lines_longer_than_80_chars

const introData = {
  0: IntroData(
    asset: '1_rez',
    title: 'Herzlich Willkommen',
    text:
        'bei **SGS-Automobile GmbH & Co. KG** in Herbrechtingen.\nWir sind **Dodge** und **RAM** Vertragspartner und Servicepartner für **Chrysler** und **Jeep**.',
    actionText: 'Über Uns',
  ),
  1: IntroData(
    asset: '2_rez',
    title: 'Spezialisiert auf US-Cars',
    text: '',
    actionText: 'Zu unseren Dienstleistungen',
  ),
  2: IntroData(
    asset: '3_rez',
    title: 'Verkauf und Beratung',
    text:
        'Wir sind **Dodge** und **RAM** Vertragshändler von **AEC** und **KWA**.\nGerne vermitteln wir Ihnen auch Fahrzeuge von **Jeep** und **Fiat** oder Ihrer Wunschmarke.',
    actionText: 'Zum Fahrzeugangebot',
  ),
  3: IntroData(
    asset: '4_rez',
    title: '',
    text: '',
    actionText: 'Ihr Weg zu uns',
  ),
};

class IntroData {
  const IntroData({
    required this.asset,
    required this.title,
    required this.text,
    required this.actionText,
  });

  final String asset;
  final String title;
  final String text;
  final String actionText;
}

const actionButtonMappings = {
  0: 1,
  1: 2,
  2: 3,
  3: 5,
};

const co2Text =
    'Kraftstoffverbrauch und CO2-Emissionen aller auf dieser Seite dargestellten Modelle mit den erhältlichen V8 - V6 Benzinmotoren: Kraftstoffverbrauch (komb.): 14,9 – 11,2 l/100km; CO2-Emissionen (komb.): 395 – 272 g/km; Effizienzklasse: G - E*';

const logoData = [
  LogoData(asset: 'aec', height: 54, link: 'https://aeceurope.com/de/'),
  LogoData(asset: 'ram', height: 56, link: 'https://www.ram.com/'),
  LogoData(asset: 'jeep', height: 46, link: 'https://www.jeep.de/'),
  LogoData(asset: 'dodge', height: 26, link: 'https://www.dodge.com/'),
];

class LogoData {
  const LogoData({
    required this.asset,
    required this.height,
    required this.link,
  });

  final String asset;
  final double height;
  final String link;
}

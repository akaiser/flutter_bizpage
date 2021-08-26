const navigationData = {
  0: NavigationItem('intro'),
  1: NavigationItem('über uns'),
  2: NavigationItem('dienstleistungen'),
  3: NavigationItem('fahrzeugangebot'),
  4: NavigationItem('das team'),
  5: NavigationItem('kontakt'),
};

class NavigationItem {
  const NavigationItem(this.text);

  final String text;
}

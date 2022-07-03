import 'package:flutter/widgets.dart';
import 'package:flutter_bizpage/pages/main/b_about/_data.dart';
import 'package:flutter_bizpage/pages/main/b_about/about_body.dart';
import 'package:flutter_bizpage/pages/section.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('images/about.jpg'),
        ),
      ),
      child: Section(
        title: sectionTitle,
        description: sectionDescription,
        body: AboutBody(),
      ),
    );
  }
}

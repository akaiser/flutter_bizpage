import 'package:flutter/material.dart';
import 'package:flutter_bizpage/pages/main/c_services/_data.dart';
import 'package:flutter_bizpage/pages/main/c_services/services_body.dart';
import 'package:flutter_bizpage/pages/section.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) => const ColoredBox(
    color: Colors.white,
    child: Section(
      title: sectionTitle,
      description: sectionDescription,
      body: ServicesBody(),
    ),
  );
}

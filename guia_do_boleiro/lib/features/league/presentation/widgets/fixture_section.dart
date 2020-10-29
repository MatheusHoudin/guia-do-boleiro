import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guia_do_boleiro/features/league/presentation/widgets/fixture_item.dart';
import 'package:guia_do_boleiro/shared/model/fixture.dart';
import 'package:guia_do_boleiro/shared/widgets/loading_ball.dart';

class FixtureSection extends StatelessWidget {
  final String sectionTitle;
  final List<Fixture> fixtures;
  final bool isLoading;

  FixtureSection(
      {this.sectionTitle,
      this.isLoading,
      this.fixtures});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LeagueLoading()
        : Container(
            height: Get.height * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: fixtures.length,
                    itemBuilder: (context, index) =>
                        FixtureItem(fixture: fixtures[index],),
                  ),
                ),
              ],
            ),
          );
  }

  Widget LeagueLoading() {
    return Center(
      child: LoadingBall(
        size: 60,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ubenwa_cart/components/ub_bottom_sheet_helper.dart';
import 'package:ubenwa_cart/components/ub_scaffold.dart';
import 'package:ubenwa_cart/data/controllers/home_controller.dart';
import 'package:ubenwa_cart/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeController _homeController;

  @override
  Widget build(BuildContext context) {
    return UBScaffold(
        state: AppState(pageState: _homeController.homeResourceState),
        appBar: AppBar(
          backgroundColor: ubPrimaryColor,
          actions: [
            GestureDetector(
              onTap: () {
                showSettingsBottomSheet(context);
              },
              child: const CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(Icons.settings),
              ),
            ),
          ],
        ),
        builder: (context) {
          return ListView(
            children: [
              SizedBox(height: kMediumPadding),
              Text(
                "New Infants",
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: Colors.black),
              ),
              SizedBox(height: kMediumPadding),
              Text(
                "Newly delivered Ubenwa monitored infants",
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: gray3Color),
              ),
              SizedBox(height: kMediumPadding),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _homeController.infantList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            showInfantDataBottomSheet(context,
                                infantDataList:
                                    _homeController.infantList![index]);
                          },
                          child: Row(
                            children: [
                              const Icon(Icons.baby_changing_station_sharp),
                              SizedBox(width: kMediumPadding),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: kRegularPadding),
                                child: Text(
                                    _homeController
                                        .infantList![index].attributes!.name
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith()),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.black.withOpacity(0.2),
                        )
                      ],
                    );
                  }),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _homeController = Provider.of<HomeController>(context, listen: false);
  }
}

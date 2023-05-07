import 'package:adope/config/widget/already_adopted_widget.dart';
import 'package:adope/constant/app_constant.dart';
import 'package:adope/core/model/hive_model.dart';
import 'package:adope/modules/details/widget/image_zoom_widget.dart';
import 'package:adope/modules/home/bloc/home_bloc.dart';
import 'package:adope/utils/navigation_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsScreen extends StatelessWidget {
  final PetModel petModel;

  const DetailsScreen({
    Key? key,
    required this.petModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    bool isAdoptionStatusChanged = false;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, isAdoptionStatusChanged);
        return false;
      },
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) async {
          if (state is AdoptedSuccessfully) {
            isAdoptionStatusChanged = true;
            await showDialog(
              context: context,
              builder: (context) => Dialog(
                backgroundColor: theme.canvasColor,
                child: Container(
                  width: size.width > 768 ? 300 : size.width * 0.8,
                  padding: const EdgeInsets.all(12),
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Yay!! You have now adopted Carry",
                        style: theme.primaryTextTheme.headline4?.copyWith(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          NavigationHelper.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(size.width * 0.5, 42),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          "COOL!",
                          style: theme.primaryTextTheme.headline5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    return ListView(
                      padding: const EdgeInsets.all(12.0),
                      children: [
                        Hero(
                          tag: petModel.id,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                NavigationHelper.push(
                                  context,
                                  ImageZoomWidget(
                                    petModel: petModel,
                                  ),
                                );
                              },
                              child: Image.network(
                                petModel.imagePath,
                                height: size.height * 0.4,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                petModel.name,
                                style: theme.primaryTextTheme.headline2?.copyWith(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "₹ ${petModel.price}",
                                        style: theme.primaryTextTheme.headline3,
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Gender: ${petModel.gender.name}",
                                            style: theme.primaryTextTheme.headline3,
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          Icon(
                                            petModel.gender.icon,
                                            color: petModel.gender.color,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        "${petModel.age} years",
                                        style: theme.primaryTextTheme.headline3,
                                      ),
                                      const SizedBox(
                                        height: 24,
                                      ),
                                    ],
                                  ),
                                  if (petModel.isAdopted || isAdoptionStatusChanged)
                                    const Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: AlreadyAdoptedWidget(),
                                    ),
                                ],
                              ),
                              Text(
                                dummyText,
                                style: theme.primaryTextTheme.headline3,
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Center(
                                child: ElevatedButton(
                                  onPressed: (petModel.isAdopted || isAdoptionStatusChanged)
                                      ? null
                                      : () {
                                          BlocProvider.of<HomeBloc>(context).add(
                                            AdoptClicked(petModel: petModel),
                                          );
                                        },
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(size.width, 48),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Text(
                                    (petModel.isAdopted || isAdoptionStatusChanged) ? "ALREADY ADOPTED" : "ADOPT ME",
                                    style: theme.primaryTextTheme.headline5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async {
                    Navigator.pop(context, isAdoptionStatusChanged);
                  },
                  child: Container(
                    width: 44,
                    height: 44,
                    margin: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:adope/config/widget/already_adopted_widget.dart';
import 'package:adope/config/widget/custom_progress_bar.dart';
import 'package:adope/dependency_injection/injection_container.dart';
import 'package:adope/modules/details/screen/details_screen.dart';
import 'package:adope/modules/home/bloc/home_bloc.dart';
import 'package:adope/utils/date_format_helper.dart';
import 'package:adope/utils/navigation_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late HomeBloc homeBloc;

  @override
  void initState() {
    super.initState();
    homeBloc = getIt<HomeBloc>()..add(FetchHistory());
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocProvider<HomeBloc>.value(
      value: homeBloc,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is FetchedAdoptionHistory) {
                    var pets = state.pets;
                    if (pets.isEmpty) {
                      return const Center(
                        child: Text("You haven't adopted any pets"),
                      );
                    } else {
                      return ListView.separated(
                        padding: const EdgeInsets.fromLTRB(12, 84, 12, 12),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              NavigationHelper.push(
                                context,
                                DetailsScreen(
                                  petModel: pets[index],
                                ),
                              );
                            },
                            child: Container(
                              height: 100,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: theme.canvasColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Hero(
                                    tag: pets[index].id,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        pets[index].imagePath,
                                        width: 100,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        pets[index].name,
                                        style: theme.primaryTextTheme.headline2,
                                      ),
                                      Text(
                                        "₹ ${pets[index].price}",
                                        style: theme.primaryTextTheme.headline3,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            pets[index].gender.icon,
                                            color: pets[index].gender.color,
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                            "${pets[index].age} years",
                                            style: theme.primaryTextTheme.headline4,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  AlreadyAdoptedWidget(
                                    text: "${formatDate(pets[index].adoptedDate!)}\n${pets[index].adoptedDate!.year}",
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: pets.length,
                      );
                    }
                  } else {
                    return const Center(
                      child: LoadingIndicator(),
                    );
                  }
                },
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 44,
                      height: 44,
                      margin: const EdgeInsets.fromLTRB(24, 24, 12, 24),
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
                  Text(
                    "Adoption History",
                    style: theme.primaryTextTheme.headline2,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

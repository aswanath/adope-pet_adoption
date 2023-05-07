import 'package:adope/config/widget/already_adopted_widget.dart';
import 'package:adope/config/widget/custom_progress_bar.dart';
import 'package:adope/core/model/hive_model.dart';
import 'package:adope/dependency_injection/injection_container.dart';
import 'package:adope/modules/details/screen/details_screen.dart';
import 'package:adope/modules/history/screen/history_screen.dart';
import 'package:adope/modules/home/bloc/home_bloc.dart';
import 'package:adope/modules/home/widget/home_search_field.dart';
import 'package:adope/utils/navigation_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const String petTileKey = "petTileKey";

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController searchController;
  late HomeBloc homeBloc;
  late ScrollController scrollController;
  List<PetModel> pets = [];

  @override
  void initState() {
    super.initState();
    homeBloc = getIt<HomeBloc>()..add(InitializeHome());
    searchController = TextEditingController();
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
          homeBloc.add(
            ScrollToPageEnd(
              searchPhrase: searchController.text,
            ),
          );
        }
      });
  }

  @override
  void dispose() {
    searchController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return BlocProvider<HomeBloc>.value(
      value: homeBloc,
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is PetsListUpdated) {
            pets = state.pets;
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeInitial) {
                      return const Center(
                        child: LoadingIndicator(),
                      );
                    } else if (pets.isEmpty) {
                      return const Center(
                        child: Text("No pets are available"),
                      );
                    }
                    return ListView.separated(
                      controller: scrollController,
                      padding: const EdgeInsets.fromLTRB(12, 84, 12, 12),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          key: const Key(petTileKey),
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            NavigationHelper.push(
                              context,
                              DetailsScreen(
                                petModel: pets[index],
                              ),
                              onValue: (isAdoptionStatusChanged) {
                                if (isAdoptionStatusChanged == true) {
                                  setState(() {
                                    pets[index] = PetModel(
                                      id: pets[index].id,
                                      name: pets[index].name,
                                      age: pets[index].age,
                                      imagePath: pets[index].imagePath,
                                      isAdopted: true,
                                      price: pets[index].price,
                                      gender: pets[index].gender,
                                    );
                                  });
                                }
                              },
                            );
                          },
                          child: Container(
                            height: 100,
                            padding: const EdgeInsets.all(12),
                            foregroundDecoration: pets[index].isAdopted
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black.withOpacity(0.15),
                                  )
                                : null,
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
                                if (pets[index].isAdopted) ...{
                                  const AlreadyAdoptedWidget(),
                                }
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
                  },
                ),
                Container(
                  height: 72,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(32),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: theme.canvasColor,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: HomeSearchField(
                            textEditingController: searchController,
                            onSearched: (val) {
                              homeBloc.add(
                                HomeSearched(searchPhrase: val),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          NavigationHelper.push(
                            context,
                            const HistoryScreen(),
                          );
                        },
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: theme.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.history,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is PageLoading) {
                      return Positioned(
                        bottom: 10,
                        left: (size.width / 2) - 15,
                        child: const LoadingIndicator(),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

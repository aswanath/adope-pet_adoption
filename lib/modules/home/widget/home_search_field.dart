import 'package:flutter/material.dart';

const String homeSearchFieldKey = "homeSearchFieldKey";
const String searchFieldClearButtonKey = "searchFieldClearButtonKey";

class HomeSearchField extends StatefulWidget {
  final TextEditingController textEditingController;
  final void Function(String) onSearched;

  const HomeSearchField({
    Key? key,
    required this.textEditingController,
    required this.onSearched,
  }) : super(key: key);

  @override
  State<HomeSearchField> createState() => _HomeSearchFieldState();
}

class _HomeSearchFieldState extends State<HomeSearchField> {
  bool isClearButtonVisible = false;

  @override
  void initState() {
    super.initState();
    widget.textEditingController.addListener(() {
      setState(() {
        isClearButtonVisible = widget.textEditingController.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: const Key(homeSearchFieldKey),
      textInputAction: TextInputAction.search,
      onFieldSubmitted: widget.onSearched,
      controller: widget.textEditingController,
      style: Theme.of(context).primaryTextTheme.headline3,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search_rounded,
          color: Theme.of(context).focusColor,
        ),
        suffixIcon: isClearButtonVisible
            ? IconButton(
                key: const Key(searchFieldClearButtonKey),
                onPressed: () {
                  widget.textEditingController.clear();
                  widget.onSearched('');
                },
                icon: const Icon(Icons.clear),
              )
            : const SizedBox.shrink(),
        hintText: "Search for name, age, price",
        hintStyle: Theme.of(context).primaryTextTheme.headline3,
        contentPadding: const EdgeInsets.all(12),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    );
  }
}

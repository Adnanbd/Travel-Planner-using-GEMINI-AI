// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_ai_testing/modules/home/provider/home.p.dart';

import 'package:gemini_ai_testing/utls/bd.location.dart';

class LocationPicker extends ConsumerWidget {
  final String hinttext;
  final ValueSetter<String?> onSubmitted;
  final String? selelctedItem;
  const LocationPicker({
    super.key,
    required this.hinttext,
    required this.onSubmitted,
    required this.selelctedItem,
  });

  Widget customPopupItemBuilderExample2(BuildContext context, String item, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item),
        leading: const Icon(Icons.location_city),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final from = ref.watch(fromP);
    final to = ref.watch(toP);
    var entries = List<String>.from(allLocations)..removeWhere((element) => element == from || element == to);

    return DropdownSearch<String>(
      items: entries,
      dropdownDecoratorProps: DropDownDecoratorProps(
        baseStyle: const TextStyle(fontWeight: FontWeight.bold),
        dropdownSearchDecoration: InputDecoration(
          border: InputBorder.none,
          hintText: hinttext,
          hintStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      onChanged: onSubmitted,
      selectedItem: selelctedItem,
      popupProps: PopupProps.menu(
        showSearchBox: true,
        searchDelay: Duration.zero,
        searchFieldProps: const TextFieldProps(
          decoration: InputDecoration(
            hintText: 'Search Locations',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        itemBuilder: customPopupItemBuilderExample2,
        // emptyBuilder: (BuildContext context, String item) {
        //   return const Text('Haha');
        // },
      ),
    );
  }
}

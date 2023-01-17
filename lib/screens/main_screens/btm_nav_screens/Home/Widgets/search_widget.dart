import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rakwa/screens/search_screens/search_screen.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';
import 'package:rakwa/widget/TextFields/text_field_default.dart';

class SearchWidget extends StatefulWidget {
  final bool isItem;
  final String? searchNumber;


  SearchWidget({required this.isItem, this.searchNumber});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  late TextEditingController _searchController;
  late FocusNode _focusNode;
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _focusNode = FocusNode();
    print(SharedPrefController().verifiedEmail);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => SearchScreen(
          searchNumber: widget.searchNumber,
              isItem: widget.isItem,
            ));
      },
      child:TextFieldDefault(
        enable: false,
        hint: 'ابحث عن...',
        prefixIconData: Icons.search,
        suffixIconData: Icons.filter_list,
        suffixColor: Colors.black,
      ),

      // MyTextField(
      //   enabled: false,
      //   focusNode: _focusNode,
      //   onChanged: (p0) {
      //     // setState(() {});
      //   },
      //   hint: 'ابحث عن...',
      //   controller: _searchController,
      //   suffixIcon: IconButton(
      //     onPressed: () {
      //       // _focusNode.requestFocus();
      //     },
      //     icon: const Icon(
      //       Icons.filter_list_sharp,
      //       color: Colors.black,
      //     ),
      //   ),
      //   prefixIcon: const Icon(
      //     Icons.search,
      //     color: AppColors.mainColor,
      //   ),
      // ),
    );
  }
}

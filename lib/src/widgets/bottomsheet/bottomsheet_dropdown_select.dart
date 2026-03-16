import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/utils/base_flutter_extensions.dart';
import 'package:rxdart/rxdart.dart';
import '../../models/base/key_value_model.dart';
import '../widget_search.dart';

// ignore: must_be_immutable
class DropDownSelectionBottomSheet extends StatefulWidget {
  final ScrollController controller;
  final String title;
  final List<KeyValueModel> lsDropDown;
  List<KeyValueModel>? lsVisibleData;
  final KeyValueModel? selected;
  final VoidCallback? deleteClicked;

  DropDownSelectionBottomSheet(
      {required this.title,
      required this.lsDropDown,
      this.selected,
      required this.controller,
      this.deleteClicked,
      Key? key})
      : super(key: key) {
    lsVisibleData = List<KeyValueModel>.from(lsDropDown);
  }

  @override
  _DropDownSelectionBottomSheetState createState() =>
      _DropDownSelectionBottomSheetState();
}

class _DropDownSelectionBottomSheetState
    extends State<DropDownSelectionBottomSheet> {
  TextEditingController? searchController;
  BehaviorSubject<String>? searchOnChange;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchOnChange = BehaviorSubject();
    searchOnChange
        ?.debounceTime(const Duration(milliseconds: 100))
        .listen((text) {
      var textSearch = removeDiacritics(text.toLowerCase().trim());
      var filterResult = text.isEmpty
          ? widget.lsDropDown
          : List<KeyValueModel>.from(widget.lsDropDown)
              .where((element) =>
                  removeDiacritics(element.title?.toLowerCase().trim() ?? '')
                      .contains(textSearch) ==
                  true)
              .toList();
      setState(() {
        widget.lsVisibleData = filterResult;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop(null);
                },
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    widget.title.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              if (widget.deleteClicked != null)
                TextButton(
                  onPressed: () {
                    widget.deleteClicked?.call();
                    Navigator.of(context).pop(null);
                  },
                  child: Text(S.current.xoa),
                )
            ],
          ),
        ),
        const Divider(),
        if (widget.lsDropDown.length > 10)
          _searchWidget(
            context,
          ),
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            controller: widget.controller,
            separatorBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(height: 0),
              );
            },
            itemBuilder: (context, index) {
              var item = widget.lsVisibleData?[index];
              if (item == null) return const SizedBox.shrink();
              return ListTile(
                onTap: () {
                  Navigator.of(context).pop(item);
                },
                title: Text(item.title ?? ''),
                trailing: widget.selected?.key == item.key
                    ? Icon(
                        Icons.check,
                        color: Theme.of(context).colorScheme.secondary,
                      )
                    : const Icon(null),
              );
            },
            itemCount: widget.lsVisibleData?.length ?? 0,
          ),
        )
      ],
    );
  }

  Container _searchWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SearchWidget(
        hint: 'Tìm kiếm...',
        controller: searchController,
        onChanged: _search,
      ),
    );
  }

  void _search(String queryString) {
    searchOnChange?.add(queryString);
  }

  @override
  void dispose() {
    searchController?.dispose();
    super.dispose();
  }
}

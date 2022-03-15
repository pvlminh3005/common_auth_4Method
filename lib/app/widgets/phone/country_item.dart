import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:test_auth_firebase/app/config/constants/countryCode.dart';
import 'package:test_auth_firebase/app/data/models/country_code_model.dart';
import 'package:test_auth_firebase/app/widgets/common/input_custom.dart';

class CountryItem extends StatelessWidget {
  final TextEditingController? controller;
  const CountryItem({required this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InputCustom(
          controller: controller,
          width: 70.0,
          showBorder: false,
          maxLength: 4,
          style: TextStyle(fontWeight: FontWeight.w600),
          keyboardType: TextInputType.phone,
          inputFormatters: [
            // FilteringTextInputFormatter.allow(
            //     RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')),
          ],
          onChanged: (value) {},
        ),
        SizedBox(
          width: 48.0,
          child: DropdownSearch<CountryCodeModel>(
            items: CountryCode.listCountry,
            showSearchBox: true,
            dropdownBuilder: (ctx, item) => Text(''),
            onChanged: (value) {
              if (value != null) {
                controller!.text = '+${value.phoneCode}';
              }
            },
            onFind: (value) async {
              return CountryCode.listCountry
                  .where((element) => element.name.contains(value!))
                  .toList();
            },
            popupItemBuilder: (ctx, item, _) => _PopupItem(item),
            mode: Mode.BOTTOM_SHEET,
            dropdownSearchDecoration: InputDecoration(border: InputBorder.none),
            maxHeight: MediaQuery.of(context).size.height * .4,
          ),
        ),
      ],
    );
  }
}

class _PopupItem extends StatelessWidget {
  final CountryCodeModel item;
  const _PopupItem(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${item.name}',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '+${item.phoneCode}',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

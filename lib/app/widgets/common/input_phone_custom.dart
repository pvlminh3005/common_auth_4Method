import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_auth_firebase/app/packages/firebase_auth/widgets/country_item.dart';

import '../../utils/formatters.dart';
import 'input_custom.dart';

class InputPhoneCustom extends StatelessWidget {
  final TextEditingController? numCodeController;
  final TextEditingController? phoneController;
  final Function(String?)? onChanged;

  const InputPhoneCustom({
    this.numCodeController,
    this.phoneController,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: .5),
        borderRadius: BorderRadius.circular(6.0),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CountryItem(controller: numCodeController),
            Expanded(
              child: InputCustom(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                onChanged: onChanged,
                maxLength: 12,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CustomInputFormatter()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

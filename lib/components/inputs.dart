import 'package:flutter/material.dart';
import 'package:flutter_http_client/components/configModal.dart';
import 'package:flutter_http_client/controller/httpStore.dart';
import 'package:get/get.dart';

class UserInput extends StatelessWidget {
  UserInput({super.key});

  final storeController = Get.find<HttpStoreController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: const BoxDecoration(
                border: Border(
              top: BorderSide(
                color: Color(0xFF202020),
                width: 1,
              ),
            )),
            child: Column(
              children: [
                TextField(
                    controller: storeController.urlController,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16),
                        hintText: 'Address',
                        fillColor: const Color(0xFF202020),
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(16)))),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: onPressed,
                  onLongPress: () {
                    onLongPressed(context);
                  },
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      minimumSize: const Size(double.infinity, 64),
                      backgroundColor: const Color(0xFF1F7CE9)),
                  child: const Text(
                    'Send',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
                  ),
                )
              ],
            ))
      ]),
    );
  }

  void onPressed() async {
    await storeController.sendRequest();
  }

  void onLongPressed(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ConfigModal();
        },
        backgroundColor: const Color(0xFF202020),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))));
  }
}

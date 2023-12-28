import 'package:flutter/material.dart';
import 'package:flutter_http_client/controller/httpStore.dart';
import 'package:get/get.dart';

class ConfigModal extends StatelessWidget {
  ConfigModal({super.key});

  final storeController = Get.find<HttpStoreController>();
  final List<DropdownMenuItem<String>> methodsList = [
    DropdownMenuItem(
        value: 'GET',
        child: Text(
          'GET',
          style: TextStyle(color: Colors.amber.shade300),
        )),
    DropdownMenuItem(
        value: 'POST',
        child: Text('POST', style: TextStyle(color: Colors.green.shade300))),
    DropdownMenuItem(
        value: 'PATCH',
        child: Text('PATCH', style: TextStyle(color: Colors.blue.shade300))),
    DropdownMenuItem(
        value: 'PUT',
        child: Text('PUT', style: TextStyle(color: Colors.cyan.shade300))),
    DropdownMenuItem(
        value: 'DELETE',
        child: Text('DELETE', style: TextStyle(color: Colors.red.shade300))),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Method',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
              ),
              SizedBox(
                width: 150,
                child: Obx(() => DropdownButtonFormField(
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        filled: true,
                        fillColor: Color(0xFF202020),
                      ),
                      items: methodsList,
                      onChanged: onMethodChanged,
                      value: storeController.method.value,
                      style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    )),
              )
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Body',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                child: TextField(
                    maxLines: 10,
                    controller: storeController.bodyController,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16),
                        hintText: 'JSON',
                        fillColor: const Color(0xFF202020),
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(16)))),
              )
            ],
          )),
        ],
      ),
    );
  }

  void onMethodChanged(String? value) {
    storeController.setMethod(value!);
  }
}

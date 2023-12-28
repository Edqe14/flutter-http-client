import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class HttpStoreController extends GetxController {
  final loading = false.obs;
  final success = false.obs;

  final response = ''.obs;
  final method = 'GET'.obs;
  final headers = RxMap<String, String>({});

  final urlController = TextEditingController();
  final bodyController = TextEditingController();

  final dio = Dio();

  updateResponse(String value) {
    response(value);
  }

  updateHeaders(Map<String, String> value) {
    headers(value);
  }

  setMethod(String value) {
    method(value);
  }

  setHeader(String key, String value) {
    headers.putIfAbsent(key, () => value);
  }

  removeHeader(String key) {
    headers.remove(key);
  }

  getStatusColor() {
    if (loading.value || response.value.isEmpty) {
      return const Color(0xFF8B8B8B);
    }

    if (success.value) {
      return const Color(0xFF18E113);
    }

    return const Color(0xFFE91F1F);
  }

  sendRequest() async {
    try {
      loading(true);
      final response = await dio.request<String>(urlController.text,
          data: bodyController.text.isNotEmpty ? bodyController.text : null,
          options: Options(
              method: method.value,
              headers: {
                ...headers,
                'Content-Type': 'application/json; charset=UTF-8'
              },
              sendTimeout: const Duration(seconds: 5)));

      loading(false);
      success(response.statusCode! >= 200 && response.statusCode! < 300);

      if (response.data != null) {
        updateResponse(response.data!);
      }
    } catch (e) {
      loading(false);
      success(false);
      updateResponse(e.toString());
    }
  }
}

import 'dart:convert';

import '../../../core/services/api_service.dart';
import '../models/notification_model.dart';

class NotificationRepository {
  final ApiService _apiService =
      ApiService();

  Future<List<NotificationModel>>
      getNotifications() async {

    final response =
        await _apiService.get(
      '/client/notifications',
    );

    if (response.statusCode == 200) {

      final List data =
          jsonDecode(response.body);

      return data
          .map(
            (e) =>
                NotificationModel.fromJson(e),
          )
          .toList();
    }

    throw Exception(
      'Erreur chargement notifications',
    );
  }

  Future<void>
      marquerCommeLue(
    int id,
  ) async {

    final response =
        await _apiService.put(
      '/client/notifications/$id/lu',
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Erreur notification',
      );
    }
  }

  Future<void>
      marquerToutCommeLu()
      async {

    final response =
        await _apiService.put(
      '/client/notifications/lu-tout',
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Erreur notifications',
      );
    }
  }
}
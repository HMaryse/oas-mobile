import 'package:flutter/material.dart';

import '../../core/theme/couleurs_app.dart';
import 'models/notification_model.dart';
import 'repository/notification_repository.dart';

class NotificationsEcran extends StatefulWidget {
  const NotificationsEcran({
    super.key,
  });

  @override
  State<NotificationsEcran> createState() =>
      _NotificationsEcranState();
}

class _NotificationsEcranState
    extends State<NotificationsEcran> {
  final NotificationRepository repository =
      NotificationRepository();

  List<NotificationModel> notifications =
      [];

  bool chargement = true;

  @override
  void initState() {
    super.initState();
    chargerNotifications();
  }

  Future<void>
      chargerNotifications() async {
    try {
      final resultat =
          await repository
              .getNotifications();

      setState(() {
        notifications = resultat;
      });
    } catch (e) {
      debugPrint(
        "Erreur notifications : $e",
      );
    } finally {
      setState(() {
        chargement = false;
      });
    }
  }

  Future<void>
      marquerCommeLu(
    NotificationModel notification,
  ) async {
    try {
      await repository
          .marquerCommeLue(
        notification.id,
      );

      chargerNotifications();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void>
      marquerToutCommeLu() async {
    try {
      await repository
          .marquerToutCommeLu();

      chargerNotifications();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  String formaterDate(
    String date,
  ) {
    if (date.isEmpty) return "";

    try {
      final d =
          DateTime.parse(date);

      return "${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}";
    } catch (_) {
      return date;
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor:
          CouleursApp.grisFond,

      appBar: AppBar(
        backgroundColor:
            CouleursApp.grisFond,
        elevation: 0,
        centerTitle: true,

        title: const Text(
          "Notifications",
          style: TextStyle(
            color:
                CouleursApp.bleuFonce,
            fontWeight:
                FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            onPressed:
                marquerToutCommeLu,
            icon: const Icon(
              Icons.done_all,
              color:
                  CouleursApp.orange,
            ),
          ),
        ],
      ),

      body: chargement
          ? const Center(
              child:
                  CircularProgressIndicator(),
            )
          : notifications.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .center,

                    children: const [
                      Icon(
                        Icons.notifications_none,
                        size: 70,
                        color:
                            Colors.grey,
                      ),

                      SizedBox(
                        height: 12,
                      ),

                      Text(
                        "Aucune notification",
                        style:
                            TextStyle(
                          color:
                              Colors.grey,
                          fontSize:
                              16,
                        ),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh:
                      chargerNotifications,

                  child: ListView.builder(
                    padding:
                        const EdgeInsets
                            .all(16),

                    itemCount:
                        notifications
                            .length,

                    itemBuilder:
                        (
                      context,
                      index,
                    ) {
                      final notif =
                          notifications[
                              index];

                      return GestureDetector(
                        onTap: () =>
                            marquerCommeLu(
                          notif,
                        ),

                        child: Container(
                          margin:
                              const EdgeInsets.only(
                            bottom:
                                12,
                          ),

                          padding:
                              const EdgeInsets.all(
                            14,
                          ),

                          decoration:
                              BoxDecoration(
                            color:
                                Colors.white,

                            borderRadius:
                                BorderRadius.circular(
                              12,
                            ),

                            boxShadow: [
                              BoxShadow(
                                color: Colors
                                    .black
                                    .withOpacity(
                                  0.05,
                                ),

                                blurRadius:
                                    8,

                                offset:
                                    const Offset(
                                  0,
                                  3,
                                ),
                              ),
                            ],
                          ),

                          child: Row(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.all(
                                  10,
                                ),

                                decoration:
                                    BoxDecoration(
                                  color: notif.lu
                                      ? Colors
                                          .grey
                                          .withOpacity(
                                          0.1,
                                        )
                                      : CouleursApp
                                          .orange
                                          .withOpacity(
                                          0.15,
                                        ),

                                  borderRadius:
                                      BorderRadius.circular(
                                    10,
                                  ),
                                ),

                                child: Icon(
                                  Icons
                                      .notifications_outlined,

                                  color: notif.lu
                                      ? Colors
                                          .grey
                                      : CouleursApp
                                          .orange,
                                ),
                              ),

                              const SizedBox(
                                width: 12,
                              ),

                              Expanded(
                                child:
                                    Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,

                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child:
                                              Text(
                                            notif.titre,

                                            style:
                                                const TextStyle(
                                              fontWeight:
                                                  FontWeight.bold,
                                              fontSize:
                                                  15,
                                            ),
                                          ),
                                        ),

                                        if (!notif
                                            .lu)
                                          Container(
                                            width:
                                                10,
                                            height:
                                                10,

                                            decoration:
                                                const BoxDecoration(
                                              color:
                                                  Colors.red,
                                              shape:
                                                  BoxShape.circle,
                                            ),
                                          ),
                                      ],
                                    ),

                                    const SizedBox(
                                      height:
                                          6,
                                    ),

                                    Text(
                                      notif
                                          .message,

                                      style:
                                          const TextStyle(
                                        color:
                                            Colors.grey,
                                      ),
                                    ),

                                    const SizedBox(
                                      height:
                                          8,
                                    ),

                                    Text(
                                      formaterDate(
                                        notif
                                            .dateCreation,
                                      ),

                                      style:
                                          const TextStyle(
                                        fontSize:
                                            12,
                                        color:
                                            Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
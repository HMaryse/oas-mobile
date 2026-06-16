import 'package:flutter/material.dart';
import '../../core/theme/couleurs_app.dart';

class ParametresEcran extends StatefulWidget {
  const ParametresEcran({super.key});

  @override
  State<ParametresEcran> createState() => _ParametresEcranState();
}

class _ParametresEcranState extends State<ParametresEcran> {
  bool notificationsRDV = true;
  bool notificationsReparations = true;
  bool notificationsFactures = false;
  bool notificationsSMS = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CouleursApp.grisFond,

      appBar: AppBar(
        backgroundColor: CouleursApp.grisFond,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: CouleursApp.orange),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Paramètres",
          style: TextStyle(color: CouleursApp.bleuFonce, fontWeight: FontWeight.bold),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          // NOTIFICATIONS
          _sectionTitre("Notifications"),
          const SizedBox(height: 10),

          _toggleTile(
            icone: Icons.calendar_month_outlined,
            titre: "Rappels de rendez-vous",
            sousTitre: "Recevoir un rappel avant chaque RDV",
            valeur: notificationsRDV,
            onChanged: (v) => setState(() => notificationsRDV = v),
          ),

          _toggleTile(
            icone: Icons.build_outlined,
            titre: "Suivi des réparations",
            sousTitre: "Être notifié du statut de vos réparations",
            valeur: notificationsReparations,
            onChanged: (v) => setState(() => notificationsReparations = v),
          ),

          _toggleTile(
            icone: Icons.receipt_long_outlined,
            titre: "Nouvelles factures",
            sousTitre: "Recevoir une alerte à chaque nouvelle facture",
            valeur: notificationsFactures,
            onChanged: (v) => setState(() => notificationsFactures = v),
          ),

          _toggleTile(
            icone: Icons.sms_outlined,
            titre: "Notifications SMS",
            sousTitre: "Recevoir les alertes par SMS",
            valeur: notificationsSMS,
            onChanged: (v) => setState(() => notificationsSMS = v),
          ),

          const SizedBox(height: 24),

          // COMPTE
          _sectionTitre("Compte"),
          const SizedBox(height: 10),

          _actionTile(
            icone: Icons.lock_outline,
            titre: "Changer le mot de passe",
            onTap: () => _snackbar(context, "Changement de mot de passe à venir"),
          ),

          _actionTile(
            icone: Icons.language,
            titre: "Langue",
            trailing: const Text("Français", style: TextStyle(color: CouleursApp.grisTexte)),
            onTap: () => _snackbar(context, "Sélection de langue à venir"),
          ),

          _actionTile(
            icone: Icons.privacy_tip_outlined,
            titre: "Confidentialité",
            onTap: () => _snackbar(context, "Politique de confidentialité à venir"),
          ),

          const SizedBox(height: 24),

          // ASSISTANCE
          _sectionTitre("Assistance"),
          const SizedBox(height: 10),

          _actionTile(
            icone: Icons.help_outline,
            titre: "Centre d'aide",
            onTap: () => _snackbar(context, "Centre d'aide à venir"),
          ),

          _actionTile(
            icone: Icons.chat_bubble_outline,
            titre: "Contacter le support",
            onTap: () => _snackbar(context, "Support à venir"),
          ),

          _actionTile(
            icone: Icons.info_outline,
            titre: "À propos",
            trailing: const Text("v1.0.0", style: TextStyle(color: CouleursApp.grisTexte)),
            onTap: () {},
          ),

          const SizedBox(height: 24),

          // SUPPRIMER COMPTE
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
              ),
              title: const Text(
                "Supprimer mon compte",
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
              ),
              trailing: const Icon(Icons.chevron_right, color: Colors.red),
              onTap: () => _confirmerSuppression(context),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _sectionTitre(String titre) {
    return Text(
      titre.toUpperCase(),
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: CouleursApp.grisTexte,
        fontSize: 12,
        letterSpacing: 0.8,
      ),
    );
  }

  Widget _toggleTile({
    required IconData icone,
    required String titre,
    required String sousTitre,
    required bool valeur,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: CouleursApp.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icone, color: CouleursApp.orange, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(titre, style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(sousTitre, style: const TextStyle(color: CouleursApp.grisTexte, fontSize: 12)),
              ],
            ),
          ),
          Switch(
            value: valeur,
            onChanged: onChanged,
            activeColor: CouleursApp.orange,
          ),
        ],
      ),
    );
  }

  Widget _actionTile({
    required IconData icone,
    required String titre,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: CouleursApp.orange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icone, color: CouleursApp.orange, size: 20),
        ),
        title: Text(titre, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: trailing ?? const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  void _snackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _confirmerSuppression(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Supprimer le compte ?"),
        content: const Text("Cette action est irréversible. Toutes vos données seront supprimées."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Annuler"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context),
            child: const Text("Supprimer"),
          ),
        ],
      ),
    );
  }
}

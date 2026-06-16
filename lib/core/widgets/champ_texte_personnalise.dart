import 'package:flutter/material.dart';
import '../theme/couleurs_app.dart';

class ChampTextePersonnalise extends StatefulWidget {
  final String hintText;
  final IconData icone;
  final bool motDePasse;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  const ChampTextePersonnalise({
    super.key,
    required this.hintText,
    required this.icone,
    this.motDePasse = false,
    this.controller,
    this.keyboardType,
  });

  @override
  State<ChampTextePersonnalise> createState() =>
      _ChampTextePersonnaliseState();
}

class _ChampTextePersonnaliseState
    extends State<ChampTextePersonnalise> {

  late bool masquerTexte;

  @override
  void initState() {
    super.initState();
    masquerTexte = widget.motDePasse;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: masquerTexte,

      decoration: InputDecoration(
        hintText: widget.hintText,

        prefixIcon: Icon(
          widget.icone,
          color: CouleursApp.grisTexte,
        ),

        suffixIcon: widget.motDePasse
            ? IconButton(
                onPressed: () {
                  setState(() {
                    masquerTexte = !masquerTexte;
                  });
                },
                icon: Icon(
                  masquerTexte
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
              )
            : null,

        filled: true,
        fillColor: Colors.white,

        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 16,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: CouleursApp.bordure,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: CouleursApp.orange,
            width: 2,
          ),
        ),
      ),
    );
  }
}
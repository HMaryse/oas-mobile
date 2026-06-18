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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.06,
            ),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: masquerTexte,

        decoration: InputDecoration(
          hintText: widget.hintText,

          hintStyle: const TextStyle(
            color: CouleursApp.grisTexte,
          ),

          prefixIcon: Icon(
            widget.icone,
            color: CouleursApp.grisTexte,
          ),

          suffixIcon: widget.motDePasse
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      masquerTexte =
                          !masquerTexte;
                    });
                  },
                  icon: Icon(
                    masquerTexte
                        ? Icons
                            .visibility_off_outlined
                        : Icons
                            .visibility_outlined,
                  ),
                )
              : null,

          filled: true,
          fillColor: Colors.white,

          contentPadding:
              const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 16,
          ),

          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),

          enabledBorder:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),

          focusedBorder:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(8),
            borderSide:
                const BorderSide(
              color: CouleursApp.orange,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
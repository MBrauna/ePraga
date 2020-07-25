import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EPragaField extends StatefulWidget {
  // Declaração de conteúdos para Campo
  bool leitura, sugestao, senha;
  Color corCursor, corBgIcone;
  double campoAlto, campoBaixo, campoDireita, campoEsquerda;
  FaIcon icone;
  int tamanhoTexto, minimoLinhas, maximoLinhas;
  MaskTextInputFormatter mascara;
  OverlayVisibilityMode iconeVisibilidade;
  String texto;
  TextInputType tipoTeclado;
  var fncFinalizado, fncEdicao, fncCompleto, controlador;
  // Declaração de conteúdos para Campo

  EPragaField({
    this.campoAlto = 0.0,
    this.campoBaixo = 0.0,
    this.campoDireita = 0.0,
    this.campoEsquerda = 0.0,
    this.corCursor = Colors.blue,
    this.corBgIcone = Colors.blue,
    this.controlador,
    this.fncFinalizado,
    this.fncEdicao,
    this.fncCompleto,
    this.icone,
    this.leitura = false,
    this.maximoLinhas = 1,
    this.mascara,
    this.minimoLinhas = 1,
    this.senha = false,
    this.sugestao = false,
    this.tamanhoTexto = 250,
    this.texto = '',
    this.tipoTeclado = TextInputType.text,
  });

  @override
  _EPragaField createState() => _EPragaField();
} // class Campo extends StatefulWidget { ... }

class _EPragaField extends State<EPragaField> {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.only(
        top: widget.campoAlto,
        bottom: widget.campoBaixo,
        left: widget.campoEsquerda,
        right: widget.campoDireita,
      ),
      child: CupertinoTextField(
        autocorrect: false,
        clearButtonMode: (widget.leitura)
            ? OverlayVisibilityMode.never
            : OverlayVisibilityMode.editing,
        cursorColor: widget.corCursor,
        enableSuggestions: widget.sugestao,
        keyboardType: widget.tipoTeclado,
        maxLength: widget.tamanhoTexto,
        maxLines: widget.maximoLinhas,
        minLines: widget.minimoLinhas,
        maxLengthEnforced: true,
        controller: widget.controlador,
        inputFormatters: (widget.mascara == null) ? null : [widget.mascara],
        onChanged: widget.fncEdicao,
        onEditingComplete: widget.fncCompleto,
        onSubmitted: widget.fncFinalizado,
        placeholder: widget.texto,
        obscureText: widget.senha,
        prefix: (widget.icone == null)
            ? null
            : Container(
                padding: EdgeInsets.only(
                  top: 10.0,
                  bottom: 10.0,
                  left: 10.0,
                  right: 10.0,
                ),
                color: widget.corBgIcone,
                child: widget.icone,
              ),
        prefixMode: OverlayVisibilityMode.always,
        readOnly: widget.leitura,
        enabled: !widget.leitura,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),
      ),
    );
  } // Widget build(BuildContext context) { ... }
} // class _Campo extends State<Campo> { ... }

import 'package:flutter/material.dart';

//-------------------------- Form de texto blanco ------------------------------
class FormTextoBlanco extends StatefulWidget {
  String text;
  String nombre;
  int maxlines;
  bool enable;
  bool ocultar;
  Function onDone;
  TextEditingController controller;
  FocusNode focusNode;
  Function onChanged;
  Function validator;
  TextInputType tipoTeclado;
  IconData icon;
  FormTextoBlanco(
      {this.text,
      this.icon,
      this.nombre,
      this.validator,
      this.focusNode,
      this.controller,
      this.maxlines,
      this.enable,
      this.ocultar,
      this.onChanged,
      this.onDone,
      this.tipoTeclado});

  @override
  _FormTextoBlancoState createState() => _FormTextoBlancoState();
}

class _FormTextoBlancoState extends State<FormTextoBlanco> {
  // @override
  // void initState() {
  //   widget.controller = TextEditingController();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    TextStyle texto = TextStyle(
        fontSize: MediaQuery.of(context).size.height / 42,
        color: Device.instance.isDarkMode ? Colors.white : Colors.black,
        letterSpacing: 0.5,
        fontWeight: FontWeight.bold);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: widget.tipoTeclado,
        obscureText: widget.ocultar != null ? widget.ocultar : false,
        enabled: widget.enable,
        textCapitalization: widget.tipoTeclado == TextInputType.emailAddress ? TextCapitalization.none : TextCapitalization.sentences,
        focusNode: widget.focusNode,
        //focusNode: FocusNode(canRequestFocus: false),
        // autofocus: false,
        enableInteractiveSelection: true,
        style: texto,
        maxLines: widget.maxlines != null ? widget.maxlines : 1,
        minLines: 1,
        onFieldSubmitted: (String text) {
          if (widget.onDone != null) widget.onDone();
        },
        onChanged: (String nuevo) {
          widget.text = nuevo;
          if (widget.onChanged != null) widget.onChanged(nuevo);
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.validator,

        controller: widget.controller,
        //autofocus: true,
        decoration: InputDecoration(
            icon: Icon(
              widget.icon,
              color: Colors.white,
              size: 33,
            ),
            filled: true,
            fillColor: Device.instance.isDarkMode ? Colors.black.withOpacity(0.2) : Colors.white.withOpacity(0.6),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.white70, width: 1.5)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: Colors.white70, width: 1.5)),
            labelStyle: texto,
            labelText: widget.nombre),
      ),
    );
  }
}

class FormEntry {
  FormTextoBlanco formTextoBlanco;
  TextEditingController controller = TextEditingController();
  FormEntry({this.formTextoBlanco, this.controller});
}

//------------------------ Entrada de texto azul -------------------------------
class EntradaTexto extends StatefulWidget {
  double alto;
  double ancho;
  String text;
  String nombre;
  int maxlines;
  TextEditingController controller;
  bool enable;
  EntradaTexto({this.alto, this.ancho, this.text, this.nombre, this.controller, this.maxlines, this.enable});

  @override
  _EntradaTextoState createState() => _EntradaTextoState();
}

class _EntradaTextoState extends State<EntradaTexto> {
  @override
  Widget build(BuildContext context) {
    TextStyle texto = TextStyle(fontSize: 25, color: Colors.blue[700], letterSpacing: -0.5, fontWeight: FontWeight.bold);

    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 5, top: 10, bottom: 10),
      child: TextField(
        enabled: widget.enable != null ? widget.enable : true,
        textCapitalization: TextCapitalization.sentences,

        enableInteractiveSelection: true,
        style: texto,
        maxLines: widget.maxlines != null ? widget.maxlines : 1,
        minLines: 1,
        onChanged: (String nuevo) {
          widget.text = nuevo;
        },

        controller: widget.controller,
        //autofocus: true,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.blue[700], width: 1.5)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide(color: Colors.blue[700], width: 1.5)),
            labelStyle: texto,
            labelText: widget.nombre),
      ),
    );
  }
}

//----------------------- Entrada de texto blanco ------------------------------
class EntradaTextoBlanco extends StatefulWidget {
  String text;
  String nombre;
  int maxlines;
  double fontSize;
  bool enable;
  bool ocultar;
  Function onDone;
  TextEditingController controller;
  FocusNode focusNode;
  Function onChanged;
  TextInputType tipoTeclado;
  IconData icon;
  EntradaTextoBlanco(
      {this.text,
      this.nombre,
      this.focusNode,
      this.controller,
      this.maxlines,
      this.enable,
      this.ocultar,
      this.onChanged,
      this.onDone,
      this.fontSize = 23,
      this.tipoTeclado,
      this.icon});

  @override
  _EntradaTextoBlancoState createState() => _EntradaTextoBlancoState();
}

class _EntradaTextoBlancoState extends State<EntradaTextoBlanco> {
  @override
  void initState() {
    widget.controller = TextEditingController(text: widget.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle texto = TextStyle(
      fontSize: widget.fontSize,
      color: Colors.white,
      letterSpacing: -0.5,
    );

    return Padding(
      padding: EdgeInsets.only(top: 5),
      child: TextField(
        keyboardType: widget.tipoTeclado,
        onSubmitted: widget.onDone != null
            ? (String texto) {
                widget.onDone(texto);
              }
            : (String texto) {},
        obscureText: widget.ocultar != null ? widget.ocultar : false,
        enabled: widget.enable,
        textCapitalization: widget.tipoTeclado == TextInputType.emailAddress || widget.tipoTeclado == TextInputType.visiblePassword
            ? TextCapitalization.none
            : TextCapitalization.sentences,
        focusNode: widget.focusNode,
        //focusNode: FocusNode(canRequestFocus: false),
        // autofocus: false,
        enableInteractiveSelection: true,
        style: texto,
        maxLines: widget.maxlines != null ? widget.maxlines : 1,
        minLines: 1,
        onChanged: (String nuevo) {
          widget.text = nuevo;
          if (widget.onChanged != null) widget.onChanged(nuevo);
        },

        controller: widget.controller,
        //autofocus: true,
        decoration: InputDecoration(
            icon: widget.icon != null
                ? Icon(
                    widget.icon,
                    size: 28,
                    color: Colors.white,
                  )
                : null,
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.white, width: 1.5)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide(color: Colors.white, width: 1.5)),
            labelStyle: texto,
            labelText: widget.nombre),
      ),
    );
  }
}

//----------------------- Entrada de texto simple ------------------------------
class EntradaTextoSencilla extends StatefulWidget {
  TextEditingController controller = TextEditingController();
  String nombreEntrada;

  EntradaTextoSencilla({this.nombreEntrada, this.controller});

  @override
  _EntradaTextoSencillaState createState() => _EntradaTextoSencillaState();
}

class _EntradaTextoSencillaState extends State<EntradaTextoSencilla> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.nombreEntrada,
        ),
      ),
    );
  }
}

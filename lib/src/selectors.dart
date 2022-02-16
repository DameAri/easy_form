import 'package:flutter/material.dart';

//-------------------------- Selector de fecha ---------------------------------
class SelectorFecha extends StatefulWidget {
  DateTime inicio;
  String nombreFecha;
  bool soloFecha;
  bool darkMode;
  Function onChanged;
  SelectorFecha({Key? key, required this.inicio, this.soloFecha = false, this.darkMode = false, required this.nombreFecha, required this.onChanged})
      : super(key: key);
  @override
  _SelectorFechaState createState() => _SelectorFechaState();
}

class _SelectorFechaState extends State<SelectorFecha> {
  Future<void> _seleccionarDateInicio(BuildContext context) async {
    DateTime? picked =
        await showDatePicker(context: context, initialDate: widget.inicio, firstDate: DateTime(1930, 1), lastDate: DateTime(DateTime.now().year + 2));
    TimeOfDay? aux = TimeOfDay.now();
    if (!widget.soloFecha) {
      aux = await showTimePicker(
        initialTime: TimeOfDay.now(),
        context: context,
      );
      picked = picked!.add(Duration(hours: aux!.hour, minutes: aux.minute));
    }
    widget.onChanged(picked);

    if (picked != null && picked != widget.inicio) {
      setState(() {
        widget.inicio = picked!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.inicio == null) widget.inicio = DateTime.now();
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: ListTile(
        title: Text(
          widget.nombreFecha +
              ':  \n' +
              widget.inicio.day.toString() +
              ' / ' +
              widget.inicio.month.toString() +
              ' / ' +
              widget.inicio.year.toString(),
          style: TextStyle(fontSize: 22, color: widget.darkMode ? Colors.white : Colors.black),
        ), //Fecha
        subtitle: widget.soloFecha
            ? null
            : Text(
                'Hora:  ' +
                    widget.inicio.hour.toString() +
                    ' : ' +
                    (widget.inicio.minute < 10 ? '0' + widget.inicio.minute.toString() : widget.inicio.minute.toString()),
                style: TextStyle(
                  color: widget.darkMode ? Colors.white70 : Colors.black54,
                  fontSize: 22,
                ),
              ), //Hora
        trailing: IconButton(
          icon: Icon(
            Icons.date_range,
            color: widget.darkMode ? Colors.white70 : Colors.black54,
            size: 23,
          ),
          onPressed: () async {
            _seleccionarDateInicio(context);
          },
        ), //selector
      ),
    );
  }
}

//------------------- Selector de fecha Inicial y final ------------------------
class SelectorRangoFechas extends StatefulWidget {
  DateTime inicio;
  DateTime finaliza;
  bool soloFecha;
  Function onChanged;
  Function onChangedFin;
  SelectorRangoFechas({required this.inicio, this.soloFecha = true, required this.finaliza, required this.onChanged, required this.onChangedFin});
  @override
  _SelectorRangoFechasState createState() => _SelectorRangoFechasState();
}

class _SelectorRangoFechasState extends State<SelectorRangoFechas> {
  Future<void> _seleccionarDateInicio(BuildContext context) async {
    DateTime? picked =
        await showDatePicker(context: context, initialDate: widget.inicio, firstDate: DateTime(1930, 1), lastDate: DateTime(DateTime.now().year + 2));
    TimeOfDay? aux = TimeOfDay.now();
    if (!widget.soloFecha) {
      aux = await showTimePicker(
        initialTime: TimeOfDay.now(),
        context: context,
      );
      picked = picked!.add(Duration(hours: aux!.hour, minutes: aux.minute));
    }
    widget.onChanged(picked);

    if (picked != null && picked != widget.inicio) {
      setState(() {
        widget.inicio = picked!;
      });
    }
  }

  Future<void> _seleccionarDateFin(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context, initialDate: widget.finaliza, firstDate: DateTime(1930, 1), lastDate: DateTime(DateTime.now().year + 2));
    TimeOfDay aux = TimeOfDay.now();
    if (!widget.soloFecha) {
      aux = await showTimePicker(
        initialTime: TimeOfDay.now(),
        context: context,
      );
      picked = picked.add(Duration(hours: aux.hour, minutes: aux.minute));
    }
    widget.onChangedFin(picked);

    if (picked != null && picked != widget.finaliza) {
      setState(() {
//        widget.hora = aux;
        widget.finaliza = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    TextStyle text = TextStyle(color: Colors.white, fontSize: 18);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: WithContainer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: screenWidth / 2.5,
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Column(
                  children: <Widget>[
                    IconButton(
                      padding: EdgeInsets.all(0),
                      icon: Icon(
                        Icons.date_range,
                        color: Colors.green[700],
                        size: 25,
                      ),
                      onPressed: () async {
                        _seleccionarDateInicio(context);
                      },
                    ), //selector
                    ListTile(
                      title: Text(
                        'Fecha inicial' +
                            '\n' +
                            widget.inicio.day.toString() +
                            ' / ' +
                            widget.inicio.month.toString() +
                            ' / ' +
                            widget.inicio.year.toString(),
                        textAlign: TextAlign.center,
                        style: text,
                      ), //Fecha
                      subtitle: widget.soloFecha
                          ? null
                          : Text(
                              'Hora:  ' +
                                  widget.inicio.hour.toString() +
                                  ' : ' +
                                  (widget.inicio.minute < 10 ? '0' + widget.inicio.minute.toString() : widget.inicio.minute.toString()),
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 22,
                              ),
                            ), //Hora
                    ),
                  ],
                ),
              ),
            ), //Fecha Inicio
            // Container(
            //   width: isLandscape ? (screenWidth / 30) : screenWidth / 10,
            // ),
            Container(
              width: screenWidth / 2.5,
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Column(
                  children: <Widget>[
                    IconButton(
                      padding: EdgeInsets.all(0),
                      icon: Icon(
                        Icons.date_range,
                        color: Colors.blue[800],
                        size: 25,
                      ),
                      onPressed: () async {
                        _seleccionarDateFin(context);
                      },
                    ), //selector
                    ListTile(
                      title: Text(
                        'Fecha final' +
                            '\n' +
                            widget.finaliza.day.toString() +
                            ' / ' +
                            widget.finaliza.month.toString() +
                            ' / ' +
                            widget.finaliza.year.toString(),
                        textAlign: TextAlign.center,
                        style: text,
                      ), //Fecha
                      subtitle: widget.soloFecha
                          ? null
                          : Text(
                              'Hora:  ' +
                                  widget.inicio.hour.toString() +
                                  ' : ' +
                                  (widget.inicio.minute < 10 ? '0' + widget.inicio.minute.toString() : widget.inicio.minute.toString()),
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 22,
                              ),
                            ), //Hora
                    ),
                  ],
                ),
              ),
            ), // Fecha Final
          ],
        ),
      ),
    );
  }
}

//----------------------------- Menu Plegable ----------------------------------
class MenuPlegable extends StatefulWidget {
  String value;
  List<String> options = [];
  Function onChanged;
  String titulo;
  FocusNode focusNode;
  bool darkMode;
  MenuPlegable({this.titulo, this.value, this.options, this.onChanged, this.focusNode, this.darkMode = false});
  @override
  _MenuPlegableState createState() => _MenuPlegableState();
}

class _MenuPlegableState extends State<MenuPlegable> {
  @override
  Widget build(BuildContext context) {
    if (widget.value != null) {
      if (!widget.options.contains(widget.value)) {
        widget.options.add(widget.value);
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            widget.titulo,
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 22, color: widget.darkMode ? Colors.white : Colors.blue[900], letterSpacing: -0.5, fontWeight: FontWeight.bold),
          ),
          FittedBox(
            child: DropdownButton<String>(
              focusNode: widget.focusNode,
              value: widget.value,
              icon: Icon(
                Icons.arrow_downward,
                color: widget.darkMode
                    ? Colors.white
                    : Device.instance.isDarkMode
                        ? Colors.blue[800]
                        : Interfaz.instance.fondo,
              ),
              menuMaxHeight: 500,
              borderRadius: BorderRadius.circular(20),
              itemHeight: 50,
              iconSize: 30,
              elevation: 16,
              style: TextStyle(color: Colors.white, fontSize: 18),
              dropdownColor: Colors.white70,
              underline: Container(
                height: 2,
                color: widget.darkMode
                    ? Colors.white
                    : Device.instance.isDarkMode
                        ? Colors.blue[900]
                        : Interfaz.instance.fondo,
              ),
              onChanged: (nuevo) {
                setState(() {
                  widget.value = nuevo;
                });
                if (widget.onChanged != null) widget.onChanged(nuevo);
              },
              items: widget.options.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 360,
                          color: Device.instance.isDarkMode ? Colors.blue[900] : Interfaz.instance.fondo,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              value,
                              textAlign: TextAlign.center,
                            ),
                          )),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:handy_dialogs/handy_dialogs.dart';

import 'constantes.dart';
import 'selectors.dart';
import 'textfields.dart';

enum EntryType { text, textLong, number, date, bool, selector }

class ObjectEntry {
  EntryType type;
  String fieldName;
  String name;
  dynamic value;
  List<String> options;
  ObjectEntry({@required this.name, @required this.type, @required this.fieldName, this.options, this.value});
  Widget toWidget() => ObjectEntryCard(this);
}

class ObjectEntryCard extends StatefulWidget {
  ObjectEntry objectEntry;
  ObjectEntryCard(this.objectEntry);
  @override
  _ObjectEntryCardState createState() => _ObjectEntryCardState();
}

class _ObjectEntryCardState extends State<ObjectEntryCard> {
  @override
  Widget build(BuildContext context) {
    Widget aux;

    switch (widget.objectEntry.type) {
      case EntryType.text:
        if (widget.objectEntry.value == null) {
          widget.objectEntry.value = '';
        }
        aux = Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: fondoLogo2,
          child: EntradaTextoBlanco(
            nombre: widget.objectEntry.name,
            text: widget.objectEntry.value ?? '',
            maxlines: 1,
            onChanged: (newValue) {
              setState(() {
                widget.objectEntry.value = newValue;
              });
            },
          ),
        );
        break;
      case EntryType.textLong:
        if (widget.objectEntry.value == null) {
          widget.objectEntry.value = '';
        }
        aux = Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: fondoLogo2,
          child: EntradaTextoBlanco(
            nombre: widget.objectEntry.name,
            text: widget.objectEntry.value.toString(),
            maxlines: 10,
            onChanged: (newValue) {
              setState(() {
                widget.objectEntry.value = newValue;
              });
            },
          ),
        );
        break;
      case EntryType.number:
        if (widget.objectEntry.value == null) {
          widget.objectEntry.value = '';
        }
        aux = Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: fondoLogo2,
          child: EntradaTextoBlanco(
            nombre: widget.objectEntry.name,
            text: widget.objectEntry.value.toString(),
            maxlines: 1,
            tipoTeclado: TextInputType.numberWithOptions(decimal: true),
            onChanged: (newValue) {
              setState(() {
                widget.objectEntry.value = newValue;
              });
            },
          ),
        );
        break;
      case EntryType.date:
        DateTime time;
        if (widget.objectEntry.value is DateTime) {
          time = widget.objectEntry.value;
        } else {
          time = DateTime.tryParse(widget.objectEntry.value ?? "");
        }
        aux = Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: fondoLogo2,
          child: SelectorFecha(
            darkMode: true,
            inicio: time,
            nombreFecha: widget.objectEntry.name,
            onChanged: (newValue) {
              setState(() {
                widget.objectEntry.value = newValue;
              });
            },
          ),
        );
        break;
      case EntryType.bool:
        aux = Padding(
          padding: const EdgeInsets.all(5),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.blue,
            child: Check(
              condicion: widget.objectEntry.name,
              seleccionado: widget.objectEntry.value ?? false,
              onChanged: (newValue) {
                setState(() {
                  widget.objectEntry.value = newValue;
                });
              },
              whiteMode: true,
            ),
          ),
        );
        break;
      case EntryType.selector:
        aux = Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: fondoLogo2,
          child: MenuPlegable(
            darkMode: true,
            titulo: widget.objectEntry.name,
            value: widget.objectEntry.value,
            onChanged: (newValue) {
              setState(() {
                widget.objectEntry.value = newValue;
              });
            },
            options: widget.objectEntry.options,
          ),
        );
        break;
    }
    return aux;
  }
}

class NewObjectForm extends StatefulWidget {
  DocumentSnapshot<Map<String, dynamic>> snapReference;
  Map<String, dynamic> data;
  String title;
  List<ObjectEntry> entries;
  bool isEdit;
  String collectionName;
  NewObjectForm(this.snapReference, this.entries, {this.title = 'Crear nuevo', this.data, this.isEdit = false, this.collectionName});

  @override
  _NewObjectFormState createState() => _NewObjectFormState();
}

class _NewObjectFormState extends State<NewObjectForm> {
  bool loading = false;
  bool cancel = false;

  save() async {
    if (!loading) {
      setState(() {
        loading = true;
      });
      Map<String, dynamic> data = widget.data ?? {};
      data['createdAt'] = DateTime.now().toString();
      for (var entry in widget.entries) {
        if (entry.type == EntryType.number && !(entry.value is double)) {
          if (double.tryParse(entry.value) != null || entry.value == null) {
            entry.value = double.tryParse(entry.value) ?? 0;
          } else {
            cancel = true;
            break;
          }
        }
        if (entry.type == EntryType.date) {
          entry.value = entry.value.toString();
        }
        if (entry.type == EntryType.bool) {
          entry.value = entry.value ?? false;
        }
        data[entry.fieldName] = entry.value;
      }
      if (!cancel) {
        if (widget.isEdit)
          await widget.snapReference.reference.update(data);
        else
          await widget.snapReference.reference.collection(widget.collectionName).add(data);
      } else {
        showText(context, 'Información invalida', 'Revise el formato de los campos para continuar');
      }
      pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WithBackground(
        child: ListView(
          padding: EdgeInsets.only(top: 10, bottom: 120 + MediaQuery.of(context).viewPadding.bottom),
          children: widget.entries.map((e) => e.toWidget()).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: loading ? Colors.grey : Colors.green[800],
        icon: Icon(
          Icons.save,
          color: Colors.white,
          size: 25,
        ),
        label: Text("Guardar"),
        onPressed: save,
      ),
    );
  }
}

//----------------------------- Checkbox ---------------------------------------
class Check extends StatefulWidget {
  bool seleccionado;
  bool whiteMode;
  String condicion;
  Function onChanged;
  Check({this.condicion, this.seleccionado, this.onChanged, this.whiteMode = false});
  @override
  _CheckState createState() => _CheckState();
}

class _CheckState extends State<Check> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        checkColor: Colors.green[800],
        activeColor: Colors.white,
        title: Text(
          widget.condicion,
          textAlign: TextAlign.center,
          style: TextStyle(color: widget.whiteMode ? Colors.white : Colors.black, fontSize: 23),
        ),
        value: widget.seleccionado,
        onChanged: (bool nuevo) {
          setState(() {
            widget.seleccionado = nuevo;
          });
          if (widget.onChanged != null) widget.onChanged(nuevo);
        });
  }
}

import 'package:codornices/models/codornis_model.dart';
import 'package:flutter/material.dart';

class TableExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TableExampleState();
  }
}

class TableExampleState extends State<TableExample> {
  List<Codornis> _items = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _items = _generateItems();
    });
  }

  List<Codornis> _generateItems() {
    return List.generate(10, (int index) {
      return Codornis(
        id: index,
        alimento: 'Carne con patatas',
        avesMuertas: index,
        canitdadAlimento: index * 100.0,
        huevos: index * 2,
        numeroAves: 30,
        semana: DateTime.now().toLocal().toString().split('-').first,
      );
    });
  }

  TableRow _buildTableRow(Codornis codornis) {
    return TableRow(
        key: ValueKey(codornis.id),
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
        ),
        children: [
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.bottom,
            child: SizedBox(
              height: 50,
              child: Center(
                child: Text(codornis.id.toString().split(' ').first),
              ),
            ),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Text(codornis.semana ?? ''),
            ),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Text(codornis.numeroAves.toString()),
            ),
          ),
          TableCell(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Text(codornis.alimento ?? ''),
            ),
          ),
          TableCell(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Text(codornis.canitdadAlimento.toString()),
            ),
          ),
          TableCell(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Text(codornis.huevos.toString()),
            ),
          ),
          TableCell(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Text(codornis.avesMuertas.toString()),
            ),
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      // border: TableBorder(
      //     bottom: BorderSide(color: Colors.red, width: 2),
      //     horizontalInside: BorderSide(color: Colors.red, width: 2),
      // ),
      // border: TableBorder.all(color: Colors.red, width: 2),
      border: TableBorder.symmetric(
        inside: BorderSide(color: Colors.white, width: 2),
        outside: BorderSide(color: Colors.black, width: 5),
      ),
      defaultVerticalAlignment: TableCellVerticalAlignment.baseline,
      defaultColumnWidth: IntrinsicColumnWidth(),
      columnWidths: const <int, TableColumnWidth>{
        0: const FixedColumnWidth(20),
        1: const FlexColumnWidth(1),
        2: const MaxColumnWidth(FlexColumnWidth(2), FractionColumnWidth(0.1)),
        3: const FixedColumnWidth(150),
        4: const FixedColumnWidth(20),
        5: const FixedColumnWidth(20),
        6: const FixedColumnWidth(20),
        7: const FixedColumnWidth(20),
        8: const FixedColumnWidth(20),
      },
      // textDirection: TextDirection.rtl,
      textBaseline: TextBaseline
          .alphabetic, // Pass this argument when using [TableCellVerticalAlignment.fill]
      children: _items.map((item) => _buildTableRow(item)).toList(),
    );
  }
}

# codornices

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

metodo apra eliminar 

 onPressed: () async {
                      var codornisTemporal = listaCodornices![index].id!;
                      var response = await DBAVIPRO
                          .eliminarcodornis(listaCodornices![index].id!);
                      if (response == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Fallo al eliminar el elemento')));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Eliminado correctamente')));
                        listaCodornices!.remove(codornisTemporal);
                      }
                      print('eliminando ${listaCodornices![index]}');
                      setState(() {});
                    },
part of 'widgets.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if (state.seleccionManual) {
          return Container();
        } else {
          //return buildSearchBar(context);
          return FadeInDown(
              duration: Duration(milliseconds: 300),
              child: buildSearchBar(context));
        }
      },
    );
  }

  Widget buildSearchBar(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: width,
        child: GestureDetector(
          onTap: () async {
            print('BUSCANDO........................');
            final resultado = await showSearch(
                context: context, delegate: SearchDestination());
            this.retornoBusqueda(context, resultado);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            width: double.infinity,
            child: Text('¿Dónde quieres ir?',
                style: TextStyle(color: Colors.black87)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black12, blurRadius: 5, offset: Offset(0, 5))
              ],
            ),
          ),
        ),
      ),
    );
  }

  //metodos
  void retornoBusqueda(BuildContext context, SearchResult resultado) {
    print('cancelo ${resultado.cancelo}');
    print('manual ${resultado.manual}');

    if (resultado.cancelo) return;

    if (resultado.manual) {
      context.bloc<BusquedaBloc>().add(OnActivarMarcadorManual());
      return;
    }
  }
}

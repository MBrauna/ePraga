import 'package:epraga/allFiles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SubsidiaryPage extends StatefulWidget {
  Schudule schudule;

  SubsidiaryPage(this.schudule);

  @override
  _SubsidiaryPage createState() => _SubsidiaryPage();
} // class SubsidiaryPage extends StatefulWidget { ... }

class _SubsidiaryPage extends State<SubsidiaryPage> {
  @override
  Widget build(BuildContext context) {
    Size    size                    = MediaQuery.of(context).size;
    double  fonteTitulo             = ((MediaQuery.of(context).orientation == Orientation.landscape)? (size.width / 16) : (size.width / 8));
    double  subfonteTitulo          = ((MediaQuery.of(context).orientation == Orientation.landscape)? (size.width / 50) : (size.width / 25));
    List<Subsidiary> listSubsidiary = context.select((App app) => app.listSubsidiary);
    Subsidiary subsidiary           = listSubsidiary.singleWhere((element) => element.id == widget.schudule.idSubsidiary);

    return Container(
      padding: EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        top: 15.0,
        bottom: 15.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Text('ePraga',
            style: TextStyle(
              fontFamily: 'SystemAnalysis',
              color: Theme.of(context).primaryColor,
              fontSize: fonteTitulo,
              fontWeight: FontWeight.bold,
            ),
          ),


          Text(
            'Tec Solution',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontFamily: 'Roboto',
              fontSize: subfonteTitulo,
              fontWeight: FontWeight.bold,
            ),
          ),


          Padding(
            padding: EdgeInsets.only(
              top: 40.0,
            ),
          ),


          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '#' + subsidiary.id.toString() + ' - ' + subsidiary.name,
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontFamily: 'Roboto',
                  fontSize: subfonteTitulo,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                subsidiary.description,
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontFamily: 'Roboto',
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),


              Padding(
                padding: EdgeInsets.only(
                  top: 40.0,
                ),
              ),


              Text(
                'Endereço: ' + subsidiary.address,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontFamily: 'Roboto',
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),


              Text(
                subsidiary.latitude == null ? 'Sem coordenadas cadastradas' : 'Coods: ' + subsidiary.latitude.toString() + 'W, ' + subsidiary.longitude.toString() + 'L',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontFamily: 'Roboto',
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),


            ],
          ),

        ],
      )
    );
  } // Widget build(BuildContext context) { ... }
} // class _SubsidiaryPage extends State<SubsidiaryPage> { ... }
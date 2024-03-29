import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:app_memo_xp/provider/g_singin.dart';


class SingUp extends StatelessWidget {
  const SingUp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
     children: [
       Spacer(),
       Text("AppMemo",
                       style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w400,
                  color: Colors.white
                ),
       ),
       SizedBox(height: 50,),
       Center(
         child: Container(
           
           // ignore: deprecated_member_use
           child: OutlineButton.icon(
             color: Colors.white,
             highlightColor: Colors.blueGrey.shade900 ,
                label: Text(
              'Accedi Con Google',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.white),
            ),
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            highlightedBorderColor: Colors.black,
            borderSide: BorderSide(color: Colors.white),
            textColor: Colors.black,
            icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
            onPressed: () {
              final provider= Provider.of<GoogleSingInProvider>(context, listen: false);
            provider.login();
            },
           ),
         ),
       ),
         Spacer(),
     ], 
    );
  }
}
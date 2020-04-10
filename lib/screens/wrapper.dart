import 'package:sliclone/screens/screens.dart';
import 'package:sliclone/model/model.dart';
import 'package:sliclone/screens/summary/summary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);
    
    // return either the Home or Authenticate widget
    if (user == null){
      return Authenticate();
    } else {
      return Summary();
    }
    
  }
}

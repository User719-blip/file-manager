import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
const LoadingIndicator({ super.key });

  @override
  Widget build(BuildContext context){
    return Container(
      color: Colors.grey[300],
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
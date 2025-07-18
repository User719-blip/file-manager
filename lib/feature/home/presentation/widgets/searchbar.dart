import 'package:flutter/material.dart';

class Searchbar extends StatelessWidget {
const Searchbar({ super.key });

  @override
  Widget build(BuildContext context){
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          decoration: InputDecoration(
            hintText: 'Search Files',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2.0,
              ),
            ),
            prefixIcon: Icon(Icons.search),
          ),
        ),
      );
  }
}
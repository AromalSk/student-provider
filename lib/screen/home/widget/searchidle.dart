import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:students_add/db/functions/db_functions.dart';
import 'package:students_add/db/models/data_model.dart';
import 'package:students_add/db/provider.dart';
import 'package:students_add/screen/details_screen.dart';
import 'package:students_add/screen/edit_screen.dart';



class SearchIdle extends StatelessWidget {
  const SearchIdle({super.key});

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<userProvider>(context,listen: false);
    return Consumer<userProvider>(
      builder: (context, value, child) {
        return ListView.separated(
        itemBuilder: (ctx, index) {
          final data = value.filter[index];
          File? image;
          if (data.image != 'no-img') {
            image = File(data.image);
          }
          return ListTile(
            onTap: () =>
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
              return DetailsScreen(
                name: data.name,
                age: data.age,
               subject: data.subject,
               phone: data.phone,
               images: data.image,
              );
            })),
            leading: CircleAvatar(
              radius: 30,
              child:SizedBox.fromSize(
                size:  Size.fromRadius(30),
                child: ClipOval(
                  child: (image != null)
              ? Image.file(File(data.image),
              fit: BoxFit.cover,
              width: 50,
              height: 50,
              )
              : Image.asset('assets/images/personkoi.jpg',fit: BoxFit.cover,),
            ),
                ),
              ),
              
            title: Text(data.name),
            trailing: SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                      return EditScreen(name: data.name,age: data.age,subject: data.subject, number: data.phone,id: data.key);
                    }));
                  }, icon: Icon(Icons.edit)),
                  IconButton(
                    onPressed: () {
                      if (data.key != null) {
                        try {
                         studentProvider.deleteFromProvider(data.key!);
                        } catch (e) {
                          print('Failed to delete student: $e');
                        }
                      } else {
                        print("data id is null");
                      }
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (ctx, index) => const Divider(),
        itemCount:value.filter.length,
      );
      },
      
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:students_add/db/functions/db_functions.dart';
import 'package:students_add/db/models/data_model.dart';
import 'package:students_add/db/provider.dart';
import 'package:students_add/provider/imageprovider.dart';


class AddStudentWidget extends StatelessWidget {
  AddStudentWidget({Key? key}) : super(key: key);

  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _subjectController = TextEditingController();

  final _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
   final imagesProviders = Provider.of<ImagesProviders>(context,listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            GestureDetector(
              onTap: ()async {
              await showImage(context);
              },
              child: Consumer<ImagesProviders>(
                builder: (context, value, child) {
                  return CircleAvatar(
                  radius: 50,
                  child: SizedBox.fromSize(
                    size: Size.fromRadius(50),
                    child: ClipOval(
                        child:value.selectedImage != null
                            ? Image.file(
                                value.selectedImage!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/personkoi.jpg',
                                fit: BoxFit.cover,
                              )),
                  ),
                );
                },
               
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This needs to be filled';
                }

                return null;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _ageController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Age'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This needs to be filled';
                }

                return null;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _subjectController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Subject'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This needs to be filled';
                }

                return null;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              
              controller: _phoneController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Phone number'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This needs to be filled';
                }else if(value.length<10 || value.length > 10 ){
                  return 'Invalid number';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    onAddStudentButtonClicked(context);
                    Navigator.of(context).pop();
    
                  }
                },
                child: const Text('Click to save'))
          ],
        ),
      ),
    );
  }

  Future<void> onAddStudentButtonClicked(BuildContext context) async {
     final StudentProvider = Provider.of<userProvider>(context,listen: false);
     final imageProvider = Provider.of<ImagesProviders>(context,listen: false);
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _subject = _subjectController.text.trim();
    final _phone = _phoneController.text.trim();
    if (_name.isEmpty || _age.isEmpty || _subject.isEmpty || _phone.isEmpty) {
      return;
    } else {
      var _student = StudentModel(
          name: _name,
          age: _age,
          subject: _subject,
          phone: _phone,
          image: imageProvider.selectedImage?.path ?? 'no-img');
      StudentProvider.addStudentsFromProvider(_student);
    }
  }

    Future<void> showImage(BuildContext context) async {
       final imagePicker = ImagePicker();
    final imagess =  await imagePicker.pickImage(source: ImageSource.gallery);
    if (imagess ==null) {
      return;
    }
  final imageProvider = Provider.of<ImagesProviders>(context,listen: false);
    imageProvider.setSelectedImage(File(imagess.path));
  }
}

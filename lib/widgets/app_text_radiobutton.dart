import 'package:flutter/material.dart';
import 'package:matrimonial_ai/widgets/app_text_form_field.dart';

import '../data/colors.dart';

class AppRadioButtonsFormField extends StatefulWidget {
  const AppRadioButtonsFormField({
    Key? key,
    required this.text
  }) : super(key: key);

  final String? text;
  @override
  State<AppRadioButtonsFormField> createState()=> _RadioButtons();
}

class _RadioButtons extends State<AppRadioButtonsFormField>
{
  String? gender;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Theme(
          data: Theme.of(context).copyWith(
              unselectedWidgetColor: AppColors.primary,
              disabledColor: Colors.blue
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
             Text(widget.text!,style: const TextStyle(color: Colors.black,fontFamily: 'outfit' ,fontSize: 20,fontWeight: FontWeight.w600),),
            Container(
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(border: Border.all(width: 1.5,color: Colors.black12),borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: RadioListTile(
                title: Text("Male"),
                value: "male",
                  activeColor: AppColors.primary,
                groupValue: gender,
                onChanged: (value){
                  setState(() {
                    gender = value.toString();
                  });
                },
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(border: Border.all(width: 1.5,color: Colors.black12),borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: RadioListTile(
                title: Text("Female"),
                value: "female",
                groupValue: gender,
                onChanged: (value){
                  setState(() {
                    gender = value.toString();
                  });
                },
              ),
            ),

            Container(
              decoration: BoxDecoration(border: Border.all(width: 1.5,color: Colors.black12),borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: RadioListTile(
                title: Text("Non-binary"),
                value: "other",
                groupValue: gender,
                onChanged: (value){
                  setState(() {
                    gender = value.toString();

                    showModalBottomSheet(
                      isScrollControlled: true,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                        context: context, builder: (BuildContext context){
                      return SingleChildScrollView(
                        child: Padding(
                          padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              const Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text('Tell us more about your gender',style: TextStyle(color: Colors.black,fontFamily: 'outfit' ,fontSize: 20,fontWeight: FontWeight.w600),),
                              ),
                              RadioListTile(
                                dense: true,

                                title: const Text("Intersex man",style: TextStyle(fontFamily: 'inter'),),
                                toggleable: true,
                                value: "male",
                                controlAffinity: ListTileControlAffinity.trailing,
                                activeColor: AppColors.primary,
                                groupValue: gender,
                                onChanged: (value){
                                  setState(() {
                                    gender = value.toString();
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text("Trans man",style: TextStyle(fontFamily: 'inter'),),
                                toggleable: true,
                                value: "male",
                                controlAffinity: ListTileControlAffinity.trailing,
                                activeColor: AppColors.primary,
                                groupValue: gender,
                                onChanged: (value){
                                  setState(() {
                                    gender = value.toString();
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text("Transmasculine",style: TextStyle(fontFamily: 'inter'),),
                                toggleable: true,
                                value: "male",
                                controlAffinity: ListTileControlAffinity.trailing,
                                activeColor: AppColors.primary,
                                groupValue: gender,
                                onChanged: (value){
                                  setState(() {
                                    gender = value.toString();
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text("Man and Nonbinary",style: TextStyle(fontFamily: 'inter'),),
                                toggleable: true,
                                value: "male",
                                controlAffinity: ListTileControlAffinity.trailing,
                                activeColor: AppColors.primary,
                                groupValue: gender,
                                onChanged: (value){
                                  setState(() {
                                    gender = value.toString();
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text("Cis Man",style: TextStyle(fontFamily: 'inter'),),
                                toggleable: true,
                                value: "male",
                                controlAffinity: ListTileControlAffinity.trailing,
                                activeColor: AppColors.primary,
                                groupValue: gender,
                                onChanged: (value){
                                  setState(() {
                                    gender = value.toString();
                                  });
                                },
                              ),
                              const Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text('Want to describe more?',style: TextStyle(color: Colors.black,fontFamily: 'inter' ),),
                              ),

                             const Padding(
                               padding: EdgeInsets.symmetric(horizontal: 10),
                               child: AppTextFormField(labelText: 'Write here...',),
                             )

                            ],
                          ),
                        ),
                      );
                    });
                  });
                },
              ),
            )
          ],),
        ),
      ),
    );
  }

}

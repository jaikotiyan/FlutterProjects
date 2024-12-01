import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:io/common/theme/app_colors.dart';
import 'package:io/common/utils/colors.dart';
import 'package:io/common/widgets/button_widget.dart';

class DatePicker extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  const DatePicker({super.key, required this.onDateSelected});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {

  DateTime selectedDate = DateTime.now();
  int maximumYear = DateTime.now().year+2;

  @override
  void initState() {
    selectedDate = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MyColors myColors = Theme.of(context).extension<MyColors>()!;
    return Container(
          height: 370,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(20)),
          child:  Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(children: [
              Container(
              width: 45,
                height: 5,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                  color: myColors.lightBlue
                ),
            ),
              Row(
                children: [
                  Title(color: Colors.black, child: Text('Select Date', 
                  style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(
                    fontSize: 20,
                    fontWeight:
                    FontWeight.w700))),
                  Spacer(),
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: Text('Cancel',
                  style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(
                  color: AppColors.ff199FED,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  decorationColor: AppColors.ff199FED,)),)
                ],
              ),   
              Expanded(
                child: CupertinoDatePicker(
                  itemExtent: 60,
                  //initialDateTime: selectedDate,
                  // minimumYear: selectedDate.year,
                  maximumYear: maximumYear,
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (DateTime newDateTime){
                    setState(() {
                      selectedDate= newDateTime;
                    });
                  },
                  
                  ),
                  
              ),
              SizedBox(height: 15),
              ButtonWidget("Set Date", (){
                widget.onDateSelected(selectedDate);
                Navigator.pop(context);
                print(selectedDate);
              })
              
            ],),
          ),
          );
  }
}
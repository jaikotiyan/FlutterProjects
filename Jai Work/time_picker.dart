import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:io/common/theme/app_colors.dart';
import 'package:io/common/utils/colors.dart';
import 'package:io/common/widgets/button_widget.dart';

class TimePicker extends StatefulWidget {
  final Function(DateTime) onTimeSelected;
  const TimePicker({super.key, required this.onTimeSelected});

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {

  late DateTime selectedTime;


  @override
  void initState() {
    selectedTime = DateTime(DateTime.now().year-1,DateTime.now().month,DateTime.now().day, DateTime.now().hour, 00);
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
                    Title(color: Colors.black, child: Text('Select Time', 
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
                      decorationColor: AppColors.ff199FED,
                    )
                  ),)
                ],
              ),   
              Expanded(
                child: CupertinoDatePicker(
                  itemExtent: 60,
                  initialDateTime: DateTime(DateTime.now().year-1,DateTime.now().month,DateTime.now().day, DateTime.now().hour, 00),
                  mode: CupertinoDatePickerMode.time,
                  minuteInterval: 15,
                  onDateTimeChanged: (DateTime newDateTime){
                    selectedTime= newDateTime;
                  },
                ),  
              ),
              SizedBox(height: 15),
              ButtonWidget("Set Time", (){
                widget.onTimeSelected(selectedTime);
                Navigator.pop(context);
                print(selectedTime);
              })   
            ],
          ),
      ),
    );
  }
}
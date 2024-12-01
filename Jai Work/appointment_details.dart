import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:io/common/language/app_translation.dart';
import 'package:io/common/models/appointments/appointment_type.dart';
import 'package:io/common/models/appointments/date_picker.dart';
import 'package:io/common/models/appointments/time_picker.dart';
import 'package:io/common/theme/app_colors.dart';
import 'package:io/common/widgets/app_button_widget.dart';
import 'package:io/common/widgets/button_widget.dart';
import 'package:io/screens/appointment/appointment_scheduled.dart';


class AppointmentTime extends StatefulWidget {
  final String? selectedName;
  final String? selectedOption;
  const AppointmentTime({super.key, required this.selectedName, this.selectedOption});

  @override
  State<AppointmentTime> createState() => _AppointmentTimeState();
}

class _AppointmentTimeState extends State<AppointmentTime> {

  //TextEditingController nameCtrl = TextEditingController();

  String _selectedName= '';
  DateTime? selectedDate;
  DateTime? selectedTime;
  bool isUpdate = false;
  String? appointmentType;
  String appointmentName = '';


  void updateisUpdate(){
    setState(() {
      isUpdate = selectedDate != null && selectedTime!= null  && appointmentName!=null && appointmentType!=null;
    });
  }

  void showcustomDatePicker() async{
    final result = showModalBottomSheet(context: context, builder: (BuildContext context) {
      return DatePicker(
        onDateSelected: (date){
          setState(() {
            selectedDate = date;
            updateisUpdate();
            //isUpdate = true;
          });
          print(date);
        });
    });
  }

  String selectedDateFormat(DateTime date) {
  final formatter = DateFormat('y MMMM d');
  return formatter.format(date);
  }

  void showcustomTimePicker() async{
    final result = showModalBottomSheet(context: context, builder: (BuildContext context) {
      return TimePicker(
        onTimeSelected: (time){
          setState(() {
            selectedTime = time;
            updateisUpdate();
            //isUpdate = true;
          });
          print(time);
        });
    });
  }

  String selectedTimeFormat(DateTime time) {
  final formatter = DateFormat('hh:mm a'); // Example format: 11:21 AM
  return formatter.format(time);

  }


  void showAppointmentType() async{
    final result = showModalBottomSheet(context: context, builder: (BuildContext context) {
      return AppointmentType(
        onTypeSelected: (type){
          setState(() {
            appointmentType = type;
            updateisUpdate();
            //isUpdate = true;
          });
          print(type);
        });
    });
  }
  

  @override
  void initState() {
    super.initState();
    if (widget.selectedName != null) {
      _selectedName = widget.selectedName!;
    }
  }

  @override
  Widget build(BuildContext context) {
  late String formattedDate = DateTime.now().toString();
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    MyColors myColors = Theme.of(context).extension<MyColors>()!;
    // LoaderProvider loader = ref.watch(loaderProvider);
    // final signUp = ref.watch(signUpProvider);
    // final family = ref.watch(familyProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:EdgeInsets.only(left: 15, top: 8, bottom: 10, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.05,),
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.arrow_back_ios,
                    ),
                  ),
                  SizedBox(width: 2,),
                  Text( 'Set Reminder',
                    //AppTranslations.of(context)!.text("Set Reminder"),
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                    ),
                  )
               ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Container(
                    height: 5,
                    width: width*0.45,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5),
                      color: Theme.of(context).hoverColor
                    ),
                  ),
                  SizedBox(width: 5,),
                  isUpdate? Container(
                    width: width*0.45,
                    height: 5,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5),
                      color: Theme.of(context).hoverColor,
                    ),
                  ):Container(
                    height: 5,
                    width: width*0.45,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5),
                      color: myColors.lightGrey
                    ),
                  ),
                  Spacer()
                ],
              ),
              SizedBox(height: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Date',
                    //AppTranslations.of(context)!.text("date"),
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                      ),
                  ),
                  const SizedBox(height: 10),
                  Container(  
                    padding: EdgeInsets.only(left: 15),
                    height: 51,
                    decoration: BoxDecoration(
                      color: Theme.of(context).disabledColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SizedBox(width: 2),
                        Container(
                          width: 200,
                          child: Text(
                            selectedDate != null ? selectedDateFormat(selectedDate!) : 'Select',
                            style: Theme.of(context)
                            .textTheme
                            .labelMedium?.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                            )
                            ),
                        ),
                          SizedBox(width: width*0.16,),
                          InkWell(
                            onTap: () async {
                              debugPrint("----");
                              showcustomDatePicker();
                              
                            },
                            child: Container(
                              height: 52,
                              width: 52,
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/images/calendar-date.svg",
                                ),
                              )
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
              ),
              SizedBox(height: 20,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( 'Time',
                    //AppTranslations.of(context)!.text("Time"),
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                      ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    height: 51,
                    decoration: BoxDecoration(
                      color: Theme.of(context).disabledColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(width: 2),
                        Container(
                          width: 200,
                          child: Text(
                            selectedTime != null ? selectedTimeFormat(selectedTime!) : 'Select',
                            style: Theme.of(context)
                            .textTheme
                            .labelMedium?.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                            )
                            ),
                        ),
                          SizedBox(width: width*0.16,),
                          InkWell(
                            onTap: () async {
                              showcustomTimePicker();
                              
                            },
                            child: Container(
                              height: 52,
                              width: 52,
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/images/alarm_Icon.svg",
                                ),
                              )
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
              ),
              
              
              SizedBox(height: 20,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('What is the name of the appointment?',
                    //AppTranslations.of(context)!.text("What is the name of the appointment?"),
                    style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(
                      fontWeight: FontWeight.w600, fontSize: 16)
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.only(left: 19),
                    alignment: Alignment.centerLeft,
                    height: 51,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                      .disabledColor, // background color
                      borderRadius: BorderRadius.circular(10), // border radius
                    ),
                    // child: Text(_selectedName,
                    // style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    //   fontWeight: FontWeight.w600,
                    //   fontSize: 16,
                    // ),),
                    child : TextField(
                      controller: TextEditingController(text: appointmentName),
                      style: Theme.of(context).textTheme.labelSmall,
                      textAlignVertical: TextAlignVertical.center,
                      onChanged: (value) {
                        appointmentName = value;
                        //updateisUpdate();
                        print(appointmentName);
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter',
                        hintStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: myColors.searchGrey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        border: InputBorder.none,
                      ),
                    )
                    // child: TextField(
                    //   controller: TextEditingController(text: appointmentName),
                    //   style: Theme.of(context).textTheme.labelSmall,
                    //   textAlignVertical: TextAlignVertical.center,
                    //   onChanged: (value) {
                    //     setState(() {
                    //       appointmentName = value;
                          
                    //       updateisUpdate();
                    //     });
                    //     print(appointmentName);
                    //   },
                    //   decoration: InputDecoration(
                    //     // hintTextDirection: TextDirection.LTR,
                    //     //contentPadding: const EdgeInsets.only(left),
                    //     isDense: true,
                    //     hintStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                    //       color: myColors.searchGrey,
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.w500,
                    //     ),
                    //     hintText: 'Enter',
                    //     //labelText: _selectedName,
                    //     border: InputBorder.none,
                    //   )
                    // )
                  ),
                ],
              ),
              
              SizedBox(height: 20,),
              
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('What is the appointment type?',
                    //AppTranslations.of(context)!.text("What is the appointment type?"),
                    style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    height: 51,
                    decoration: BoxDecoration(
                      color: Theme.of(context).disabledColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const SizedBox(width: 2),
                          Container(
                            width: 200,
                            
                            child: Text(
                              appointmentType ?? 'Select',
                              style: Theme.of(context)
                              .textTheme
                              .labelMedium?.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w500
                              )
                              ),
                          ),
                            SizedBox(width: width*0.16,),
                            InkWell(
                              onTap: () async {
                                debugPrint("----");
                                setState(() {
                                  isUpdate= true;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).hoverColor,
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0),
                                  ),
                                ),
                                height: 52,
                                width: 52,
                                child: InkWell(
                                  child: Center(
                                    child: SvgPicture.asset(
                                      "assets/images/down.svg",
                                      colorFilter: ColorFilter.mode(
                                                myColors.black!,
                                                BlendMode.srcIn),
                                    ),
                                  ),
                                  onTap: () {
                                    showAppointmentType();
                                  },
                                )
                              ),
                            )
                          ],
                        ),
                  ),
                ] 
              ),
              
              SizedBox(height: width* 0.5,),
              isUpdate
                            ? ButtonWidget("next", () {
                                showModalBottomSheet(context: context, builder: (BuildContext context){
                                  return AppointmentScheduled(
                                    specialtext: _selectedName,
                                  );
                                });
                                    
                              })
                            : AppButtonWidget("next", () {},
                                Theme.of(context).disabledColor),
            ],
          ),
        ),
      ),
    );
  }
}



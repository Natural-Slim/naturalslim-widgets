import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:natural_slim_flutter_library/controllers/consulting/consulting_controller.dart';
import 'package:natural_slim_flutter_library/models/consulting/response/hours_location_available_model.dart';


class AppointmentProps{
  int indexDaySelected = 0;
  HoursLocationAvailableResponse selectedDate = HoursLocationAvailableResponse(date: DateTime.now(), hours: []);
  int indexHourSelected = 0;
}

class ScheduleAppointmentWidget extends StatelessWidget {
  ScheduleAppointmentWidget({
    required this.useApi,
    Key? key
  }) : props = AppointmentProps(), super(key: key);

  bool useApi;
  AppointmentProps props;

  /* ----------------------------------------------------------------- */

  ScrollController scrollController = ScrollController();
  
  late double minScroll = scrollController.position.minScrollExtent;
  late double maxScroll = scrollController.position.maxScrollExtent;
  double valueScroll = 0;
  double valueToGo = 220;

  static late List<HoursLocationAvailableResponse> dateData;

  @override
  Widget build(BuildContext context) {

    if(useApi){
      return FutureBuilder<List<HoursLocationAvailableResponse>>(
        future: ConsultingController().getHoursLocationAvailable(15, 1),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasError){
              return const CircularProgressIndicator();
            }

            return _buildWidget(snapshot.data!);
            
          } else {
            dateData.map((e) => print(e.date.toString()),);

            return const CircularProgressIndicator();
          }
        },
      );
    }
    
    dateData = _buildDates();
    if(props.selectedDate.hours.isEmpty) props.selectedDate = dateData[props.indexDaySelected];

    return _buildWidget(dateData);
  }

  /// Method to build the entire visual part of the widget
  StatefulBuilder _buildWidget(List<HoursLocationAvailableResponse> data) {
    return StatefulBuilder(
      builder: (context, setState) {
        
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Widget Top (Date Calendar)
            Expanded(
              flex: 0,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _calendarNavigationButton(
                    icon: const Icon(Icons.arrow_left),
                    functionTap: () => (){
                      if(valueScroll > minScroll){
                        valueScroll -= valueToGo;
          
                        scrollController.animateTo(
                          valueScroll,
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.fastOutSlowIn
                        );
                      }
                    }
                  ),
                  Expanded(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: double.infinity * 0.50,
                        minWidth: double.infinity * 0.50,
                        minHeight: 100,
                        maxHeight: 100
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        controller: scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: data.length,
                        itemBuilder: (context, index){
                          DateTime date = data[index].date;
                          String nameDay = DateFormat('EEE').format(date);
                          String numberDay = date.day.toString();
                          String nameMonth = DateFormat('MMM').format(date);
                                  
                          return  _cardDay(index, context, nameDay, numberDay, nameMonth, setState);
                        },
                      )
                    )
                  )
                  ,
                  _calendarNavigationButton(
                    icon: const Icon(Icons.arrow_right),
                    functionTap: () => (){
                      if(valueScroll < maxScroll){
                        valueScroll += valueToGo;
          
                        scrollController.animateTo(
                          valueScroll,
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.fastOutSlowIn
                        );
                      }
                    }
                  ),
                ],
              ),
            ),
        
            // Widget bottom (hours calendar)
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Wrap(
                  children: data[props.indexDaySelected].hours.asMap().entries.map((e){
                    String hour = e.value.substring(0, 2);
                    String minute = e.value.substring(3, 5);
          
                    String formattedTime = DateFormat('h:mm a').format(DateTime(2000, 01, 01, int.parse(hour), int.parse(minute)));
          
                    return _cardHour(e, context, setState, formattedTime); 
                  }).toList(),
                ),
              )
            )
          ],
        );
      }
    );
  }

  /// Method to return the calendar navigation button
  Widget _calendarNavigationButton({required Widget icon, required Function functionTap}) {
    return Container(
      height: 40,
      width: 40,
      margin: const EdgeInsets.all(4.0),
      child: Ink(
        decoration: ShapeDecoration(
          color: Colors.grey.withOpacity(0.2),
          shape: const CircleBorder(),
        ),
        child: Center(
          child: IconButton(
            icon: icon,
            splashRadius: 25,
            onPressed: functionTap(), 
          ),
        ),
      ),
    );
  }

  /// Method to return a card with a date
  InkWell _cardDay(int index, BuildContext context, String nameDay, String numberDay, String nameMonth, StateSetter setState) {
    return InkWell(
      child: Container(
        width:  60,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: props.indexDaySelected == index ? Theme.of(context).colorScheme.secondary : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0.3,
              blurRadius: 4,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(nameDay, style: TextStyle(fontSize: 14, color: props.indexDaySelected == index ? Colors.white : Colors.black), overflow: TextOverflow.ellipsis,),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(numberDay, style: TextStyle(fontSize: 16, color: props.indexDaySelected == index ? Colors.white : Colors.black),),
            ),
            Text(nameMonth, style: TextStyle(fontSize: 16, color: props.indexDaySelected == index ? Colors.white : Colors.black),),
          ],
        ),
      ),
      onTap: () => setState(() {
        props.indexDaySelected = index;
        props.selectedDate = dateData[index];
      }),
    );
  }

  /// Method to return a card with a time
  Widget _cardHour(MapEntry<int, String> e, BuildContext context, StateSetter setState, String formattedTime) {
    return Container(
      width: 150,
      height: 55,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: props.indexHourSelected == e.key ? Theme.of(context).colorScheme.secondary : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 0.3,
            blurRadius: 4,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: InkWell(
        onTap: () {
          setState((){
            props.indexHourSelected = e.key;
          });
        },
        child: Center(child: Text(formattedTime, style: TextStyle(fontSize: 20, color: props.indexHourSelected == e.key ? Colors.white : Colors.black),)),
      ),
    );
  }

  /// Method calculate upcoming days locally
  List<HoursLocationAvailableResponse> _buildDates(){
    List<HoursLocationAvailableResponse> dates = [];
    DateTime date = DateTime.now();

    for(var i = 0; i < 15; i++){
      if(i > 0) date = date.add(const Duration(days: 1));

      if(date.weekday != 7){
        dates.add(
          HoursLocationAvailableResponse(
            date: date,
            // date: DateTime.parse('2022-05-04 00:12:50.000Z'), 
            hours: [
              '08:00:00',
              '09:00:00',
              '10:00:00',
              '11:00:00'
            ]
          )
        );
      }
    }

    return dates;
  }
}
// ignore_for_file: avoid_unnecessary_containers, sort_child_properties_last, must_be_immutable, unused_field, unused_local_variable, empty_catches, non_constant_identifier_names, use_full_hex_values_for_flutter_colors

//import 'dart:async';

import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
class TodoTile extends StatefulWidget {
  TodoTile({
    super.key,
    required this.taskname,
    required this.taskcompleted,
    required this.onChanged,
    required this.deleteTask,
    required this.taskIndex,
  });

  String taskname;
  final bool taskcompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteTask;
  final int taskIndex;

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  //variables for timer
  bool isTimerRunning = false;
  Duration remainingTime = Duration.zero;
  Duration initialTime = Duration.zero;
  Timer? _timer;

  @override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
   // loadTaskTimerData(); // Ensure it runs after UI builds
  });
}


//   //load the timer data fronm the database
//   void loadTaskTimerData() {

//   if (taskData.isEmpty || taskData.length < 5) {
//     // Handle missing data gracefully
//     setState(() {
//       remainingTime = Duration.zero;
//       initialTime = Duration.zero;
//       isTimerRunning = false;
//     });
//     return;
//   }

//   setState(() {
//     remainingTime = Duration(seconds: taskData[2] ?? 0);
//     initialTime = Duration(seconds: taskData[3] ?? 0);
//     isTimerRunning = (taskData[4] ?? 0) == 1;
//   });
// }

  

  void toggleTimer(){
    if(isTimerRunning){
      pauseTimer();
    }
    else{
      startTimer();
    }
  }

  void pauseTimer(){
     setState(() {
       isTimerRunning=false;
     });
     _timer?.cancel();
     
  }

  void startTimer(){
      setState(() {
        isTimerRunning=true;
      });
      _timer=Timer.periodic(Duration(seconds: 1), (timer) {
        if(remainingTime>Duration.zero){
          setState(() {
           remainingTime -= Duration(seconds: 1);
          });
         
        }
        else{
           timer.cancel();
           setState(() {
             isTimerRunning=false;
           });
           MarktaskAsCompleted();
           
        }
      },);
  }
  //this function is saying that if the timer is over then your task will be checked automatically

  MarktaskAsCompleted(){
    if(!widget.taskcompleted){
      setState(() {
        widget.onChanged?.call(true);
      });
      
    }
  }
  void resetTimer(){
      setState(() {
        remainingTime=initialTime;
        isTimerRunning=false;
      });
      
    _timer?.cancel();
   
  }

  void setTimerFromInput() {
    final input = timerController.text;
    final parts = input.split(":");
    if (parts.length == 3) {
      try {
        final hours = int.parse(parts[0]);
        final minutes = int.parse(parts[1]);
        final seconds = int.parse(parts[2]);
        setState(() {
          initialTime =
              Duration(hours: hours, minutes: minutes, seconds: seconds);
          remainingTime = initialTime;
        });
       
        timerController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Invalid time format. Use HH:MM:SS.' )));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid time format. Use HH:MM:SS.')),
      );
    }
  }

  final TextEditingController timerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: widget.deleteTask,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              Row( 
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Checkbox(
                            value: widget.taskcompleted,
                            onChanged: widget.onChanged),
                        Text(
                          widget.taskname,
                          style: TextStyle(
                            decoration: widget.taskcompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          
                          ),
                        ),
                      ],
                    ),
                  ),
                  // MyTimer(),
                  SizedBox(
                    width: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        "${remainingTime.inHours}:${remainingTime.inMinutes.remainder(60).toString().padLeft(2, '0')}:${remainingTime.inSeconds.remainder(60).toString().padLeft(2, '0')}",
                        //the duration constructor automatically increments the overflow part 
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: toggleTimer,
                        icon: Icon(isTimerRunning? Icons.pause : Icons.play_arrow),
                      ),
                      IconButton(
                        onPressed: resetTimer,
                        icon: Icon(Icons.replay),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: timerController,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                          hintText: "set timer (HH:MM:SS)",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  ElevatedButton(
                    onPressed: setTimerFromInput,
                    child: Text("Set Timer"),
                  )
                ],
              )
            ],
          ),
          decoration: BoxDecoration(
            color: Color(0xFFD3D3D3),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:windows_calender_app/view/todo_list/todo_list_view_model.dart';

class TodoItem extends StatefulWidget {
  const TodoItem({super.key, required this.itemIndex});

  final int itemIndex;
  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  List<double> titleWidth = [0.1, 0.2, 0.1, 0.1, 0.1, 0.1];
  final TodoListViewModel vm = TodoListViewModel();

  Future<String> _showDatePicker(BuildContext context) async {
    String formatDate;
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020, 1, 1),
      lastDate: DateTime(2040, 12, 31),
    );
    if (pickedDate != null) {
      print('Selected date: $pickedDate');
      formatDate = DateFormat('yyyy-M-d').format(pickedDate).toString();
      return formatDate;
    }
    return vm.todoList[widget.itemIndex].lateDate;
  }

  Function()? listener;
  @override
  void initState() {
    listener = () {
      if (mounted) {
        setState(() {});
      }
    };
    vm.addListener(listener!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("build 호출");
    double width = MediaQuery.of(context).size.width;
    double height = 50;
    BoxDecoration decoration = BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(12),
    );
    TextStyle itemStyle = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: width * titleWidth[0],
            height: height,
            decoration: decoration,
            child: Center(
              child: Text(
                vm.todoList[widget.itemIndex].name,
                style: itemStyle,
              ),
            ),
          ),
          Container(
            width: width * titleWidth[1],
            height: height,
            decoration: decoration,
            child: Center(
              child: Text(
                vm.todoList[widget.itemIndex].content,
                style: itemStyle,
              ),
            ),
          ),
          Container(
            width: width * titleWidth[2],
            height: height,
            decoration: decoration,
            child: Center(
              child: Text(
                vm.todoList[widget.itemIndex].workTime,
                style: itemStyle,
              ),
            ),
          ),
          Container(
            width: width * titleWidth[3],
            height: height,
            decoration: decoration,
            child: Center(
              child: Text(
                vm.todoList[widget.itemIndex].name,
                style: itemStyle,
              ),
            ),
          ),
          Container(
            width: width * titleWidth[4],
            height: height,
            decoration: decoration,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(value: true, onChanged: (newValue) {}),
                  Text(
                    vm.todoList[widget.itemIndex].completeDate,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _showDatePicker(context).then((value) {
                vm.selectLateDate(widget.itemIndex, value);
              });
            },
            child: Container(
              width: width * titleWidth[5],
              height: height,
              decoration: decoration,
              child: Center(
                child: Text(
                  vm.todoList[widget.itemIndex].lateDate,
                  style: itemStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

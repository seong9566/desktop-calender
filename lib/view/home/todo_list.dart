import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> with TickerProviderStateMixin {
  late final AnimationController _lottieController;
  late DateTime now;
  late String formattedDate;
  late String formattedDate2;
  List<double> titleWidth = [];
  List<Widget> todoList = [];
  late String pickedDate;

  @override
  void initState() {
    _lottieController = AnimationController(vsync: this);
    now = DateTime.now();
    formattedDate = DateFormat('M월 d일').format(now);
    formattedDate2 = DateFormat('yyyy-M-d').format(now).toString();

    titleWidth = [0.1, 0.2, 0.1, 0.1, 0.1, 0.1];

    ///initState에서 동기화 된 이후에 context를 사용하기 위해서 delayed를 사용.
    Future.delayed(Duration.zero, () {
      todoList = [
        todoItem(),
        todoItem(),
        todoItem(),
        todoItem(),
      ];
    });
    pickedDate = formattedDate2;
    super.initState();
  }

  @override
  void dispose() {
    //컨트롤러 해제
    _lottieController.dispose();
    super.dispose();
  }

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
    return DateFormat('yyyy-M-d').format(now).toString();
  }

  @override
  Widget build(BuildContext context) {
    print("빌드 : ${pickedDate}");
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Text("$pickedDate"),
            Row(
              children: [
                Lottie.asset(
                  'assets/lottie/todo.json',
                  controller: _lottieController,
                  onLoaded: (composition) {
                    _lottieController.duration = composition.duration;
                    _lottieController.forward();
                  },
                ),
                const SizedBox(width: 30),
                const Text(
                  "할 일 작성",
                  style: const TextStyle(
                    fontSize: 34,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SizedBox(
                  height: mediaQueryHeight * 0.7,
                  child: Column(
                    children: [
                      titleWidget(mediaQueryWidth, titleWidth),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: todoList.length,
                        itemBuilder: (context, index) {
                          return todoList[index];
                        },
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget todoItem() {
    print("빌드123 : ${pickedDate}");
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
                "배 정비",
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
                "프로펠러 정비",
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
                "3시간",
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
                "김재성",
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
                    "2024.03.26",
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
                setState(() {
                  print("value: $value");
                  pickedDate = value;
                });
              });
            },
            child: Container(
              width: width * titleWidth[5],
              height: height,
              decoration: decoration,
              child: Center(
                child: Text(
                  "$pickedDate",
                  style: itemStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget titleWidget(double mediaQuery, List<double> width) {
    TextStyle titleStyle = const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    );
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: mediaQuery * width[0],
          ),
          // Container(
          //     decoration: BoxDecoration(
          //       border: Border.all(color: Colors.grey),
          //       borderRadius: BorderRadius.circular(30),
          //     ),
          //     width: mediaQuery * width[0],
          //     child: IconButton(
          //       onPressed: () {
          //         setState(() {
          //           todoList.add(todoItem());
          //         });
          //       },
          //       icon: const Icon(Icons.add),
          //     )),
          SizedBox(
            width: mediaQuery * width[1],
            child: Text(
              "$formattedDate 할 일",
              style: titleStyle,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: mediaQuery * width[2],
            child: Text(
              "시간",
              style: titleStyle,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: mediaQuery * width[3],
            child: Text(
              "이름",
              style: titleStyle,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: mediaQuery * width[4],
            child: Text(
              "완료",
              style: titleStyle,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: mediaQuery * width[5],
            child: Text(
              "지연",
              style: titleStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

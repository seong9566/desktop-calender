import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:windows_calender_app/view/todo_list/todo_list_view_model.dart';
import 'package:windows_calender_app/view/todo_list/widgets/todo_item.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> with TickerProviderStateMixin {
  final TodoListViewModel vm = TodoListViewModel();
  late final AnimationController _lottieController;
  late DateTime now;
  late String formattedDate;
  late String formattedDate2;
  List<double> titleWidth = [];
  late String pickedDate;

  @override
  void initState() {
    _lottieController = AnimationController(vsync: this);
    now = DateTime.now();
    formattedDate = DateFormat('M월 d일').format(now);
    formattedDate2 = DateFormat('yyyy-M-d').format(now).toString();

    titleWidth = [0.1, 0.2, 0.1, 0.1, 0.1, 0.1];

    ///initState에서 동기화 된 이후에 context를 사용하기 위해서 delayed를 사용.
    Future.delayed(Duration.zero, () {});
    pickedDate = formattedDate2;
    super.initState();
  }

  @override
  void dispose() {
    //컨트롤러 해제
    _lottieController.dispose();
    super.dispose();
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
                        itemCount: vm.todoList.length,
                        itemBuilder: (context, index) {
                          return TodoItem(itemIndex: index);
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

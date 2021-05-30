import 'package:todo_app/src/model/todo_entity.dart';

class WebClientMockData {
  final Duration delay;

  const WebClientMockData([this.delay = const Duration(milliseconds: 3000)]);

  Future<String> mockStringData() async {
    return Future.delayed(delay, () => "Hello World!!!!!");
  }

  Future<List<TodoEntity>> loadTodo() async {
    return Future.delayed(
        delay,
        () => [
              TodoEntity(
                'Buy veg from near store',
                '1',
                'tomato and potato must buy!',
                false,
              ),
              TodoEntity(
                'Order 20l water bottle',
                '2',
                'Bislery',
                false,
              ),
              TodoEntity(
                'Book a train ticket for Holi ',
                '3',
                ' check for returning also',
                true,
              ),
              TodoEntity(
                'pay Society charge',
                '4',
                '',
                false,
              ),
              TodoEntity(
                'ask for electricity bill',
                '5',
                'at Main gate',
                true,
              ),
            ]);
  }

  Future<bool> saveTodos(List<TodoEntity> todos) async {
    return Future.value(true);
  }
}

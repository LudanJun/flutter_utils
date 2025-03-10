import 'package:flutter/material.dart';
import 'package:flutter_utils/cus_wave(%E8%87%AA%E5%AE%9A%E4%B9%89%E6%B3%A2%E6%B5%AA)/animated_couter.dart';

//动画详解
class AnimationYinshiPage003 extends StatefulWidget {
  const AnimationYinshiPage003({super.key});

  @override
  State<AnimationYinshiPage003> createState() => _AnimationYinshiPage003State();
}

class _AnimationYinshiPage003State extends State<AnimationYinshiPage003> {
  double _height = 300;
  Color _color = Colors.blue;

  int _counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  
        title: Text("隐式动画"),
      ),
      body: Center(
        child:
            //1.动画盒子
            // AnimationContainer001(
            //   height: _height,
            //   color: _color,
            // ),
            // AnimatedSwitcherPage(),
            AnimatedOpacityPage001(
          counter: _counter,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            // _height += 100;
            // if (_height > 400) _height = 200;
            _counter++;
          });
        },
      ),
    );
  }
}

//动画盒子
class AnimationContainer001 extends StatefulWidget {
  final double height; //传入高度
  final Color color; //传入颜色
  const AnimationContainer001(
      {super.key, required this.height, required this.color});

  @override
  State<AnimationContainer001> createState() => _AnimationContainer001State();
}

class _AnimationContainer001State extends State<AnimationContainer001> {
  @override
  Widget build(BuildContext context) {
    //
    return AnimatedContainer(
      //动画持续时间 1000毫秒
      duration: Duration(milliseconds: 1000),
      width: 300,
      height: widget.height,
      // color: widget.color, // Colors.blue[600],
      decoration: BoxDecoration(
        //渐变颜色
        gradient:const LinearGradient(
          begin: Alignment.bottomCenter, //渐变色起始位置
          end: Alignment.topCenter, //渐变色结束位置
          colors: [Colors.blue, Colors.white],
          stops: [0.3, 0.6], //从0.3-0.6开始渐变 相当于加了个分界线
        ),
        boxShadow:const [
          BoxShadow(
            spreadRadius: 25, //外边框粗细
            blurRadius: 25, //模糊效果
          ),
        ],
        borderRadius: BorderRadius.circular(25), //设置圆角
      ),
      child:const Center(
        child: Text(
          "Hi",
          style: TextStyle(fontSize: 72),
        ),
      ),
    );
  }
}

//AnimatedSwitcher动画切换 不同控件切换
class AnimatedSwitcherPage extends StatefulWidget {
  const AnimatedSwitcherPage({super.key});

  @override
  State<AnimatedSwitcherPage> createState() => _AnimatedSwitcherPageState();
}

class _AnimatedSwitcherPageState extends State<AnimatedSwitcherPage> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      width: 300,
      height: 300,
      color: Colors.orange,
      child: AnimatedSwitcher(
          transitionBuilder: (child, animation) {
            return FadeTransition(
              //渐变
              opacity: animation,
              child: ScaleTransition(
                //缩放
                scale: animation,
                child: child,
              ),
            );
          },
          duration: Duration(seconds: 2),
          child: Text(
            "Good",
            style: TextStyle(
              fontSize: 100,
            ),
            key: UniqueKey(),
          )
          //Image.network(
          // "http://gips2.baidu.com/it/u=195724436,3554684702&fm=3028&app=3028&f=JPEG&fmt=auto?w=1280&h=960"),
          ),
    );
  }
}

//AnimatedSwitcher动画切换 不同控件切换
class AnimatedOpacityPage001 extends StatefulWidget {
  final int counter;
  const AnimatedOpacityPage001({super.key, required this.counter});

  @override
  State<AnimatedOpacityPage001> createState() => _AnimatedOpacityPage001State();
}

class _AnimatedOpacityPage001State extends State<AnimatedOpacityPage001>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //透明度变化
        AnimatedOpacity(
          duration: Duration(seconds: 1),
          curve: Curves.linear, //线性变化
          opacity: 1.0,
          child: Container(
            width: 10,
            height: 10,
            color: Colors.orange,
          ),
        ),

        //修改padding值进行移动
        AnimatedPadding(
          padding: EdgeInsets.only(top: 0.0),
          duration: Duration(seconds: 1),
          //移动方式
          curve: Curves.easeInOutBack,
          child: Container(
            width: 30,
            height: 30,
            color: Colors.orange,
          ),
        ),

        //TweenAnimationBuilder 可以直接传入 tween
        //但是里面如果有多个控件改变 比如透明度 和高度的改变 就需要自定义了
        //透明度变化是0-1
        //高度变化是0->无穷
        TweenAnimationBuilder(
          //介于0~1之间的 补间动画 在指定的区间发生的变化
          //begin一开始有用,如果没设置begin就默认是跟end一样
          //translate 如果是
          tween: Tween(begin: 1.0, end: 1.5),
          duration: Duration(seconds: 1),
          //把tween设置的开始和结束值传给builder的value值
          builder: (context, value, child) {
            return Container(
              width: 50,
              height: 50,
              color: Colors.blue,
              child: Center(
                // 缩放
                child: Transform.scale(
                  scale: value,
                  child: Text(
                    "Hi",
                    style: TextStyle(
                      fontSize: 36,
                    ),
                  ),
                ),
              ),
            );
          },
        ),

        TweenAnimationBuilder(
          //介于0~1之间的 补间动画 在指定的区间发生的变化
          //begin一开始有用,如果没设置begin就默认是跟end一样
          //Tween(begin: Offset(0.0,-10.0), end: Offset(20.0,0.0)),
          tween: Tween(begin: Offset(0.0, -10.0), end: Offset(20.0, 0.0)),
          duration: Duration(seconds: 1),
          //把tween设置的开始和结束值传给builder的value值
          builder: (context, value, child) {
            return Container(
              width: 50,
              height: 50,
              color: Colors.blue,
              child: Center(
                //平移
                child: Transform.translate(
                  //dx dy在横坐标和纵坐标之间转换
                  offset: value,
                  child: Text(
                    "Ha",
                    style: TextStyle(
                      fontSize: 36,
                    ),
                  ),
                ),
              ),
            );
          },
        ),

        TweenAnimationBuilder(
          //介于0~1之间的 补间动画 在指定的区间发生的变化
          //begin一开始有用,如果没设置begin就默认是跟end一样
          //如果是translate位移 可以把这样设置
          //Tween(begin: Offset(0.0,-10.0), end: Offset(20.0,0.0)),
          tween: Tween(begin: 1.0, end: 2.0),
          duration: Duration(seconds: 1),
          //把tween设置的开始和结束值传给builder的value值
          builder: (context, value, child) {
            return Container(
              width: 50,
              height: 50,
              color: Colors.blue,
              child: Center(
                //旋转
                child: Transform.rotate(
                  //0~2pi之间的取值也就是0~6.28
                  angle: value,
                  child: Text(
                    "Ho",
                    style: TextStyle(
                      fontSize: 36,
                    ),
                  ),
                ),
              ),
            );
          },
        ),

        SizedBox(
          height: 30,
        ),
        Center(
          child: Container(
            width: 110,
            height: 110,
            color: Colors.blue,
            child: AnimatedCounter(
              duration: Duration(milliseconds: 500),
              counter: widget.counter,
            ),
          ),
        ),
      ],
    );
  }
}

// class MicPainter extends CustomPainter {
//   MicPainter(this.controller) : paint = Paint() {
//     paint.color = Colors.blue;
//     paint.style = PaintingStyle.stroke;
//     paint.strokeWidth = 5.0;
//   }

//   final AnimationController controller;
//   final Paint paint;

//   @override
//   void paint(Canvas canvas, Size size) {
//     double progress = controller.value;
//     double radius = size.width / 2;
//     double angle = 2 * math.pi * progress;
//     Offset center = Offset(radius, radius);
//     canvas.drawCircle(center, radius, paint);
//     if (progress > 0) {
//       canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
//           -math.pi / 2, angle, false, paint..style = PaintingStyle.fill);
//     }
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }

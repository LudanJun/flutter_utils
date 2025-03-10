import 'package:flutter/material.dart';

//478呼吸法动画
class FourSevenEightPage extends StatefulWidget {
  const FourSevenEightPage({super.key});

  @override
  State<FourSevenEightPage> createState() => _FourSevenEightPageState();
}

class _FourSevenEightPageState extends State<FourSevenEightPage>
    with TickerProviderStateMixin {
  //定义动画控制器
  late AnimationController _expansionController;
  late AnimationController _opacityController;

  late Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //为什么要放在initState()里
    //因为控件还没创建出来 this是不能被访问的
    _expansionController = new AnimationController(
      vsync: this,
    );
    // _animation =
    //     Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _opacityController = new AnimationController(
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    //销毁
    _expansionController.dispose();
    _opacityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //4秒吸气 7秒屏住呼吸 8秒呼气 1秒休息
    // //添加交错动画
    // Animation animation1 = Tween(begin: 0.0, end: 1.0)
    //     // 4秒/20秒 =0.2 占比
    //     .chain(CurveTween(curve: Interval(0.0, 0.2)))
    //     .animate(_animationController);
    // Animation animation2 = Tween(begin: 0.0, end: 1.0)
    //     // 7秒/20秒 =0.2 占比
    //     .chain(CurveTween(curve: Interval(0.0, 0.2)))
    //     .animate(_animationController);
    // //8秒呼气
    // Animation animation3 = Tween(begin: 1.0, end: 0.0)
    //     // 9秒/20秒 =0.2 占比
    //     .chain(CurveTween(curve: Interval(0.4, 0.95)))
    //     .animate(_animationController);

    return Scaffold(
      appBar: AppBar(
        title: Text("478呼吸法动画"),
      ),
      body: Center(
        //万能的动画控件
        child: FadeTransition(
          // 想在0.5-1.0之间变动
          //反过来从1.0最亮 到 0.5淡下去
          opacity: Tween(begin: 1.0, end: 0.5)
              .animate(_opacityController), //_opacityController,
          child: AnimatedBuilder(
            //animation不在乎这个值多少,只在乎_animationController 变动了通知控件刷新
            animation: _expansionController,
            builder: (context, child) {
              return Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                  //渐变效果
                  gradient: RadialGradient(
                    colors: [
                      Colors.blue[600]!,
                      Colors.blue[200]!,
                    ],
                    //0-0.5填充第一种颜色
                    //0.5-1.0填充第二种颜色
                    //颜色有几个stops里面就写几个
                    stops: [
                      _expansionController.value,
                      _expansionController.value + 0.1,
                    ],
                  ),
                ),
              );
            },
            // child:
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //循环repeat 加倒放reverse forward往前
          // _animationController.repeat(reverse: true);
          //第一步 4秒
          _expansionController.duration = Duration(seconds: 4);
          _expansionController.forward();
          //等待4秒执行下面操作
          await Future.delayed(Duration(seconds: 4));

          //第二步 等待7秒
          //1750毫秒是单程 往返是3.5秒
          //往返两趟是 7秒
          _opacityController.duration = Duration(milliseconds: 1750);
          _opacityController.repeat(reverse: true);
          //等待7秒再去执行
          await Future.delayed(Duration(seconds: 7));
          //运行7秒后重置
          _opacityController.reset();

          //第三步 回去动画
          _expansionController.duration = Duration(seconds: 8);
          _expansionController.reverse();
        },
      ),
    );
  }
}

//隐式动画
class AnimatedContainer extends StatefulWidget {
  const AnimatedContainer({super.key});

  @override
  State<AnimatedContainer> createState() => _AnimatedContainerState();
}

class _AnimatedContainerState extends State<AnimatedContainer> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

import 'package:flutter/material.dart';
import 'package:velocity_x/src/velocity_x_extensions.dart';

Decoration myBoxDec(animation, {isCircle = false, isDark = false}) {
  return BoxDecoration(
    shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: isDark
          ? [
              Colors.grey[700],
              Colors.grey[600],
              Colors.grey[700],
              // Color(0xfff6f7f9),
            ]
          : [
              const Color(0xfff6f7f9),
              const Color(0xffe9ebee),
              const Color(0xfff6f7f9),
            ],
      stops: [
        animation.value - 1,
        animation.value,
        animation.value + 1,
      ],
    ),
  );
}

class VelocityZeroCardSkeleton extends StatefulWidget {
  const VelocityZeroCardSkeleton(
      {this.isCircularImage = true,
      this.isBottomLinesActive = true,
      this.isDark = false});
  final bool isCircularImage;
  final bool isBottomLinesActive;
  final bool isDark;

  @override
  _VelocityZeroCardSkeletonState createState() =>
      _VelocityZeroCardSkeletonState();
}

class _VelocityZeroCardSkeletonState extends State<VelocityZeroCardSkeleton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    animation = Tween<double>(begin: -1.0, end: 2.0).animate(
        CurvedAnimation(curve: Curves.easeInOutSine, parent: _controller));

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        _controller.repeat();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: context.percentHeight * 10,
                      width: context.percentWidth * 10,
                      decoration: myBoxDec(animation,
                          isCircle: widget.isCircularImage,
                          isDark: widget.isDark),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: context.percentWidth * 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          LineContainer(20, 0.8, animation, widget.isDark),
                          LineContainer(15, 0.7, animation, widget.isDark),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: context.percentWidth * 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          LineContainer(15, 0.8, animation, widget.isDark),
                          LineContainer(15, 0.7, animation, widget.isDark),
                        ],
                      ),
                    ),
                  ],
                ),
                if (widget.isBottomLinesActive)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      LineContainer(70, 0.7, animation, widget.isDark),
                      const SizedBox(
                        height: 10,
                      ),
                      LineContainer(80, 0.7, animation, widget.isDark),
                      const SizedBox(
                        height: 10,
                      ),
                      LineContainer(50, 0.7, animation, widget.isDark),
                    ],
                  )
                else
                  const Offstage()
              ],
            ),
          ),
        );
      },
    );
  }
}

class LineContainer extends StatelessWidget {
  const LineContainer(
    this.widthRatio,
    this.heightRatio,
    this.animation,
    this.isDark, {
    Key key,
  }) : super(key: key);

  final Animation<double> animation;
  final double widthRatio;
  final double heightRatio;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.percentHeight * heightRatio,
      width: context.percentWidth * widthRatio,
      decoration: myBoxDec(animation, isDark: isDark),
    );
  }
}

class VelocityZeroListSkeleton extends StatelessWidget {
  const VelocityZeroListSkeleton(
      {this.isCircularImage = true,
      this.length = 10,
      this.isBottomLinesActive = true,
      this.isDark = false});

  final bool isCircularImage;
  final bool isBottomLinesActive;
  final int length;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return VelocityZeroCardSkeleton(
          isCircularImage: isCircularImage,
          isBottomLinesActive: isBottomLinesActive,
          isDark: isDark,
        );
      },
    );
  }
}

// TODO: CardProfile VelocityZero

class PKCardProfileSkeleton extends StatefulWidget {
  const PKCardProfileSkeleton(
      {this.isCircularImage = true, this.isBottomLinesActive = true});
  final bool isCircularImage;
  final bool isBottomLinesActive;

  @override
  _PKCardProfileSkeletonState createState() => _PKCardProfileSkeletonState();
}

class _PKCardProfileSkeletonState extends State<PKCardProfileSkeleton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    animation = Tween<double>(begin: -1.0, end: 2.0).animate(
        CurvedAnimation(curve: Curves.easeInOutSine, parent: _controller));

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        _controller.repeat();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: width * 0.25,
                  width: width * 0.25,
                  decoration:
                      myBoxDec(animation, isCircle: widget.isCircularImage),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      4,
                      (i) => Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: width * 0.13,
                            width: width * 0.13,
                            decoration: myBoxDec(animation,
                                isCircle: widget.isCircularImage),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            height: width * 0.13,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: height * 0.008,
                                  width: width * 0.3,
                                  decoration: myBoxDec(animation),
                                ),
                                Container(
                                  height: height * 0.007,
                                  width: width * 0.2,
                                  decoration: myBoxDec(animation),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ).toList(),
                  ),
                ),
                if (widget.isBottomLinesActive)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: height * 0.007,
                        width: width * 0.7,
                        decoration: myBoxDec(animation),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: height * 0.007,
                        width: width * 0.8,
                        decoration: myBoxDec(animation),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: height * 0.007,
                        width: width * 0.5,
                        decoration: myBoxDec(animation),
                      ),
                    ],
                  )
                else
                  const Offstage()
              ],
            ),
          ),
        );
      },
    );
  }
}

// TODO: CardPage VelocityZero

class PKCardPageSkeleton extends StatefulWidget {
  const PKCardPageSkeleton({this.totalLines = 5});
  final int totalLines;

  @override
  _PKCardPageSkeletonState createState() => _PKCardPageSkeletonState();
}

class _PKCardPageSkeletonState extends State<PKCardPageSkeleton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    animation = Tween<double>(begin: -1.0, end: 2.0).animate(
        CurvedAnimation(curve: Curves.easeInOutSine, parent: _controller));

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        _controller.repeat();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(
                    widget.totalLines,
                    (i) => Column(
                          children: <Widget>[
                            Container(
                              height: height * 0.007,
                              width: width * 0.7,
                              decoration: myBoxDec(animation),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: height * 0.007,
                              width: width * 0.8,
                              decoration: myBoxDec(animation),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: height * 0.007,
                              width: width * 0.5,
                              decoration: myBoxDec(animation),
                            ),
                          ],
                        )).toList(),
              )),
        );
      },
    );
  }
}

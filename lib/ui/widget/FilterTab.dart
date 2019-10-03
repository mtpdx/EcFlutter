import 'package:flutter/material.dart';

class FilterTab extends StatefulWidget {
  FilterTab({
    @required this.onTabChangedListener,
    @required this.onTabStyleChangedListener,
    this.initialSelection = 0,
    this.showTag = 0,
  }) : assert(onTabChangedListener != null);
  final Function(int position) onTabChangedListener;
  final Function(int position) onTabStyleChangedListener;
  int initialSelection;
  int showTag; // 0 grid  1 list

  @override
  _FilterTabState createState() {
    return _FilterTabState();
  }
}

class _FilterTabState extends State<FilterTab> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if(widget.initialSelection == 0) return;
            _setTab(0);
          },
          child: Text(
            '综合',
            style: TextStyle(
              fontSize: 14,
              color: widget.initialSelection == 0
                  ? Color(0xfffe2121)
                  : Color(0xff666666),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if(widget.initialSelection == 1) return;
            _setTab(1);
          },
          child: Text(
            '销量',
            style: TextStyle(
              fontSize: 14,
              color: widget.initialSelection == 1
                  ? Color(0xfffe2121)
                  : Color(0xff666666),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            _setTab(widget.initialSelection == 2 ? 3 : 2);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '价格',
                style: TextStyle(
                  fontSize: 14,
                  color: (widget.initialSelection == 2 ||
                          widget.initialSelection == 3)
                      ? Color(0xfffe2121)
                      : Color(0xff666666),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.arrow_drop_up,
                    size: 15,
                    color: widget.initialSelection == 2
                        ? Color(0xfffe2121)
                        : Color(0xff666666),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 15,
                    color: widget.initialSelection == 3
                        ? Color(0xfffe2121)
                        : Color(0xff666666),
                  ),
                ],
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            if(widget.showTag == 0){
              setState(() {
                widget.showTag = 1;
              });
              widget.onTabStyleChangedListener(1);
            }else{
              setState(() {
                widget.showTag = 0;
              });
              widget.onTabStyleChangedListener(0);
            }
          },
          child: Icon(
            widget.showTag == 0 ? Icons.grid_on : Icons.list,
            size: 18,
            color: Color(0xff666666)
          ),
        ),
      ],
    );
  }

  void _setTab(int position) {
    widget.onTabChangedListener(position);
    setState(() {
      widget.initialSelection = position;
    });
  }
}

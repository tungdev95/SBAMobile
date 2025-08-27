import 'package:flutter/material.dart';

enum BottomNavigationBadgeShape {
  circle,
  square,
  rounded_corner,
}

enum BottomNavigationBadgePosition {
  topLeft,
  topCenter,
  topRight,
  centerLeft,
  center,
  centerRight,
  bottomLeft,
  bottomCenter,
  bottomRight,
}

class BottomNavigationBadge {
  Color? backgroundColor;
  Color? textColor;
  BottomNavigationBadgeShape? badgeShape;
  double? textSize;
  BottomNavigationBadgePosition? position;

  BorderRadius? _radius;
  Alignment? alignment;

  BottomNavigationBadge(
      {this.backgroundColor,
      this.textColor,
      this.badgeShape,
      this.position,
      this.textSize});

  BorderRadius setBorder() {
    if (badgeShape == BottomNavigationBadgeShape.circle) {
      _radius = BorderRadius.circular(14);
    } else if (badgeShape == BottomNavigationBadgeShape.square) {
      _radius = BorderRadius.zero;
    } else if (badgeShape == BottomNavigationBadgeShape.rounded_corner) {
      _radius = BorderRadius.circular(4);
    } else {
      _radius = BorderRadius.circular(4);
    }
    return _radius!;
  }

  Alignment setPosition() {
    if (position == BottomNavigationBadgePosition.topLeft) {
      alignment = Alignment.topLeft;
    } else if (position == BottomNavigationBadgePosition.topCenter) {
      alignment = Alignment.topCenter;
    } else if (position == BottomNavigationBadgePosition.topRight) {
      alignment = Alignment.topRight;
    } else if (position == BottomNavigationBadgePosition.centerLeft) {
      alignment = Alignment.centerLeft;
    } else if (position == BottomNavigationBadgePosition.center) {
      alignment = Alignment.center;
    } else if (position == BottomNavigationBadgePosition.centerRight) {
      alignment = Alignment.centerRight;
    } else if (position == BottomNavigationBadgePosition.bottomLeft) {
      alignment = Alignment.bottomLeft;
    } else if (position == BottomNavigationBadgePosition.bottomCenter) {
      alignment = Alignment.bottomCenter;
    } else if (position == BottomNavigationBadgePosition.bottomRight) {
      alignment = Alignment.bottomRight;
    } else {
      alignment = Alignment.bottomRight;
    }
    return alignment!;
  }

  List setBadge(List items, String content, int index) {
    Widget badge = Visibility(
      key: UniqueKey(),
      visible: content.isNotEmpty,
      child: Container(
        height: 14,
        width: 14,
        decoration: BoxDecoration(
            color: backgroundColor ?? Colors.red,
            borderRadius: setBorder(),
            border: Border.all(color: Colors.white, width: 1)),
        constraints: const BoxConstraints(
          minWidth: 14,
          minHeight: 14,
        ),
        child: Center(
          child: Text(
            content,
            style: TextStyle(
                color: textColor ?? Colors.white,
                fontSize: textSize ?? 8,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
    BottomNavigationBarItem replacer = BottomNavigationBarItem(
        icon: Stack(
          clipBehavior: Clip.none,
          alignment: setPosition(),
          children: <Widget>[
            SizedBox(
              child: items[index].icon,
              height: 24,
              width: 36,
            ),
            badge
          ],
        ),
        label: items[index].title,
        activeIcon: Stack(
          clipBehavior: Clip.none,
          alignment: setPosition(),
          children: <Widget>[
            SizedBox(
              child: items[index].icon,
              height: 24,
              width: 36,
            ),
            badge
          ],
        ),
        backgroundColor: items[index].backgroundColor);
    var newItem = <BottomNavigationBarItem>[items[0], items[1], items[2]];
    newItem.removeAt(index);
    newItem.insert(index, replacer);
    return newItem;
  }

  List removeBadge(List items, int index) {
    if (items[index].icon is Stack) {
      BottomNavigationBarItem replacer = BottomNavigationBarItem(
          icon: items[index].icon.children[0].child,
          label: items[index].title,
          activeIcon: items[index].activeIcon.children[0].child,
          backgroundColor: items[index].backgroundColor);
      items.removeAt(index);
      items.insert(index, replacer);
    }
    return items;
  }

  List removeAll(List items) {
    for (var i = 0; i < items.length; i++) {
      if (items[i].icon is Stack) {
        BottomNavigationBarItem replacer = BottomNavigationBarItem(
            icon: items[i].icon.children[0],
            label: items[i].title,
            activeIcon: items[i].activeIcon.children[0],
            backgroundColor: items[i].backgroundColor);
        items.removeAt(i);
        items.insert(i, replacer);
      }
    }
    return items;
  }
}

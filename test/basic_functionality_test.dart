import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/time.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // 测试数据准备
  late List<Widget> items;
  late DateTime now;
  late Time initialTime;

  setUp(() {
    // 初始化测试数据
    items = List.generate(
      10, 
      (index) => Text('Item $index')
    );
    now = DateTime.now();
    initialTime = Time(hours: 12, minutes: 30);
  });

  // 简单选择器测试组 - 专注于构造函数和参数验证
  group('Basic BottomPicker Tests', () {
    test('简单选择器构造函数测试', () {
      // 创建简单选择器
      final bottomPicker = BottomPicker(
        headerBuilder: (context) => Text('Simple Picker'),
        items: items,
        selectedItemIndex: 2,
      );

      // 验证选择器类型
      expect(bottomPicker.bottomPickerType, BottomPickerType.simple);
      // 验证参数设置
      expect(bottomPicker.selectedItemIndex, 2);
      expect(bottomPicker.dismissable, false);
      expect(bottomPicker.displaySubmitButton, true);
    });

    test('简单选择器参数边界测试', () {
      // 测试边界条件 - 正常情况
      expect(() {
        BottomPicker(
          headerBuilder: (context) => Text('Test'),
          items: items,
          selectedItemIndex: 5,
        );
      }, returnsNormally);

      // 测试边界条件 - 超出范围的索引
      expect(() {
        BottomPicker(
          headerBuilder: (context) => Text('Test'),
          items: items,
          selectedItemIndex: 15, // 超出范围
        );
      }, throwsAssertionError);

      // 测试边界条件 - 负索引
      expect(() {
        BottomPicker(
          headerBuilder: (context) => Text('Test'),
          items: items,
          selectedItemIndex: -1, // 负索引
        );
      }, throwsAssertionError);
    });
  });

  // 日期选择器测试组 - 专注于构造函数和参数验证
  group('Date BottomPicker Tests', () {
    test('日期选择器构造函数测试', () {
      // 创建日期选择器
      final bottomPicker = BottomPicker.date(
        headerBuilder: (context) => Text('Date Picker'),
        initialDateTime: now,
      );

      // 验证选择器类型
      expect(bottomPicker.bottomPickerType, BottomPickerType.dateTime);
      // 验证参数设置
      expect(bottomPicker.initialDateTime, now);
    });
  });

  // 时间选择器测试组 - 专注于构造函数和参数验证
  group('Time BottomPicker Tests', () {
    test('时间选择器构造函数测试', () {
      // 创建时间选择器
      final bottomPicker = BottomPicker.time(
        headerBuilder: (context) => Text('Time Picker'),
        initialTime: initialTime,
      );

      // 验证选择器类型
      expect(bottomPicker.bottomPickerType, BottomPickerType.time);
      // 验证初始时间设置
      expect(bottomPicker.initialTime?.hours, 12);
      expect(bottomPicker.initialTime?.minutes, 30);
    });

    test('Time类基本功能测试', () {
      // 测试Time构造函数
      final time = Time(hours: 15, minutes: 45);
      expect(time.hours, 15);
      expect(time.minutes, 45);
      
      // 测试Time.now()
      final currentTime = Time.now();
      final now = DateTime.now();
      expect(currentTime.hours, now.hour);
      expect(currentTime.minutes, now.minute);
      
      // 测试toDateTime方法
      final dateTime = time.toDateTime;
      expect(dateTime.hour, 15);
      expect(dateTime.minute, 45);
    });

    test('Time类参数验证测试', () {
      // 测试有效参数
      expect(() => Time(hours: 23, minutes: 59), returnsNormally);
      expect(() => Time(hours: 0, minutes: 0), returnsNormally);
      
      // 测试无效参数 - 小时超出范围
      expect(() => Time(hours: 24, minutes: 0), throwsAssertionError);
      expect(() => Time(hours: -1, minutes: 0), throwsAssertionError);
      
      // 测试无效参数 - 分钟超出范围
      expect(() => Time(hours: 0, minutes: 60), throwsAssertionError);
      expect(() => Time(hours: 0, minutes: -1), throwsAssertionError);
    });
  });
}
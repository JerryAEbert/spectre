/*

  Copyright (C) 2012 John McCutchan <john@johnmccutchan.com>
  
  This software is provided 'as-is', without any express or implied
  warranty.  In no event will the authors be held liable for any damages
  arising from the use of this software.

  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:

  1. The origin of this software must not be misrepresented; you must not
     claim that you wrote the original software. If you use this software
     in a product, an acknowledgment in the product documentation would be
     appreciated but is not required.
  2. Altered source versions must be plainly marked as such, and must not be
     misrepresented as being the original software.
  3. This notice may not be removed or altered from any source distribution.

*/

interface Logger {
  void Error(String e);
  void Warning(String w);
  void Info(String i);
}

class PrintLogger implements Logger {
  void Error(String e) {
    print('Error: $e');
  }

  void Warning(String w) {
    print('Warning: $w');
  }

  void Info(String i) {
    print('$i');
  }
}

class NullLogger implements Logger {
  void Error(String e) {
  }
  void Warning(String w) {
  }
  void Info(String i) {

  }
}

class HtmlLogger implements Logger {
  Element _logElement;
  int _line_num;
  HtmlLogger(String element) {
    _logElement = document.query(element);
    _line_num = 0;
  }
  void _Append(String a) {
    _logElement.innerHTML = '$a ${_logElement.innerHTML}';
    _line_num++;
  }
  void Error(String e) {
    _Append('<p style=\"color:red\">${_line_num}: $e</p>');
  }
  void Warning(String w) {
    _Append('<p style=\"color:orange\">${_line_num}: $w</p>');
  }
  void Info(String i) {
    _Append('<p style=\"color:white\">${_line_num}: $i</p>');
  }
  void Log(String i) => Info(i);
}
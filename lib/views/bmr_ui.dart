import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class BmrUi extends StatefulWidget {
  const BmrUi({super.key});

  @override
  State<BmrUi> createState() => _BmrUiState();
}

class _BmrUiState extends State<BmrUi> {
  TextEditingController wCtrl = TextEditingController();
  TextEditingController hCtrl = TextEditingController();
  TextEditingController ageCtrl = TextEditingController();

  double bmrValue = 0;
  bool isMale = true;

  void calculateBmr() {
    if (wCtrl.text.isEmpty || hCtrl.text.isEmpty || ageCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('กรุณาหรอกข้อมูลให้ครบถ้วน'),
          backgroundColor: Colors.pink[800],
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    double weight;
    double height;
    double age;
    try {
      weight = double.parse(wCtrl.text);
      height = double.parse(hCtrl.text);
      age = double.parse(ageCtrl.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('กรุณากรอกตัวเลขที่ถูกต้อง'),
          backgroundColor: Colors.pink[800],
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    double result;
    if (isMale) {
      result = 66 + (13.7 * weight) + (5 * height) - (6.8 * age);
    } else {
      result = 665 + (9.6 * weight) + (1.8 * height) - (4.7 * age);
    }

    setState(() {
      bmrValue = result;
    });
  }

  void clearAll() {
    setState(() {
      wCtrl.clear();
      hCtrl.clear();
      ageCtrl.clear();
      bmrValue = 0;
      isMale = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 50),
                Text(
                  'คำนวณอัตราการเผาผลาญพื้นฐาน (BMR)',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 30),
                Image.asset(
                  'assets/images/exercise.png',
                  width: 130,
                  height: 130,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 20),
                Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: Text('เพศ'),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<bool>(
                        title: Text('ชาย'),
                        value: true,
                        groupValue: isMale,
                        onChanged: (v) {
                          setState(() {
                            isMale = v ?? true;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<bool>(
                        title: Text('หญิง'),
                        value: false,
                        groupValue: isMale,
                        onChanged: (v) {
                          setState(() {
                            isMale = v ?? false;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: Text('น้ำหนัก (kg.)'),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: wCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'กรอกน้ำหนักของคุณ',
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: Text('ส่วนสูง (cm.)'),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: hCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'กรอกส่วนสูงของคุณ',
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: Text('อายุ (years)'),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: ageCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'กรอกอายุของคุณ',
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: calculateBmr,
                  child: Text(
                    'คำนวณ BMR',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    textStyle: TextStyle(fontSize: 18),
                    fixedSize: Size(MediaQuery.of(context).size.width, 55.0),
                  ),
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: clearAll,
                  child: Text(
                    'ล้างข้อมูล',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[400],
                    textStyle: TextStyle(fontSize: 18),
                    fixedSize: Size(MediaQuery.of(context).size.width, 55.0),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'BMR (kcal/day)',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                        Text(
                          bmrValue.toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
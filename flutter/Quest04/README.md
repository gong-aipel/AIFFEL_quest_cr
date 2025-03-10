앱이름

   커피주문 앱

시장(마켓)
   약 1조 시장규모

 타겟
   커피 매니아

 정보설계도
 ![정보설계도](https://github.com/user-attachments/assets/c01014ca-465d-4b4c-8a25-7166540f7ce9)

   앱 와이어 프레임(사용툴: figma) 
  ![와이얼프레임](https://github.com/user-attachments/assets/d66fcc3a-db7a-4b23-997c-a3b9221ae22e)

   프로토타이핑(사용툴: figma)
  
 ![111](https://github.com/user-attachments/assets/f4c41ca2-b604-485c-9da1-130eabdf001b)
 ![222](https://github.com/user-attachments/assets/54c6f147-ad90-4ed8-860d-a0d0be5dccd3)
 ![333](https://github.com/user-attachments/assets/d6256aee-8cfa-4898-994c-5d39356c8206)

메인 앱 구조:
• MaterialApp을 사용하여 앱의 테마와 라우트 설정
• 주요 색상으로 녹색(#22C55E) 사용
  홈 화면 (HomeScreen):
• 검색창 구현
• "Free Delivery" 프로모션 배너
• 카테고리 선택 탭 (Cappuccino, Latte, Decaf)
• 제품 그리드 레이아웃 (GridView)
• 하단 네비게이션 바
상품 상세 화면 (ProductDetailScreen):
• 제품 이미지 표시 영역
• 제품 이름, 평점, 설명
• 사이즈 선택 옵션 (S, M, L)
• 가격 표시 및 "Buy Now" 버튼
주문 화면 (OrderScreen):
• 배달/픽업 옵션 선택
• 배달 주소 정보 및 수정 옵션
• 주문 항목 요약
• 결제 금액 계산 (상품 가격 + 배달비)
• "Place Order" 버튼
 
구현 결과물
 ![0307플러터 작업 결과물](https://github.com/user-attachments/assets/237ace73-e1e2-4e57-a313-4d850e7d69aa)

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> cart = [];
  int _selectedIndex = 0;

  void addToCart(Map<String, dynamic> coffee) {
    setState(() {
      cart.add(coffee);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      HomeScreen(cart: cart, addToCart: addToCart),
      CartScreen(cart: cart),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.local_cafe),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.brown,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cart;
  final Function(Map<String, dynamic>) addToCart;

  HomeScreen({required this.cart, required this.addToCart});

  final List<Map<String, dynamic>> coffeeList = [
    {'name': 'Macchiato Classic', 'price': 45.13},
    {'name': 'Macchiato with Chocolate', 'price': 64.53},
    {'name': 'Macchiato with Strawberry', 'price': 75.50},
    {'name': 'Macchiato with Blueberry', 'price': 75.50},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kopi Kap'),
        backgroundColor: Colors.brown,
      ),
      body: ListView.builder(
        itemCount: coffeeList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(coffeeList[index]['name']),
            subtitle: Text('₱${coffeeList[index]['price']}'),
            trailing: ElevatedButton(
              onPressed: () {
                addToCart(coffeeList[index]); // MyAppState의 setState() 호출됨
              },
              child: Text('Add'),
            ),
          );
        },
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cart;

  CartScreen({required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Colors.brown,
      ),
      body: cart.isEmpty
          ? Center(child: Text('Your cart is empty'))
          : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(cart[index]['name']),
                  subtitle: Text('₱${cart[index]['price']}'),
                );
              },
            ),
    );
  }
}

# 회고

재미있기는 한데 작업하기가 너무 어렵다. 잘하는 사람이 너무 부럽다.
더구나 android studio 가 작동이 되지 않아 dartpad를 이용하니까 더 어렵고 작동이 잘 안되는 어려움이 있다.

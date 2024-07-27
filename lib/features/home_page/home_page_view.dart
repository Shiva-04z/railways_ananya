
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:railways_shiva/features/home_page/home_page_controller.dart';

class HomePageView extends GetView<HomePageController> {
  Widget Card2(String name, String title) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 12,
      ),
      child: Card(
        color: Colors.black.withOpacity(0.9),
        margin: EdgeInsets.all(4),
        elevation: 6,
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 60,
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  title,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Card1(String name, String title, String img) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 12,
      ),
      child: Card(
        color: Colors.black.withOpacity(0.3),
        margin: EdgeInsets.all(4),
        elevation: 6,
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 120,
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.blue,
                    ),
                    child: Image(
                      image: AssetImage(img),
                      height: 50,
                      width: 50,
                      color: Colors.white,
                    )),
                Text(
                  name,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  title,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedIcon(IconData icon, String label) {
    return Container(
      width: 85,
      height:35,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 8.0),
          Text(
            label,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      resizeToAvoidBottomInset: false,

      bottomNavigationBar:

        BottomNavigationBar(

            backgroundColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: TextStyle(color: Colors.black,fontSize: 0),

            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: controller.selectedIndex.value == 0
                    ? _buildSelectedIcon(Icons.home, 'Home')
                    :  ImageIcon(
                  color: Colors.grey[600],
                  size: 25,
                  AssetImage("assets/icons/home.png"),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: controller.selectedIndex.value == 1
                    ? _buildSelectedIcon(Icons.panorama_photosphere, 'Ticket')
                    :  ImageIcon(
                  color: Colors.grey[600],
                  size: 25,
                  AssetImage("assets/icons/web.png"),
                ),
                label: 'Ticket',
              ),
              BottomNavigationBarItem(
                icon: controller.selectedIndex.value == 2
                    ? _buildSelectedIcon(Icons.account_circle, 'Passenger')
                    : ImageIcon(
                  color: Colors.grey[600],
                  size: 25,
                  AssetImage("assets/icons/account.png"),
                ),
                label: 'Passenger',
              ),
              BottomNavigationBarItem(
                icon: controller.selectedIndex.value== 3
                    ? _buildSelectedIcon(Icons.password, 'Extra')
                    : ImageIcon(
                  color: Colors.grey[600],
                  size: 25,
                  AssetImage("assets/icons/menu.png"),
                ),
                label: 'Extra',
              ),
            ],
            currentIndex: 0,
            selectedItemColor: Colors.amber[800],
            onTap: (value) => controller.onItemTapped(value),

                ),

      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/home_bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
            child: Container(
              decoration:
              BoxDecoration(color: Colors.green[800]?.withOpacity(0.5)),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
                      controller.signOut();
                    },),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Train Services",
                        style: TextStyle(
                            color: Colors.grey[800],fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          child: Card1("Train", "Search your next Train",
                              "assets/img/train.png"),
                          onTap: () {
                            controller.toUpload();
                          },
                        ),
                        InkWell(
                          child: Card1("Food", "Food Delivery at your Seat",
                              "assets/img/food.png"),
                          onTap: () {},
                        )
                      ],
                    ),
                    Row(
                      children: [
                        InkWell(
                          child: Card1("Book Seat", "Passenger Reservation",
                              "assets/img/ask_disha.png"),
                          onTap: () {},
                        ),
                        InkWell(
                          child: Card1("Rooms", "Book Rooms at Station",
                              "assets/img/rooms.png"),
                          onTap: () {},
                        )
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Other Services",
                        style: TextStyle(
                            color: Colors.grey[800],fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          child: Card2("Flight", "Book your next flight"),
                          onTap: () {},
                        ),
                        InkWell(
                          child: Card2("Hotel", "Book your next stay"),
                          onTap: () {},
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        InkWell(
                          child: Card2("Bus", "Book your next bus"),
                          onTap: () {},
                        ),
                        InkWell(
                          child: Card2("Tourism", "Explore tour options"),
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

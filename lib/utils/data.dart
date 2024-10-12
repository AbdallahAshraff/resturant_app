/*const List meals = [
  {
    "image":
        "https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "is_favorited": true,
    "price": "18.75",
    "name": "Mix Pizza",
    "description": "Breakfast and Brunch - American - Sandwich",
    "delivery_fee": "\$1.49 Delivery Fee",
    "rate": "4.3",
    "rate_number": "273",
    "extras": [
      {"name": "Extra Cheese", "price": "1.50"},
      {"name": "Bacon", "price": "2.00"},
      {"name": "Pepperoni", "price": "1.75"},
    ]
  },
  {
    "image":
        "https://images.unsplash.com/photo-1559058789-672da06263d8?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mjd8fGZvb2R8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "is_favorited": false,
    "price": "6.90",
    "name": "Freshy Salmon",
    "description": "Breakfast and Brunch - Juice and Smoothies",
    "time": "15-25 Min",
    "delivery_fee": "\$2.49 Delivery Fee",
    "rate": "4.4",
    "rate_number": "22",
    "extras": [
      {"name": "Avocado", "price": "1.50"},
      {"name": "Chia Seeds", "price": "0.75"},
      {"name": "Honey", "price": "0.50"},
    ]
  },
  {
    "image":
        "https://images.unsplash.com/photo-1543339308-43e59d6b73a6?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "price": "12.50",
    "is_favorited": false,
    "name": "Greeny Salad",
    "description": "Breakfast and Brunch - American - Sandwich",
    "delivery_fee": "\$1.49 Delivery Fee",
    "rate": "4.8",
    "rate_number": "273",
    "extras": [
      {"name": "Extra Chicken", "price": "2.00"},
      {"name": "Feta Cheese", "price": "1.25"},
      {"name": "Boiled Egg", "price": "1.00"},
    ]
  },
  {
    "image":
        "https://cdn11.bigcommerce.com/s-3xaaslonk2/images/stencil/500x659/products/131/1030/376__03833.1660073838.jpg?c=1",
    "is_favorited": false,
    "name": "Lou Malnati's Pizza",
    "price": "67.99",
    "description": "2 Lou Malnati's Deep Dish Pizzas",
    "rate": "4.3",
    "rate_number": "273",
    "extras": [
      {"name": "Grilled Chicken", "price": "2.50"},
      {"name": "Pineapple", "price": "0.75"},
    ]
  },
  {
    "image":
        "https://images.unsplash.com/photo-1512621776951-a57141f2eefd?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "price": "5.50",
    "name": "Greeny Salad",
    "description": "Breakfast and Brunch - American - Sandwich",
    "sources": "Egg - Salad",
    "is_favorited": true,
    "delivery_fee": "\$1.49 Delivery Fee",
    "rate": "4.5",
    "rate_number": "273",
    "extras": [
      {"name": "Extra Avocado", "price": "1.50"},
      {"name": "Croutons", "price": "0.75"},
    ]
  },
  {
    "image":
        "https://images.unsplash.com/photo-1559058789-672da06263d8?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mjd8fGZvb2R8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "is_favorited": false,
    "price": "6.90",
    "name": "Freshy Salmon",
    "description": "Breakfast and Brunch - Juice and Smoothies",
    "sources": "Egg - Salad",
    "time": "15-25 Min",
    "delivery_fee": "\$2.49 Delivery Fee",
    "rate": "4.4",
    "rate_number": "22",
    "extras": [
      {"name": "Chia Seeds", "price": "0.75"},
      {"name": "Extra Mango", "price": "1.25"},
    ]
  },
];*/

import 'package:resturant_app/utils/constants.dart';
import 'package:resturant_app/utils/model.dart';

Future<List<Meals>> fetchMeals() async {
  final response = await supabase.from('meals').select();
  return Meals.converter(response);
}

Future<List<Comments>> fetchComments() async {
  final response = await supabase.from('comments').select();
  return Comments.converter(response);
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/product.dart';
import '../provider/products_op.dart';

class ChatScreen extends StatefulWidget {
  final Product product;

  const ChatScreen({
    required this.product,
    Key? key,
  }) : super(key: key);

  @override
  State createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final List<String> messages = [];
  String textOnly = "";
  final TextEditingController messageController = TextEditingController();
  bool isLoading = false;

  void initState() {
    Provider.of<ProductsOp>(context, listen: false).productDetail = "";
    super.initState();
  }

  void _handleSubmittedMessage() async {
    final messageText = messageController.text;
    if (messageText.isNotEmpty) {
      setState(() {
        messages.add(messageText);
        messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: messageController,
                    onSubmitted: (text) async {
                      setState(() {
                        isLoading = true;
                      });
                      textOnly =
                      await Provider.of<ProductsOp>(context, listen: false)
                          .getResult("ddd", "sss");
                      setState(() {
                        isLoading = false;
                      });
                      print(textOnly);
                    },
                    decoration: InputDecoration.collapsed(
                      hintText: 'Related to ${widget.product.title}',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async {
                    messageController.clear();
                    setState(() {
                      isLoading = true;
                    });
                    textOnly = await Provider.of<ProductsOp>(context,
                        listen: false)
                        .getResult("in Short", "Related to ${widget.product.title}");
                    setState(() {
                      isLoading = false;
                    });
                  },
                ),
              ],
            ),
          ),
          if (isLoading)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CircularProgressIndicator(),
            )
          else
            Divider(
              thickness: 2,
              color: Colors.grey.withOpacity(0.5),
            ),
          Consumer<ProductsOp>(builder: (context, MyBooking, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                Provider.of<ProductsOp>(context, listen: false).productDetail,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

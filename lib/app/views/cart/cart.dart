import 'cart_items.dart';
import 'empty_cart.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: GetBuilder<ProductsController>(builder: (controller) {
            return Text(controller.cartItems.isEmpty
                ? 'CART'
                : 'CART (${controller.cartItems.length})');
          }),
          actions: [
            GetBuilder<ProductsController>(
                builder: (controller) => IconButton(
                    onPressed: controller.cartItems.isEmpty
                        ? null
                        : () async {
                            await showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      content: const Text(
                                          'Are you sure you want to clear the cart?'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Get.back(result: true);
                                            },
                                            child: const Text('Yes')),
                                        TextButton(
                                            onPressed: () {
                                              Get.back(result: false);
                                            },
                                            child: const Text('No'))
                                      ],
                                    )).then((value) {
                              if (value) {
                                controller.deleteCartItems();
                              } else {}
                            });
                          },
                    icon: Icon(
                      Icons.delete_outline,
                      color: context.theme.colorScheme.error,
                    )))
          ],
        ),
        bottomNavigationBar:
            GetBuilder<ProductsController>(builder: (productController) {
          return productController.cartItems.isEmpty
              ? Container()
              : BottomAppBar(
                  elevation: 11,
                  height: 40,
                  surfaceTintColor: context.theme.colorScheme.secondary,
                  child: const Center(
                    child: Text('TOTAL USD 1200.21'),
                  ),
                );
        }),
        body: GetBuilder<ProductsController>(
            builder: (controller) => controller.cartItems.isEmpty
                ? const EmptyCart()
                : const CartItems()));
  }
}

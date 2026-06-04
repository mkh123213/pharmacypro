part of 'customer_orders_body.dart';

extension CustomerOrdersBodyOpenForm on CustomerOrdersBody {
void _openForm(BuildContext context, CustomerOrdersLoaded state) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<CustomerOrdersCubit>(),
          child: CustomerOrderFormBottomSheet(
            medications: state.medications,
            branches: state.branches,
          ),
        );
      },
    );
  }
}

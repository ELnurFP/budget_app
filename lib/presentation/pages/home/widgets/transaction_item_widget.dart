import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:home_budget_app/budget_app.dart';

class TransactionItemWidget extends StatefulWidget {
  const TransactionItemWidget({
    super.key,
    required this.transaction,
    required this.onDelete,
  });

  final TransactionItem transaction;
  final VoidCallback onDelete;

  @override
  State<TransactionItemWidget> createState() => _TransactionItemWidgetState();
}

class _TransactionItemWidgetState extends State<TransactionItemWidget>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;
  late final SlidableController _slidableController;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
    _initializeSlidableController();
  }

  void _initializeAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation =
        Tween<double>(begin: 40.0, end: 200.0).animate(_animationController);
  }

  void _initializeSlidableController() {
    _slidableController = SlidableController(this);
    _slidableController.animation.addListener(_onSlidableAnimationChange);
  }

  void _onSlidableAnimationChange() {
    if (_slidableController.actionPaneType.value == ActionPaneType.end) {
      if ((_slidableController.ratio * -1) > 0.1) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _slidableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(widget.transaction.description),
      controller: _slidableController,
      endActionPane: _buildEndActionPane(),
      child: _buildTransactionCard(context),
    );
  }

  ActionPane _buildEndActionPane() {
    return ActionPane(
      motion: const ScrollMotion(),
      extentRatio: 0.6,
      children: [
        Expanded(
          child: Center(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) => _buildAnimatedContainer(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedContainer() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: _animation.value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 1000),
          height: 60,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: activeButton,
            borderRadius: BorderRadius.circular(40),
          ),
          child: _animation.value > 180
              ? _buildActionButtons()
              : _buildDefaultButton(),
        ),
      ),
    );
  }

  Widget _buildDefaultButton() {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        color: activeButton,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildIcon(Icons.send, Colors.white, () => _handleAction('Send')),
        8.gap,
        _buildVerticalDivider(),
        8.gap,
        _buildIcon(Icons.edit, Colors.white, () => _handleAction('Edit')),
        8.gap,
        _buildVerticalDivider(),
        8.gap,
        _buildIcon(Icons.delete, Colors.white, () {
          widget.onDelete.call();
          _animationController.reverse();
          _slidableController.close();
        }),
      ],
    );
  }

  void _handleAction(String action) {
    showStyledSnackbar(
      message: action,
      onDismiss: () {
        _animationController.reverse();
        _slidableController.close();
      },
    );
  }

  Widget _buildTransactionCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width - 20,
        height: 100,
        decoration: const BoxDecoration(
          color: secondary,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        child: _buildTransactionDetails(),
      ),
    );
  }

  Widget _buildTransactionDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTransactionIcon(),
        _buildTransactionInfo(),
        _buildTransactionTime(),
      ],
    );
  }

  Widget _buildTransactionIcon() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(widget.transaction.icon, color: Colors.indigo[900]),
      ),
    );
  }

  Widget _buildTransactionInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '- \$${widget.transaction.amount.toStringAsFixed(2)}',
          style: const TextStyle(
            color: activeRed,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        Text(
          '${widget.transaction.title} «${widget.transaction.description}»',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          widget.transaction.address,
          style: const TextStyle(
            color: Colors.white30,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionTime() {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Text(
        widget.transaction.time,
        style: const TextStyle(
          color: Colors.white30,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      width: 1,
      height: 40,
      color: Colors.white,
    );
  }

  Widget _buildIcon(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Icon(icon, color: color),
      ),
    );
  }
}

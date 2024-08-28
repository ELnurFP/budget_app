import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:home_budget_app/budget_app.dart';

class TransactionItemWidget extends StatefulWidget {
  const TransactionItemWidget(
      {super.key, required this.transaction, required this.onDelete});

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
    _slidableController = SlidableController(this);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animation =
        Tween<double>(begin: 40.0, end: 200.0).animate(_animationController);

    _slidableController.animation.addListener(() {
      if (_slidableController.actionPaneType.value == ActionPaneType.end) {
        if ((_slidableController.ratio * -1) > 0.1) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
      }
    });
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
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.6,
        children: [
          // 16.gap,
          const Spacer(),
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
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
                    child: _animation.value > 160
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildIcon(Icons.send, Colors.white, () {
                                _animationController.reverse();
                                _slidableController.close();

                                showStyledSnackbar(message: 'Send');
                              }),
                              _buildVerticalDivider(),
                              _buildIcon(Icons.edit, Colors.white, () {
                                _animationController.reverse();
                                _slidableController.close();
                              }),
                              _buildVerticalDivider(),
                              _buildIcon(Icons.delete, Colors.white, () {
                                widget.onDelete.call();
                                _animationController.reverse();
                                _slidableController.close();
                              }),
                            ],
                          )
                        : Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: activeButton,
                              shape: BoxShape.circle,
                            ),
                          ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      child: Padding(
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child:
                      Icon(widget.transaction.icon, color: Colors.indigo[900]),
                ),
              ),
              Column(
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
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text(
                  widget.transaction.time,
                  style: const TextStyle(
                    color: Colors.white30,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
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

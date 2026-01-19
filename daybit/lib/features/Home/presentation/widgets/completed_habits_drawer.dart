import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CompletedHabitsDrawer extends StatefulWidget {
  final List<String> completedHabits;

  const CompletedHabitsDrawer({super.key, required this.completedHabits});

  @override
  State<CompletedHabitsDrawer> createState() => _CompletedHabitsDrawerState();
}

class _CompletedHabitsDrawerState extends State<CompletedHabitsDrawer> {
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _sheetController.addListener(_onSheetChanged);
  }

  @override
  void dispose() {
    _sheetController.removeListener(_onSheetChanged);
    _sheetController.dispose();
    super.dispose();
  }

  void _onSheetChanged() {
    if (_sheetController.isAttached) {
      final isNowExpanded = _sheetController.size > 0.16;
      if (_isExpanded != isNowExpanded) {
        setState(() {
          _isExpanded = isNowExpanded;
        });
      }
    }
  }

  double _calculateDrawerMaxHeight(BuildContext context) {
    if (widget.completedHabits.isEmpty) return 0.25;

    final screenHeight = MediaQuery.of(context).size.height;
    const double headerHeight = 100;
    final double listHeight = widget.completedHabits.length * 72.0;
    final double totalContentHeight = headerHeight + listHeight + 50;

    return (totalContentHeight / screenHeight).clamp(0.15, 0.85);
  }

  void _toggleDrawer() {
    if (!_sheetController.isAttached) return;

    double targetSize = _calculateDrawerMaxHeight(context);

    if (_isExpanded) {
      _sheetController.animateTo(
        0.15,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _sheetController.animateTo(
        targetSize,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final maxDrawerHeight = _calculateDrawerMaxHeight(context);

    return DraggableScrollableSheet(
      controller: _sheetController,
      initialChildSize: 0.15,
      minChildSize: 0.15,
      maxChildSize: maxDrawerHeight,
      snap: true,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, -5),
              ),
            ],
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            physics: const ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: size.height * 0.15),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min, // Ensure it only takes needed space
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: _toggleDrawer,
                      behavior: HitTestBehavior.opaque,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'habits',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                'Completed',
                                style: GoogleFonts.inter(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          AnimatedRotation(
                            turns: _isExpanded
                                ? 0.5
                                : 0.0, // 180 degree spin (Up/Down)
                            duration: const Duration(milliseconds: 300),
                            child: const Icon(
                              Icons.arrow_outward,
                              color: Colors.black,
                              // size: 32, // Revert to standard size or keep 32? Design had it inside circle?
                              // User didn't complain about Size, just style.
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (widget.completedHabits.isEmpty)
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        alignment: Alignment.center,
                        child: Text(
                          'Complete it',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      )
                    else
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget.completedHabits.length,
                        separatorBuilder: (c, i) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          return Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(widget.completedHabits[index]),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

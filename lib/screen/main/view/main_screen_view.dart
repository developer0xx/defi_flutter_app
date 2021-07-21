import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_images.dart';
import 'package:sapiency_app/common/widgets/snackbar/snackbars.dart';
import 'package:sapiency_app/screen/home/home_page.dart';
import 'package:sapiency_app/screen/main/state/use_main_screen_state.dart';
import 'package:sapiency_app/screen/main/widgets/action_button.dart';
import 'package:sapiency_app/screen/profile/profile_screen.dart';
import 'package:sapiency_app/screen/profile/profile_screen_args.dart';
import 'package:sapiency_app/screen/wallet/wallet_page.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

class MainScreenView extends StatelessWidget {
  final MainScreenState state;

  const MainScreenView({required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: IndexedStack(
          key: ValueKey(state.tabIndex),
          index: state.tabIndex < 2 ? state.tabIndex : state.tabIndex - 1,
          children: [
            HomePage(),
            Center(
              child: Text('Search'),
            ),
            WalletPage(),
            ProfileScreen(),
          ],
        ),
      ),
      bottomNavigationBar: Stack(
        overflow: Overflow.visible,
        children: [
          Container(height: 50),
          _buildActionButtonBackgroundShadow(),
          _buildNavigationBar(context),
          _buildActionButton(context),
        ],
      ),
    );
  }

  Widget _buildActionButtonBackgroundShadow() {
    return Positioned(
      right: 0,
      left: 0,
      bottom: 0,
      child: Center(
        child: Material(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: SizedBox(
            width: 68,
            height: 68,
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationBar(BuildContext context) {
    return Builder(
      builder: (context) => BottomNavigationBar(
        currentIndex: state.tabIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        backgroundColor: Colors.white,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.accent,
        //TODO remove mock
        onTap: (index) {
          if (index == 0 || index == 3 || index == 4)
            state.onTabPressed(index);
          else
            SnackBars.showComingSoon(context);
        },
        items: _buildNavigationBarItems(context),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return Builder(
      builder: (context) {
        return Positioned(
          right: 0,
          left: 0,
          bottom: 0,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              padding: EdgeInsets.all(9),
              child: ActionButton(
                onTap: () => SnackBars.showComingSoon(context),
              ),
            ),
          ),
        );
      },
    );
  }

  List<BottomNavigationBarItem> _buildNavigationBarItems(BuildContext context) => [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppImages.homeIcon,
            color: _getColorForTab(0),
          ),
          label: context.strings.main.tab.home,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppImages.searchFullIcon,
            color: _getColorForTab(1),
          ),
          label: context.strings.main.tab.search,
        ),
        BottomNavigationBarItem(icon: Container(), label: ''),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppImages.walletIcon,
            color: _getColorForTab(3),
          ),
          label: context.strings.main.tab.wallet,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppImages.personIcon,
            color: _getColorForTab(4),
          ),
          label: context.strings.main.tab.profile,
        ),
      ];

  Color? _getColorForTab(int tabIndex) {
    if (tabIndex != state.tabIndex) {
      return AppColors.textParagraph;
    }

    if (tabIndex == 3) {
      return AppColors.accent;
    }

    return null;
  }
}

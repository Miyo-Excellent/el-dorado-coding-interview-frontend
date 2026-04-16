import 'package:flutter/material.dart';
import '../atoms/online_avatar.dart';
import '../atoms/verified_username.dart';
import '../atoms/rating_row.dart';

/// **MOLECULE — SellerInfo**
///
/// Compact row showing seller information. Composes:
/// - [OnlineAvatar] — avatar with presence indicator
/// - [VerifiedUsername] — username with optional golden check
/// - [RatingRow] — star rating + shield tier
///
/// Used inside the [OfferCard] organism.
///
/// ```dart
/// SellerInfo(
///   initials: 'G',
///   username: 'glo_cop_usdt',
///   rating: '5.0',
///   tier: 'Silver Tier',
///   isOnline: true,
///   isVerified: true,
/// )
/// ```
class SellerInfo extends StatelessWidget {
  const SellerInfo({
    super.key,
    required this.initials,
    required this.username,
    required this.rating,
    required this.tier,
    this.isOnline = true,
    this.isVerified = false,
  });

  final String initials;
  final String username;
  final String rating;
  final String tier;
  final bool isOnline;
  final bool isVerified;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // ATOM: avatar + online dot
        OnlineAvatar(initials: initials, isOnline: isOnline),
        const SizedBox(width: 12),
        // ATOMS: verified username + rating row
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VerifiedUsername(username: username, isVerified: isVerified),
              const SizedBox(height: 2),
              RatingRow(rating: rating, tier: tier),
            ],
          ),
        ),
      ],
    );
  }
}

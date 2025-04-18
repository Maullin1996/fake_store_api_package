import 'package:example/domain/models/user_entity.dart';
import 'package:flutter/material.dart';

import 'package:example/config/design/tokens.dart';

/// This file defines the `UserContainer` widget, which is used to display detailed
/// information about a user in a styled container.
class UserContainer extends StatelessWidget {
  /// The user information to display, provided as a `User` object.
  final User userInformation;

  /// The text theme used for styling the text elements in the widget.
  final TextTheme textTheme;

  const UserContainer({
    super.key,
    required this.userInformation,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.medium),
      padding: const EdgeInsets.all(AppSpacing.medium),
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            spreadRadius: 3,
            offset: const Offset(5, 5),
          ),
        ],
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppRadius.large),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // User icon
          Icon(
            Icons.person_pin_rounded,
            color: AppColors.primaryVariant,
            size: 40,
          ),
          SizedBox(height: AppSpacing.small),

          // User's full name
          Text(
            '${userInformation.name.firstname} ${userInformation.name.lastname}',
            style: textTheme.headlineLarge,
          ),
          SizedBox(height: AppSpacing.xlarge),

          // User details displayed in two columns
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left column: phone, email, username, and password
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.phone_iphone_outlined,
                        color: AppColors.primary,
                      ),
                      SizedBox(width: AppSpacing.xmedium),
                      Text(userInformation.phone, style: textTheme.bodyMedium),
                    ],
                  ),
                  SizedBox(height: AppSpacing.small),
                  Row(
                    children: [
                      Icon(Icons.email, color: AppColors.primary),
                      SizedBox(width: AppSpacing.xmedium),
                      Text(userInformation.email, style: textTheme.bodyMedium),
                    ],
                  ),
                  SizedBox(height: AppSpacing.small),
                  Row(
                    children: [
                      Icon(Icons.person, color: AppColors.primary),
                      SizedBox(width: AppSpacing.xmedium),
                      Text(
                        userInformation.username,
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.small),
                  Row(
                    children: [
                      Icon(Icons.password, color: AppColors.primary),
                      SizedBox(width: AppSpacing.xmedium),
                      Text(
                        userInformation.password,
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),

              // Right column: ID, city, street, and address number
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.numbers, color: AppColors.primary),
                      SizedBox(width: AppSpacing.xmedium),
                      Text(
                        userInformation.id.toString(),
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.small),
                  Row(
                    children: [
                      Icon(Icons.location_city, color: AppColors.primary),
                      SizedBox(width: AppSpacing.xmedium),
                      Text(
                        userInformation.address.city,
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.small),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: AppColors.primary),
                      SizedBox(width: AppSpacing.xmedium),
                      Text(
                        userInformation.address.street,
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.small),
                  Row(
                    children: [
                      Icon(Icons.directions, color: AppColors.primary),
                      SizedBox(width: AppSpacing.xmedium),
                      Text(
                        userInformation.address.number.toString(),
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

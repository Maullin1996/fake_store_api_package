/// This file defines a helper function for validating user input in forms.
/// Validates the input value provided by the user.
///
/// - [value]: The input value to validate.
String? validateInput(value) {
  if (value == null || value.isEmpty) {
    return 'Empty Field';
  }
  return null;
}

// ignore: file_names

String catchErrors(String errorCode) {
  String errorMessage = "Something went wrong";
  switch (errorCode) {
    case "wrong-password":
      errorMessage = "Incorrect Email or Password. Try Again.";
      break;
    case 'user-not-found':
      errorMessage = "User cannot be found,Try creating an account first";
      break;
    case 'invalid-email':
      errorMessage = "Incorrect Email or Password. Try Again.";
      break;
    case 'credential-already-in-use':
      errorMessage = "User already exists";
      break;
    case 'email-already-in-use':
      errorMessage = "User already exists";
      break;
    case 'too-many-requests':
      errorMessage = "Too many attempts. Try again later.";
      break;

    default:
  }
  return errorMessage;
}

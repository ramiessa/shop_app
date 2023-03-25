abstract class RegisrerStates {}

class RegisterInitialState extends RegisrerStates {}

class RegisterLoading extends RegisrerStates {}

class RegisterSeccess extends RegisrerStates {}

class RegisterError extends RegisrerStates {
  String? error;
  RegisterError(this.error);
}

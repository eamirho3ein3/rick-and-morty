import 'package:equatable/equatable.dart';

class Result<L, R> extends Equatable {
  L get left {
    if (this is Left<L, R>)
      return (this as Left<L, R>)._error;
    else
      throw Exception('Illegal use. That is not A Left Object.');
  }

  R get right {
    if (this is Right<L, R>)
      return (this as Right<L, R>)._value;
    else
      throw Exception('Illegal use. That is not A Right Object.');
  }

  R? getOrNull() {
    if (this is Right<L, R>)
      return (this as Right<L, R>)._value;
    else
      return null;
  }

  R getOrDefault(R value) {
    R? r = getOrNull();
    if (r != null) {
      return r;
    } else {
      return value;
    }
  }

  R getOrException() {
    R? r = getOrNull();
    if (r != null)
      return r;
    else
      throw new Exception("Illegal use. Right is Null.");
  }

  Result ifRight(onRight(R r)) {
    if (getOrNull() != null) onRight(right);
    return this;
  }

  Result ifLeft(onLeft(L l)) {
    if (getOrNull() != null) onLeft(left);
    return this;
  }

  R getOrElse(R onElse()) {
    if (getOrNull() != null) {
      return right;
    }
    return onElse();
  }

  void fold(ifRight(R r), ifLeft(L error)) {
    switch (this.runtimeType) {
      case Right:
        ifRight((this as Right<L, R>)._value);
        break;
      case Left:
        ifLeft((this as Left<L, R>)._error);
        break;
    }
  }

  @override
  List<Object> get props => [];
}

class Left<L, R> extends Result<L, R> {
  final L _error;

  Left(this._error);
}

class Right<L, R> extends Result<L, R> {
  final R _value;

  Right(this._value);
}

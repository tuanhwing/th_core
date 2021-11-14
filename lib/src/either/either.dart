
///Either to extract Left or Right
abstract class Either<L, R> {
  ///Constructor
  const Either();
}

///Left
class Left<L, R> extends Either<L, R> {
  ///Constructor
  const Left(this._l);

  final L _l;
  ///Get value
  L get value => _l;
}

///Right
class Right<L, R> extends Either<L, R> {
  ///Constructor
  const Right(this._r);

  final R _r;
  ///Get value
  R get value => _r;
}

///Left function
Either<L, R> left<L, R>(L l) => Left<L, R>(l);
///Right function
Either<L, R> right<L, R>(R r) => Right<L, R>(r);

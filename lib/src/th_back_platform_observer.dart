///abstract class used to building listen Android back physical event
abstract class THBackPlatformListener {
  ///Back physical pressed
  void onBackPlatform();
}

///Singleton [THBackPlatformObserver] class used to notify to all listeners
///about Android back physical event
class THBackPlatformObserver {
  final List<THBackPlatformListener> _listeners = <THBackPlatformListener>[];

  ///Add listener
  void addListener(THBackPlatformListener listener) => _listeners
      .add(listener);

  ///Remove listener
  void removeListener(THBackPlatformListener listener) => _listeners
      .remove(listener);

  ///Notify to last listener
  void notify() {
    if (_listeners.isEmpty) return;

    final THBackPlatformListener listener = _listeners.last;
    listener.onBackPlatform();
  }
}

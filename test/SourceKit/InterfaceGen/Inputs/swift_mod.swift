public class MyClass {
  public func pub_method() {}
  internal func int_method() {}
  fileprivate func fp_method() {}
  private func priv_method() {}
}

@discardableResult
public func pub_function() -> Int { return 0 }
internal func int_function() {}
fileprivate func fp_function() {}
private func priv_function() {}

public protocol MyProto<Assoc> {
  associatedtype Assoc
}

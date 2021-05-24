/**
 Usage
 ```
 let title = configure(UILabel()){
     $0.numberOfLines = 0
 }
 ```
 */
func configure<Type>(_ value: Type, block: (_ object: Type) -> Void) -> Type {
    block(value)
    return value
}

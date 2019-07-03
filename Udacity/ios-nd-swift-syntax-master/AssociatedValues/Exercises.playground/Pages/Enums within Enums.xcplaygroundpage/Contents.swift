//: [Previous](@previous)
//: ### Enums within Enums
//: - Callout(Exercise):
//: Define an enum called `SConfig` representing the different configurations for the 2017 Tesla Model S vehicle. Use a raw type (Double) to represent its starting price in USD. The following image contains the possible configurations:
//:
//: ![model-s](/modelS.png)
//:
enum SConfig{
    case price(Double)
    case type(type: String)
}
//: - Callout(Exercise):
//: Define an enum called `XConfig` representing the different configurations for the 2017 Tesla Model X vehicle. Use a raw type (Double) to represent its starting price in USD. The following image contains the possible configurations:
//:
//: ![model-s](/modelX.png)
//:
enum XConfig:Double{
    case seventyD = 79500
    case nintyD = 93500
    case hunderedD = 96000, hundredPD = 140000
}

enum ThreeType: Double {
    case standard = 35000, longRange = 44000
}
//: - Callout(Exercise):
//: Define an enum called `Tesla2017` representing Tesla's cars for 2017 — the Model S, Model X, and Model 3. Each case (car) should have an associated value for the different configuration or type for that model. Create a constant called `newCar` that is a Standard Tesla 2017 Model 3.
//:
enum Tesla2017{
    case ModelS(config:SConfig)
    case ModelX(config:XConfig)
    case Model3(config:ThreeType)
}

let newCar = Tesla2017.Model3(type: .standard)
//: - Callout(Exercise):
//: Use a switch statement to extract and print the starting the value for `newCar`. The switch statement should be able to handle any type of Tesla 2017 model.
//:
switch newCar{
case .ModelS(let config):
    print("ModelS \(config)")
case .ModelX(let config):
    print("ModelX")
case .Model3(let config):
    print("Model3")
}

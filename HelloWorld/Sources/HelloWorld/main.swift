if CommandLine.arguments.count != 2 {
    print("We need a name to greet!!")
} else {
    let name = CommandLine.arguments[1]
    sayHello(name: name)
    
    print("Your name reversed is: ")
    
    for c in name.reversed() {
        print(c)
    }
}

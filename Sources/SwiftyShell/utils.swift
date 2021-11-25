import Foundation

func swftsh_loop()
{
    var args: [String]
    var status: Bool
    var value = ProcessInfo.processInfo.environment["PS1"]
    //    value = "\\u@\\h:\\w\\$"
    //    print(value)
    
    print(ProcessInfo.processInfo.environment["PS1"])
    
    repeat {
        print("\(value ?? Host.current().localizedName ?? "") > ", terminator: "")
        guard let line = readLine() else { return }
        args = swftsh_split_line(line: line)
        status = swftsh_execute(args: args)
    } while (status);
}

func swftsh_read_line() -> String {
    return AnyIterator {
        readLine()
    }
    .filter { line in
        return line.count > 0
    }
    .joined()
}

func swftsh_split_line(line: String) -> [String] {
    var tokens: [String]
    //var token: String
    
    // Dependent on Foundation
    tokens = line.components(separatedBy: .whitespaces).filter { tok in !tok.isEmpty }
    return tokens
}

func swftsh_launch(args: [String]) -> Bool {
    let task = Process()
    task.launchPath = "/usr/bin/env"
    task.arguments = args
    task.launch()
    task.waitUntilExit()
    return task.terminationStatus == 0
}

func swftsh_execute(args: [String]) -> Bool {
    guard args.count > 0 else { return true }
    for (index, swftsh_builtin) in builtin_str.enumerated() {
        if swftsh_builtin == args[0] {
            return builtin_func[index](args)
        }
    }
    return swftsh_launch(args: args)
}

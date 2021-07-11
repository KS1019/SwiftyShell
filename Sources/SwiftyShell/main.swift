import Foundation

var builtin_str: [String] = ["cd", "help", "exit"]

var swftsh_num_builtins: Int {
    return builtin_str.count
}

var builtin_func: [(([String]) -> Bool)] {
    return [
        swftsh_cd,
        swftsh_help,
        swftsh_exit
    ]
}

func main() {
    // Load config files, if any.
    
    // Run command loop.
    swftsh_loop();
    
    // Perform any shutdown/cleanup.
    print("Shutting down")
    exit(EXIT_SUCCESS)
}

func swftsh_loop()
{
    var args: [String]
    var status: Bool
    
    repeat {
        print("\(Host.current().localizedName ?? "") > ", terminator: "")
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
    
    
    
    return true
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

func swftsh_cd(_ args: [String]) -> Bool {
    if args.count == 1 {
        fputs("SwiftyShell: expected argument to \"cd\"\n", stderr)
    } else {
        if !FileManager().changeCurrentDirectoryPath(args[1]) {
            perror("Error on changeCurrentDirectoryPath")
        }
    }
    
    return true
}

func swftsh_help(_ args: [String]) -> Bool {
    print("This is SwiftyShell's help")
    print("Currently displaying help message\n")
    
    print("SwiftyShell has these builtin commands")
    
    for command in builtin_str {
        print("  \(command)")
    }
    return true
}

func swftsh_exit(_ args: [String]) -> Bool {
    return false
}


main()

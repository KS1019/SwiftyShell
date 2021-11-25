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

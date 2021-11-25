import Foundation

func main() {
    // Load config files, if any.
    
    // Run command loop.
    swftsh_loop();
    
    // Perform any shutdown/cleanup.
    print("Shutting down")
    exit(EXIT_SUCCESS)
}

main()

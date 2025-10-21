/*
* Minigrep in Rust (functional style)
* */

fn main() {
    // Get args
    let args: Vec<String> = std::env::args().collect();
    if args.len() != 3 {
        println!("Usage: minigrep <query> <filename>");
        std::process::exit(1);
    }
    let query = &args[1];
    let filename = &args[2];

    // Get file contents
    let contents = std::fs::read_to_string(filename).expect("Something went wrong reading the file");
    let lines = contents.lines();

    // Get matches
    let matches: Vec<(usize, &str)> = contents.lines().into_iter().enumerate().filter(|(i, line)| line.contains(query)).collect();

    // print matches
    match matches.len() {
        0 => println!("No matches found for '{}' in {}", query, filename),
        _ => matches.into_iter().for_each(|(i, line)| println!("{}: {}", i + 1, line)),
    }
}

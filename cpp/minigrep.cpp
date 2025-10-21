/*
 * Minigrep in C++
 * Example: minigrep-cpp <pattern> <file>
 */

#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <regex>

using namespace std;

int main(int argc, char *argv[]) {
    if (argc < 3) {
        cout << "Usage: minigrep-cpp <pattern> <file>" << endl;
        return 1;
    }

    string pattern = argv[1];
    string filename = argv[2];

    ifstream file(filename);
    string line;
    int count = 0;
    bool found = false;
    regex reg(pattern);
    
    while (getline(file, line)) {
        if (regex_search(line, reg)) {
            cout << count << ": " << line << endl;
            found = true;
        }
        count++;
    }

    if (!found) {
        cout << "No matches found." << endl;
    }

    return 0;
}

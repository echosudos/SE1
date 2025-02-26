#include <iostream>
#include <string>
#include <cstdlib>    // for abs() if needed
#include <chrono>     // for timing
#include <random>     // for random number generation

using namespace std;
using namespace std::chrono;

// Function implementing your logic: calculates the total number of turns
int computeTurns(int N, const string &current, const string &target) {
    int output = 0;   // output register
    int counter = 0;  // counter register

    // Loop through the combinations
    while (counter < N) {
        // Get the digits from current and target strings
        int A = current[counter] - '0';
        int B = target[counter] - '0';
        
        // Compute difference and then take its absolute value.
        int C = A - B;
        if (C < 0) {
            C = -C;
        }

        // Compute D = 10 - C
        int D = 10 - C;
        
        // If C > D, add D to output; otherwise, add C
        if (C > D) {
            output += D;
        } else {
            output += C;
        }
        
        counter++;
    }
    
    return output;
}

int main() {
    // Number of test cases to run
    const int numTestCases = 1000;
    
    // Create a random number generator
    random_device rd;
    mt19937 gen(rd());
    // Generate N as a random number between 1 and 20 (number of digits)
    uniform_int_distribution<> distN(1, 20);
    // Generate each digit between 0 and 9
    uniform_int_distribution<> distDigit(0, 9);

    // Start timing
    auto start = high_resolution_clock::now();
    
    // Run 1000 test cases
    for (int i = 0; i < numTestCases; i++) {
        // Randomly determine the length N for this test case
        int N = distN(gen);
        string current, target;
        current.reserve(N);
        target.reserve(N);
        
        // Generate random combinations of digits for current and target strings
        for (int j = 0; j < N; j++) {
            char d1 = '0' + distDigit(gen);
            char d2 = '0' + distDigit(gen);
            current.push_back(d1);
            target.push_back(d2);
        }
        
        // Compute the number of turns for this test case
        int turns = computeTurns(N, current, target);
        
        // (Optional) Uncomment the following line to print each test case's details:
        // cout << "Test " << i+1 << ": N=" << N << ", current=" << current << ", target=" << target << ", turns=" << turns << endl;
    }
    
    // End timing
    auto end = high_resolution_clock::now();
    auto duration = duration_cast<microseconds>(end - start).count();
    
    cout << "Total runtime for " << numTestCases << " test cases: " << duration << " microseconds" << endl;
    
    return 0;
}
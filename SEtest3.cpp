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
    // Number of test cases to run for each section
    const int numTestCases = 1000;
    
    // Create a random number generator
    random_device rd;
    mt19937 gen(rd());
    // Distribution for random N between 1 and 20 (number of digits)
    uniform_int_distribution<> distN(1, 20);
    // Distribution for each digit between 0 and 9
    uniform_int_distribution<> distDigit(0, 9);
    
    // ***** Test 1: Fixed N for all test cases *****
    int fixed_N = 10;  // Fixed value of N (change as desired)
    
    auto start_fixed = high_resolution_clock::now();
    for (int i = 0; i < numTestCases; i++) {
        string current, target;
        current.reserve(fixed_N);
        target.reserve(fixed_N);
        
        // Generate random combinations with fixed_N digits
        for (int j = 0; j < fixed_N; j++) {
            char d1 = '0' + distDigit(gen);
            char d2 = '0' + distDigit(gen);
            current.push_back(d1);
            target.push_back(d2);
        }
        
        // Compute the number of turns for this test case
        int turns = computeTurns(fixed_N, current, target);
        // (Optional) Uncomment to print each test case:
        // cout << "Fixed Test " << i+1 << ": N=" << fixed_N << ", current=" << current << ", target=" << target << ", turns=" << turns << endl;
    }
    auto end_fixed = high_resolution_clock::now();
    auto duration_fixed = duration_cast<microseconds>(end_fixed - start_fixed).count();
    
    cout << "Total runtime for " << numTestCases << " fixed N test cases (N=" << fixed_N << "): " 
         << duration_fixed << " microseconds" << endl;
    
    // ***** Test 2: Random N for each test case *****
    auto start_random = high_resolution_clock::now();
    for (int i = 0; i < numTestCases; i++) {
        // Randomly determine the length N for this test case
        int random_N = distN(gen);
        string current, target;
        current.reserve(random_N);
        target.reserve(random_N);
        
        // Generate random combinations with random_N digits
        for (int j = 0; j < random_N; j++) {
            char d1 = '0' + distDigit(gen);
            char d2 = '0' + distDigit(gen);
            current.push_back(d1);
            target.push_back(d2);
        }
        
        // Compute the number of turns for this test case
        int turns = computeTurns(random_N, current, target);
        // (Optional) Uncomment to print each test case:
        // cout << "Random Test " << i+1 << ": N=" << random_N << ", current=" << current << ", target=" << target << ", turns=" << turns << endl;
    }
    auto end_random = high_resolution_clock::now();
    auto duration_random = duration_cast<microseconds>(end_random - start_random).count();
    
    cout << "Total runtime for " << numTestCases << " random N test cases: " 
         << duration_random << " microseconds" << endl;
    
    return 0;
}
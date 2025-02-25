#include <iostream>
#include <string>
#include <cstdlib>
#include <chrono>
#include <random>

using namespace std;
using namespace std::chrono;

// Function implementing your logic: calculates the total number of turns
// (DO NOT modify this function under any circumstances)
int computeTurns(int N, const string &current, const string &target) {
    int output = 0;   // output register
    int counter = 0;  // counter register

    // Loop through the combinations
    while (counter < N) {
        int A = current[counter] - '0';
        int B = target[counter] - '0';
        int C = A - B;
        if (C < 0) {
            C = -C;
        }
        int D = 10 - C;
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
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    // Number of test cases per set and the number of repetitions (pairs)
    const int numTestCases = 1000;
    const int numTestPairs = 1000;

    // Set up random number generators
    random_device rd;
    mt19937 gen(rd());
    // Distribution for random N: values between 0 and 100 (inclusive)
    uniform_int_distribution<> distN(0, 100);
    // Distribution for each digit: values between 0 and 9
    uniform_int_distribution<> distDigit(0, 9);
    
    // Variables to accumulate total durations (in microseconds)
    long long total_duration_fixed = 0;
    long long total_duration_random = 0;
    
    // Count the total number of function calls
    long long totalFixedCalls = 0;
    long long totalRandomCalls = 0;
    
    // Outer loop: run the pair of tests numTestPairs times
    for (int pair = 0; pair < numTestPairs; pair++) {
        // ***** Test 1: Fixed N test cases *****
        int fixed_N = 10;  // fixed value of N; must be within 0 to 100
        auto start_fixed = high_resolution_clock::now();
        for (int i = 0; i < numTestCases; i++) {
            // Preallocate strings of fixed size
            string current(fixed_N, '0');
            string target(fixed_N, '0');
            for (int j = 0; j < fixed_N; j++) {
                current[j] = '0' + distDigit(gen);
                target[j] = '0' + distDigit(gen);
            }
            int turns = computeTurns(fixed_N, current, target);
            (void)turns; // suppress unused variable warning
        }
        auto end_fixed = high_resolution_clock::now();
        auto duration_fixed = duration_cast<microseconds>(end_fixed - start_fixed).count();
        total_duration_fixed += duration_fixed;
        totalFixedCalls += numTestCases;
        
        // ***** Test 2: Random N test cases *****
        auto start_random = high_resolution_clock::now();
        for (int i = 0; i < numTestCases; i++) {
            int random_N = distN(gen);  // random N between 0 and 100
            string current(random_N, '0');
            string target(random_N, '0');
            for (int j = 0; j < random_N; j++) {
                current[j] = '0' + distDigit(gen);
                target[j] = '0' + distDigit(gen);
            }
            int turns = computeTurns(random_N, current, target);
            (void)turns;
        }
        auto end_random = high_resolution_clock::now();
        auto duration_random = duration_cast<microseconds>(end_random - start_random).count();
        total_duration_random += duration_random;
        totalRandomCalls += numTestCases;
    }
    
    // Calculate average runtime per 1000-test-case set (across numTestPairs runs)
    double avg_runtime_fixed = static_cast<double>(total_duration_fixed) / numTestPairs;
    double avg_runtime_random = static_cast<double>(total_duration_random) / numTestPairs;
    
    // Calculate average runtime per individual algorithm call
    double avg_call_fixed = static_cast<double>(total_duration_fixed) / totalFixedCalls;
    double avg_call_random = static_cast<double>(total_duration_random) / totalRandomCalls;
    
    cout << "Average runtime for 1000 fixed N test cases: " 
         << avg_runtime_fixed << " microseconds" << endl;
    cout << "Average runtime for 1000 random N test cases: " 
         << avg_runtime_random << " microseconds" << endl;
    cout << "Average runtime per fixed N algorithm call: " 
         << avg_call_fixed << " microseconds" << endl;
    cout << "Average runtime per random N algorithm call: " 
         << avg_call_random << " microseconds" << endl;
    
    return 0;
}
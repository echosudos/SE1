#include <iostream>
#include <string>
#include <cstdlib>  // for abs()

using namespace std;

int main() {
    // 1. Accept input N, current combination and target combination.
    int N;
    string current, target;
    
    cout << "Enter N: ";
    cin >> N;
    
    cout << "Enter current combination: ";
    cin >> current;
    
    cout << "Enter target combination: ";
    cin >> target;
    
    // 3. Save previous state (in high-level languages this is not required,
    // but we note it as part of the logic description).
    
    // 4. Initialize output, counter and computation registers to 0.
    int output = 0;     // output register
    int counter = 0;    // counter register
    
    // 5. Set pointers to the beginning of the arrays.
    // Here, we use array indices to simulate pointer behavior.
    
    // 6. Loop start (while counter < N)
    while (counter < N) {
        // 7. Pointer 1 and pointer 2 now point to current[counter] and target[counter]
        // 8. Store the values into registers A and B.
        int A = current[counter] - '0';  // converting char to integer
        int B = target[counter] - '0';
        
        // 9. Compute absolute difference.
        // If A > B, then C = A - B; otherwise, C = B - A.
        int C = (A > B) ? (A - B) : (B - A);
        // Remove the conditional block below. Just get absolute value of A - B. We only have 1 comparison now
        
        // 10. Register D = 10 - C.
        int D = 10 - C;
        
        // 11. If C > D then add D to output, otherwise add C.
        output += (C > D) ? D : C;
        
        // 12. Increment pointers (by moving to the next index).
        // 13. counter += 1.
        counter++;
    }
    
    // 15. Recover previous state (not applicable in C++ as it is handled automatically).
    
    // 16. Output the number of turns.
    cout << "Number of turns: " << output << endl;
    
    return 0;
}

#include <iostream>
#include <string>
#include <cstdlib>  // for abs()

using namespace std;

int main() {
    // Accept input N, current combination and target combination.
    int N;
    string current, target;
    
    cout << "Enter N: ";
    cin >> N;
    
    cout << "Enter current combination: ";
    cin >> current;
    
    cout << "Enter target combination: ";
    cin >> target;
    
    // Create counter and output variables
    int output = 0;   
    int counter = 0;    
    
    // Go thru each pair of numbers until we have gone thru all of em
    while (counter < N) {
        int A = current[counter] - '0';  
        int B = target[counter] - '0';
        
        // Compute absolute difference of one side
        int C = (A > B) ? (A - B) : (B - A);
        
        // Compute for the other side
        int D = 10 - C;
        
        // Find the min. number to be put into the output
        output += (C > D) ? D : C;
        
        // Increment Counter
        counter++;
    }
    
    
    // Output the number of turns.
    cout << "Number of turns: " << output << endl;
    
    return 0;
}


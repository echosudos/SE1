.file	"SE.cpp"  
    # Indicates the original source file name ("SE.cpp").

	.text  
    # Marks the beginning of the code section.

#APP
	.globl _ZSt21ios_base_library_initv  
    # Declares a global symbol for the library initialization function 
    # (this is part of the C++ standard library initialization).

	.section	.rodata  
    # Switches to the read-only data section where constant data is stored.

.LC0:
	.string	"Enter N: "  
    # Defines a constant string "Enter N: " to prompt the user for a number.

.LC1:
	.string	"Enter current combination: "  
    # Defines a constant string prompting for the current combination.

.LC2:
	.string	"Enter target combination: "  
    # Defines a constant string prompting for the target combination.

.LC3:
	.string	"Number of turns: "  
    # Defines a constant string used when displaying the result.

#NO_APP
	.text  
    # Returns to the code section for the function definitions.

	.globl	main  
    # Declares the main function as globally accessible.

	.type	main, @function  
    # Tells the linker that 'main' is a function.

main:
.LFB2002:
	.cfi_startproc  
    # Begin call frame information (used for debugging and stack unwinding).

	// --- Function Prologue ---
	pushq	%rbp                
    # Save the old base pointer (rbp) on the stack.
	.cfi_def_cfa_offset 16  
	.cfi_offset 6, -16       
	movq	%rsp, %rbp         
    # Set the base pointer to the current stack pointer to create a new stack frame.
	.cfi_def_cfa_register 6  
	pushq	%rbx                
    # Save the %rbx register (a callee-saved register) onto the stack.
	subq	$104, %rsp          
    # Allocate 104 bytes on the stack for local variables.
	.cfi_offset 3, -24        

	// --- Construct std::string for "current combination" ---
	leaq	-80(%rbp), %rax    
    # Compute the address (rbp-80) where the first std::string object will be stored.
	movq	%rax, %rdi         
    # Move that address into %rdi; this is the first parameter (the 'this' pointer) for the constructor.
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1Ev@PLT  
    # Call the default constructor of std::string to initialize the object at rbp-80.

	// --- Construct std::string for "target combination" ---
	leaq	-112(%rbp), %rax   
    # Compute the address (rbp-112) where the second std::string object will be stored.
	movq	%rax, %rdi         
    # Move that address into %rdi as the argument for the constructor.
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1Ev@PLT  
    # Call the default constructor of std::string for the target combination.

	// --- Prompt: "Enter N: " ---
	leaq	.LC0(%rip), %rax    
    # Load the address of the "Enter N: " string (LC0) into %rax.
	movq	%rax, %rsi         
    # Move the string address into %rsi (the second argument for the output operator).
	leaq	_ZSt4cout(%rip), %rax  
    # Load the address of std::cout into %rax.
	movq	%rax, %rdi         
    # Move the cout address into %rdi (the first argument for the output operator).
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT  
    # Call the overloaded operator<< to output the prompt to the console.

	// --- Read integer N from input ---
	leaq	-44(%rbp), %rax    
    # Compute the address (rbp-44) where the input integer (N) will be stored.
	movq	%rax, %rsi         
    # Place this address in %rsi (argument for operator>>).
	leaq	_ZSt3cin(%rip), %rax  
    # Load the address of std::cin into %rax.
	movq	%rax, %rdi         
    # Place cin’s address into %rdi (first argument for operator>>).
	call	_ZNSirsERi@PLT      
    # Call the overloaded operator>> to read an integer from input.

	// --- Prompt: "Enter current combination: " ---
	leaq	.LC1(%rip), %rax    
    # Load the address of the "Enter current combination: " string into %rax.
	movq	%rax, %rsi         
    # Move that address into %rsi.
	leaq	_ZSt4cout(%rip), %rax  
    # Load the address of std::cout.
	movq	%rax, %rdi         
    # Move cout’s address into %rdi.
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT  
    # Output the prompt to the console.

	// --- Read the current combination string ---
	leaq	-80(%rbp), %rax    
    # Load the address of the first std::string (current combination) into %rax.
	movq	%rax, %rsi         
    # Move that address into %rsi.
	leaq	_ZSt3cin(%rip), %rax  
    # Load the address of std::cin.
	movq	%rax, %rdi         
    # Move cin’s address into %rdi.
	call	_ZStrsIcSt11char_traitsIcESaIcEERSt13basic_istreamIT_T0_ES7_RNSt7__cxx1112basic_stringIS4_S5_T1_EE@PLT  
    # Call the input operator >> for std::string to read the current combination.

	// --- Prompt: "Enter target combination: " ---
	leaq	.LC2(%rip), %rax    
    # Load the address of the "Enter target combination: " string into %rax.
	movq	%rax, %rsi         
    # Move that address into %rsi.
	leaq	_ZSt4cout(%rip), %rax  
    # Load the address of std::cout.
	movq	%rax, %rdi         
    # Move cout’s address into %rdi.
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT  
    # Output the prompt to the console.

	// --- Read the target combination string ---
	leaq	-112(%rbp), %rax   
    # Load the address of the second std::string (target combination) into %rax.
	movq	%rax, %rsi         
    # Move that address into %rsi.
	leaq	_ZSt3cin(%rip), %rax  
    # Load the address of std::cin.
	movq	%rax, %rdi         
    # Move cin’s address into %rdi.
	call	_ZStrsIcSt11char_traitsIcESaIcEERSt13basic_istreamIT_T0_ES7_RNSt7__cxx1112basic_stringIS4_S5_T1_EE@PLT  
    # Call the input operator >> for std::string to read the target combination.

	// --- Initialize loop variables ---
	movl	$0, -20(%rbp)       
    # Set a local variable at rbp-20 to 0; this will hold the total number of turns.
	movl	$0, -24(%rbp)       
    # Set a local loop index variable at rbp-24 to 0.
	jmp	.L2                 
    # Jump to the loop check to start processing each digit.

	// --- Loop: Process each digit of the combination ---
.L7:
	// Get the current index into the combination strings.
	movl	-24(%rbp), %eax    
    # Load the current loop index (from rbp-24) into eax.
	movslq	%eax, %rdx       
    # Sign-extend the 32-bit index in eax to 64 bits in rdx.
	leaq	-80(%rbp), %rax    
    # Load the address of the current combination string (stored at rbp-80) into rax.
	movq	%rdx, %rsi        
    # Place the loop index (in rdx) into rsi for the string’s operator[] call.
	movq	%rax, %rdi        
    # Place the address of the string into rdi (the 'this' pointer).
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEixEm@PLT  
    # Call std::string::operator[] to get a pointer to the character at the current index.
	
	// Convert the ASCII character to its integer value.
	movzbl	(%rax), %eax    
    # Load the byte (character) from the returned pointer and zero-extend it into eax.
	movsbl	%al, %eax       
    # Sign-extend the byte in al to a full 32-bit integer in eax.
	subl	$48, %eax        
    # Subtract 48 (ASCII code for '0') from the value to convert from ASCII digit to integer.
	movl	%eax, -28(%rbp)  
    # Store the current combination digit (as an integer) at rbp-28.

	// --- Process the target combination digit similarly ---
	movl	-24(%rbp), %eax    
    # Load the loop index again into eax.
	movslq	%eax, %rdx       
    # Sign-extend it to 64 bits in rdx.
	leaq	-112(%rbp), %rax   
    # Load the address of the target combination string (stored at rbp-112) into rax.
	movq	%rdx, %rsi        
    # Pass the loop index in rsi.
	movq	%rax, %rdi        
    # Pass the target string address in rdi.
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEixEm@PLT  
    # Call the operator[] to get a pointer to the target character.
	movzbl	(%rax), %eax    
    # Load the target character and zero-extend it into eax.
	movsbl	%al, %eax       
    # Sign-extend the byte to a full integer.
	subl	$48, %eax        
    # Convert ASCII digit to integer by subtracting 48.
	movl	%eax, -32(%rbp)  
    # Store the target combination digit at rbp-32.

	// --- Compute the absolute difference between the two digits ---
	movl	-28(%rbp), %eax   
    # Load the current combination digit into eax.
	cmpl	-32(%rbp), %eax   
    # Compare it with the target digit.
	jle	.L3               
    # If the current digit is less than or equal to the target digit, jump to label .L3.
	
	// If current digit > target digit, compute (current - target)
	movl	-28(%rbp), %eax   
    # Reload the current digit.
	subl	-32(%rbp), %eax   
    # Subtract the target digit; now eax holds (current - target).
	jmp	.L4              
    # Jump to label .L4 to continue.
.L3:
	// Else, compute (target - current)
	movl	-32(%rbp), %eax   
    # Load the target digit.
	subl	-28(%rbp), %eax   
    # Subtract the current digit; eax now holds (target - current).
.L4:
	movl	%eax, -36(%rbp)  
    # Store the absolute difference between the digits at rbp-36.

	// --- Calculate the "wrap-around" difference on a circular dial ---
	movl	$10, %eax         
    # Load the constant 10 into eax (a dial has 10 digits: 0-9).
	subl	-36(%rbp), %eax   
    # Subtract the absolute difference from 10 to get the wrap-around turns.
	movl	%eax, -40(%rbp)  
    # Store this alternative turn count at rbp-40.

	// --- Choose the smaller number of turns (direct vs. wrap-around) ---
	movl	-36(%rbp), %eax   
    # Load the direct difference into eax.
	cmpl	-40(%rbp), %eax   
    # Compare it with the wrap-around difference.
	jle	.L5              
    # If the direct difference is less than or equal to the wrap-around, jump to .L5.
	
	// Use the wrap-around difference if it is smaller.
	movl	-40(%rbp), %eax   
    # Load the wrap-around difference into eax.
	jmp	.L6              
    # Jump to label .L6.
.L5:
	movl	-36(%rbp), %eax   
    # Otherwise, keep the direct difference in eax.
.L6:
	addl	%eax, -20(%rbp)  
    # Add the chosen minimum turn count to the running total stored at rbp-20.
	addl	$1, -24(%rbp)   
    # Increment the loop index (move to the next digit).

	// --- Loop Check: Have we processed all digits? ---
.L2:
	movl	-44(%rbp), %eax   
    # Load the total number of digits (N) into eax (this was read earlier into rbp-44).
	cmpl	%eax, -24(%rbp)   
    # Compare the current loop index (rbp-24) with N.
	jl	.L7              
    # If the loop index is less than N, jump back to label .L7 to process the next digit.

	// --- Output the Result ---
	leaq	.LC3(%rip), %rax   
    # Load the address of the "Number of turns: " prompt into rax.
	movq	%rax, %rsi        
    # Move the prompt address into rsi.
	leaq	_ZSt4cout(%rip), %rax  
    # Load the address of std::cout into rax.
	movq	%rax, %rdi        
    # Move cout’s address into rdi.
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT  
    # Output the "Number of turns: " prompt.

	movq	%rax, %rdx        
    # Save the current state of cout in rdx for chaining output.
	movl	-20(%rbp), %eax   
    # Load the total number of turns (calculated over the loop) into eax.
	movl	%eax, %esi        
    # Move the turn count into esi (argument for outputting an integer).
	movq	%rdx, %rdi        
    # Restore cout’s address into rdi.
	call	_ZNSolsEi@PLT      
    # Call the operator<< to output the total number of turns.

	// --- Output End-of-Line ---
	movq	_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_@GOTPCREL(%rip), %rdx  
    # Load the address of std::endl into rdx.
	movq	%rdx, %rsi        
    # Move std::endl into rsi.
	movq	%rax, %rdi        
    # Move cout’s address into rdi.
	call	_ZNSolsEPFRSoS_E@PLT  
    # Call the operator<< to output std::endl (which ends the line and flushes output).

	// --- Function Epilogue and Cleanup ---
	movl	$0, %ebx          
    # Set the return value to 0 (success).
	leaq	-112(%rbp), %rax   
    # Load the address of the target combination string (rbp-112) for cleanup.
	movq	%rax, %rdi        
    # Move that address into rdi as an argument.
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev@PLT  
    # Call the destructor for the target combination std::string.
	leaq	-80(%rbp), %rax    
    # Load the address of the current combination string (rbp-80) for cleanup.
	movq	%rax, %rdi        
    # Move that address into rdi.
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev@PLT  
    # Call the destructor for the current combination std::string.
	movl	%ebx, %eax        
    # Move the return value (0) into eax (the standard register for function return values).
	movq	-8(%rbp), %rbx    
    # Restore the saved %rbx register from the stack.
	leave                  
    # Clean up the stack frame (restore the base pointer and stack pointer).
	.cfi_def_cfa 7, 8       
	ret                    
    # Return from the main function.
	.cfi_endproc           
.LFE2002:
	.size	main, .-main    
    # Specify the size of the main function.

	// --- Additional Data Objects ---
	.section	.rodata  
    # Begin another section of read-only data.

	.type	_ZNSt8__detail30__integer_to_chars_is_unsignedIjEE, @object  
	.size	_ZNSt8__detail30__integer_to_chars_is_unsignedIjEE, 1  
_ZNSt8__detail30__integer_to_chars_is_unsignedIjEE:
	.byte	1  
    # This object is used internally by the C++ library for integer-to-string conversion.

	.type	_ZNSt8__detail30__integer_to_chars_is_unsignedImEE, @object  
	.size	_ZNSt8__detail30__integer_to_chars_is_unsignedImEE, 1  
_ZNSt8__detail30__integer_to_chars_is_unsignedImEE:
	.byte	1  
    # Another helper object for converting unsigned long integers.

	.type	_ZNSt8__detail30__integer_to_chars_is_unsignedIyEE, @object  
	.size	_ZNSt8__detail30__integer_to_chars_is_unsignedIyEE, 1  
_ZNSt8__detail30__integer_to_chars_is_unsignedIyEE:
	.byte	1  
    # And one for converting unsigned long long integers.

	.ident	"GCC: (GNU) 14.2.1 20250207"  
    # Embeds the compiler identification string.

	.section	.note.GNU-stack,"",@progbits  
    # Marker to indicate that the stack is not executable (a security feature).
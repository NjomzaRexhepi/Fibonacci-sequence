
.data
prompt: .ascii "\nFibonacci Example \n"
.asciiz "Enter x value: "
print_fib_result: .asciiz "Fibonacci number for "
result_is: .asciiz " is "
.text
main:
#print prompt
la $a0,prompt   
li $v0,4
syscall

#read the number x
li $v0,5   
syscall

#move x from v0 to t1
move $t1,$v0    

#fibonnacci function to get x
move $a0,$t1
move $v0,$t1
jal fibonacci_function 


#move x to t2    
move $t2,$v0   

#print
la $a0,print_fib_result   
li $v0,4
syscall

#print x
move $a0,$t1    
li $v0,1
syscall

#result is
la $a0,result_is  
li $v0,4
syscall

#answer
move $a0,$t2   
li $v0,1
syscall

#exit
li $v0,10
syscall

#fib function label
fibonacci_function:

#if x==0 or x==1 go to if
beq $a0,1,If   
beq $a0,0,If   


#if x!=0 or x!=1 do the code below

# $ra stack 
sub $sp,$sp,4   #adjust stack for 1 item
sw $ra,0($sp) #save return address


#fibonnacci(x-1)
sub $a0,$a0,1  #x-1
jal fibonacci_function   #fib(x-1)
add $a0,$a0,1

#restoring $ra
lw $ra,0($sp) #restore value of $s0   
add $sp,$sp,4#restore the stack pointer 

#Push return value to stack
sub $sp,$sp,4   
sw $v0,0($sp)


sub $sp,$sp,4   
sw $ra,0($sp)  #push $ra on the stack

#fib(x-2)
sub $a0,$a0,2  
jal fibonacci_function    
add $a0,$a0,2

#restoring $ra 
#to pop the top of the stack 
lw $ra,0($sp)   #read $ra from the stack
add $sp,$sp,4 #restore stack pointer,pop 1 item from stack

#restore x from stack 
lw $s0,0($sp)   
add $sp,$sp,4#pop 1 item from stack

#final f(x-1)+f(x-2)
add $v0,$v0,$s0
jr $ra 

.end fibonacci_function

#return x if x==0 or x==1
If:
move $v0, $a0
 jr $ra
.end If



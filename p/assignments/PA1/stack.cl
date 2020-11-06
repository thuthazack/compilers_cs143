(*
 *  CS164 Fall 94
 *
 *  Programming Assignment 1
 *    Implementation of a simple stack machine.
 *	question 1 when do we actually put semi colon? ||| question 2 how do we actually evaluate or write the expression in if statements?
 *  Skeleton file
 * Cons is basically list which can be used like  astack/ but the problem is that the data typees are different
 *)

class StackCommand{

	push(stack: List, char: String): List{
		if char = "e" then evaluate(stack); else
		if char = "x" then {abort();0;};   else
		{stack.cons(char)};
		fi fi

	};
	addition(stack: List) : List{
		num1 <- stack.head();
		stack <- stack.tail();
		num2 <- stack.head();
		stack <- stack.tail();
		stack.cons(num1+num2);
	};
	s (stack: List): List{
		top_element <- stack.head();
		stack <- stack.tail();
		second_element <- stack.head();
		stack <- stack.tail();
		
		stack.cons(top_element).cons(second_element);
	};

	evaluate (stack : List):List{
		top_element <-stack.head();
		stack <-stack.tail();
		if top_element = "+" then addition(stack); else
		if top_element = "d" then display(stack);  else
		if top_element = "s" then s(stack);	   else
		{stack};
	};

};


class Main inherits IO {

   main() : Object {
      out_string("Nothing implemented\n")
   };

};

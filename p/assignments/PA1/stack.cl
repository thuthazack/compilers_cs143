(*
 *  CS164 Fall 94
 *
 *  Programming Assignment 1
 *    Implementation of a simple stack machine.
 *	question 1 when do we actually put semi colon? ||| question 2 how do we actually evaluate or write the expression in if statements?
 *  Skeleton file
 * Cons is basically list which can be used like  astack/ but the problem is that the data typees are different
 *)

class List {
   -- Define operations on empty lists.

   isNil() : Bool { true };

   -- Since abort() has return type Object and head() has return type
   -- Int, we need to have an Int as the result of the method body,
   -- even though abort() never returns.

   head()  : String { { abort(); ""; } };

   -- As for head(), the self is just to make sure the return type of
   -- tail() is correct.

   tail()  : List { { abort(); self; } };

   -- When we cons and element onto the empty list we get a non-empty
   -- list. The (new Cons) expression creates a new list cell of class
   -- Cons, which is initialized by a dispatch to init().
   -- The result of init() is an element of class Cons, but it
   -- conforms to the return type List, because Cons is a subclass of
   -- List.

   cons(i : String) : List {
      (new Cons).init(i, self)
   };

};


(*
 *  Cons inherits all operations from List. We can reuse only the cons
 *  method though, because adding an element to the front of an emtpy
 *  list is the same as adding it to the front of a non empty
 *  list. All other methods have to be redefined, since the behaviour
 *  for them is different from the empty list.
 *
 *  Cons needs two attributes to hold the integer of this list
 *  cell and to hold the rest of the list.
 *
 *  The init() method is used by the cons() method to initialize the
 *  cell.
 *)

class Cons inherits List {

   car : String;	-- The element in this list cell

   cdr : List;	-- The rest of the list

   isNil() : Bool { false };

   head()  : String { car };

   tail()  : List { cdr };

   init(i : String, rest : List) : List {
      {
	 car <- i;
	 cdr <- rest;
	 self;
      }
   };

};



class StackCommand {
	s (stack: List): List{
		let top_element: String, second_element: String in {
			top_element <- stack.head();
			stack <- stack.tail();
			second_element <- stack.head();
			stack <- stack.tail();
			
			stack.cons(top_element).cons(second_element);
		}
	};



	addition(stack:  List): List {
			let num1 : Int, num2: Int, z: A2I <- new A2I in {
				num1 <- z.a2i(stack.head());
				stack <- stack.tail();
				num2 <- z.a2i(stack.head());
				stack <- stack.tail();
				stack.cons(z.i2a(num1+num2));
			}
	};
	print_list(l : List) : Object {
      		(let io: IO <- (new IO) in 
			if l.isNil() then io.out_string("\n")
		        else {
				   io.out_string(l.head());
				   io.out_string("\n");
				   print_list(l.tail());
				}
	      		fi
		)

		
	};

	display(stack : List): Object{
		(let copy_stack: List <- stack, io : IO <- (new IO) in 
			while (not copy_stack.isNil()) loop
			    {
			       print_list(copy_stack);
			       copy_stack <- copy_stack.tail();
			    }
			 pool
		)
	};
	
	evaluate (stack : List):List{
		(let top_element: String <- stack.head() in 
			if top_element = "+" then addition(stack.tail())
			else if top_element = "s" then s(stack.tail())
			else if top_element = "d" then {display(stack.tail()); stack.tail();}
			else stack.tail()
			fi fi fi

		)
	};


};


class Main inherits IO {

   input : String;
   stack : List;

   main() : Object {
      {
        out_string("Starting loop\n");
	out_string(">");
	stack <- new List;
	input <- in_string();
	stack.cons(input);
	out_string(input);
	out_string("\n");
	while (not input = "x") loop
		{
			out_string(">");
			input <- in_string();
			stack.cons(input);
			out_string(input);
			out_string("\n");
		}
	pool;
      }


   };

};

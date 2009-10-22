# ObjectiveMatchy

    [[@"Hello, World!" should] eql:@"Hello, World!"];


ObjectiveMatchy is a Matcher System enabling behaviour driven development for the iPhone Platform.


## Installation

* Download the latest ObjectiveMatchy-X.X.X.zip file.   
* Extract it somewhere  (eg. to  ~/Resources)
* The extracted folder contains static libraries for both the device and the simulater and a framework.
* Copy the ObjectiveMatchy.framework to /Developer/Library/Frameworks.
* Copy the static libraries (libObjectiveMatchyIphoneSimulator.a, libObjectiveMatchyIphoneDevice.a) to your projects root. 
* Add the libObjectiveMatchyIphoneSimulator.a static library to your Simulator Testing Target.
* Add the libObjectiveMatchyIphoneDevice.a static library to your Application (Device) Testing Target.

## Usage

* Open the Information Window of your Testing Target by right clicking and choosing "get info".
* In the Linker Group of the Build tab, search for the "Other Linker Flag" row and add -ObjC and `-all_load`.
* In the "Search Paths" Group of the Build tab, search for the "Header Search Paths" row and add `$(DEVELOPER_LIBRARY_DIR)/Frameworks/ObjectiveMatchy.framework`.
* Check the "Recursive" checkbox.
* In the "Search Paths" Group of the Build tab, search for the "Library Search Paths" row and add `$(SRCROOT)`.
* Add an import statement to the header file of your TestCase: `#import 'ObjectiveMatchy.h'`
* That's it!

## One sophisiticated Example as proof of Nontriavialness

Assume an Object that has a Key "aKey" and a method  
that can change the key of *another* Object.

This setup resembles the common situation where i have two objects that are somehow associated and   
sending the first object some message results in the second object changing some attribute.

Because there are no blocks (closures) in Objective C, it is not possible to directly  
rebuild RSpec's way of specifying this behavior. 

With RSpec you could write the following example:

    obj      = ObjectWithKey.new
		otherObj = ObjectWithKey.new
    
		lambda { obj.setValue(:forKey => "aKey", :ofObject => otherObj) }.should change {
			otherObj.aKey
		}.from(nil).to("aValue")

With ObjectiveMatchy all information must be part of the matcher message.


### Specification of the desired behavior with ObjectiveMatchy

	obj      = [ObjectWithKey object];
	otherObj = [ObjectWithKey object];

    [[obj should] changeValueForKey:@"aKey" 
                           ofObject:otherObj
                               from:nil 
                                 to:@"aValue"
                         forMessage:@"setValue:forKey:ofObject:" 
                      withArguments:[NSArray arrayWithObjects:@"aValue", @"aKey", otherObj, nil]];

    (Xcode will autocomplete such long messages for you!)



This matcher assures that the value of aKey is nil before sending the message to obj  
and that it is @"aValue" afterwards. It will also give you a meaningful failuremessage if the expectation is not 
met, together with the actual values of the attributes in question.   
Using standard assertions, you would have a bit more to do to achieve all this. 

### Implementation of ObjectWithKey (for the sake of completeness)

	@interface ObjectWithKey : NSObject {
		id aKey;
		int aKeyWithIntValue;
	}

	+ (ObjectWithKey *) object; 

	- (void) setValue:(id)aValue forKey:(NSString *)key ofObject:(id)anObject;

	@end

	@implementation ObjectWithKey

	+ (ObjectWithKey *) object
	{
		ObjectWithKey * obj = [[ObjectWithKey alloc] init];
		[obj autorelease];
		return obj;
	}

	- (void) setValue:(id)aValue forKey:(NSString *)key ofObject:(id)anObject
	{
		[anObject setValue:aValue forKey:key];
	}

	@end
	


## What is a Matcher System?

A Matcher System is a Framework that provides a painless way   
to **compose Assertions** without the need to provide custom Failure Messages.   
Thus built Assertions consist of two parts:   

1. An Expectation that is built from an Object.
2. A Matcher Message that is sent to the Expectation.

The Expectation understands the Matcher Messages (like eql:) and verifies that    
the object that was used to build the Expectation actually satisfies the condition    
that is specified by the Matcher Message or throws an Exception.   

If an Exception is thrown, it will be shown inline in Xcode, together with a   
meaningful Failure Message.

ObjectiveMatchy can be used together with a Unit Testing Framework or   
standalone as an alternative to NSAssert().   

## Features:

* Build Expectations by sending an object the 'should' or 'shouldNot' Messages.
* Use ObjectiveMatchy's built in Matchers.
* Specify Assertions for your TestCases.
* Use it as an alternative to NSAssert().
* Regular Expression Matcher.
* Build your own custom matchers for special cases. This can save you   
  from writing hundreds of lines of meaningless test-setUp code.

## Using ObjectiveMatchy with OCUnit/SenTesting

At first you have to import the ObjectiveMatchy library: `#import 'ObjectiveMatchy.h'`
Now you can use the Assertion building system in your tests:

      - (void) testEqualArrays
      {
      	NSNumber * one = [NSNumber numberWithInt:1];
      	NSNumber * two = [NSNumber numberWithInt:2];
      	NSArray  * arr = [NSArray arrayWithObjects:one, two, nil];
      	NSArray  * equalArr = [NSArray arrayWithObjects:one, two, nil];

      	[[arr should] eql:equalArr];
      }

      - (void) testDistinctArrays
      {
      	NSNumber * one = [NSNumber numberWithInt:1];
      	NSNumber * two = [NSNumber numberWithInt:2];
      	NSArray  * arr = [NSArray arrayWithObjects:one, two, nil];
      	NSArray  * distinctArr = [NSArray arrayWithObjects:one, two, nil];

      	[[arr shouldNot] eql:distinctArr];
      }


## Built in matchers - Quick ShowCase

### eql:(id)obj

        [[@"Hello, World!" should] eql:@"Hello, World"];

        [[@"Hello, World!" shouldNot] eql:@"Something Else"];


### haveKey:(NSString *)akey

        ObjectWithKey * o = [[ObjectWithKey alloc] init];

        [[o should] haveKey:@"Key"];

        [[o shouldNot] haveKey:@"nonexisting"];

### haveKey:(NSString *)aKey withValue:(id)value

        ObjectWithKey * o = [[ObjectWithKey alloc] init];

        [o setValue:@"Value" forKey:@"Key"];

        [[o should] haveKey:@"Key" withValue:@"Value"];

        [[o shouldNot] haveKey:@"Key" withValue:@"OtherValue"];

### returnValue:(id)expectedValue forMessage:(NSString *) withArguments:(NSArray *)

		ObjectWithKey * o = [[ObjectWithKey alloc] init];

        [o setValue:@"Value" forKey:@"Key"];

		[[o should] returnValue:@"Value" 
		             forMessage:@"valueForKey:"
		 		  withArguments:[NSArray arrayWithObject:@"Key"]];

### containObject:(id)anObject

	    NSNumber * aContainedObject    = [NSNumber numberWithInt:1];    
		NSNumber * two                 = [NSNumber numberWithInt:2];
		NSArray  * anArray             = [NSArray arrayWithObjects:aContainedObject, two, nil];
		NSObject * anUnContainedObject = [[NSObject alloc] init];

		[[anArray should]    containObject:aContainedObject];

		[[anArray shouldNot] containObject:anUnContainedObject];

### be:(NSString *)omitIs

		BadObject * badObject = [BadObject badObject];	

    	[[badObject should] be:@"Bad"];     // passes if [badObject isBad] returns YES

		[[badObject shouldNot] be:@"Good"]; // passes if [badObject isGood] returns NO

### be:(NSString *)omitIs with:(id)object

    	[[anObject should]    be:@"Equal:" with:anObject];

		[[anObject shouldNot] be:@"Equal:" with:anotherObject];

### throw:(NSString *)expectedException forMessage:(NSString *) withArguments:(NSArray *)arguments

    	// BadObject throws an Exception for 'raise'

		BadObject * badObject = [[BadObject alloc] init];

		[[badObject should] throw:@"" // Empty String matches any Exception
		               forMessage:@"raise"
				    withArguments:nil]; 

### changeValueForKey:(NSString *)aKey forMessage:(NSString *)messageString withArguments:(NSArray *)arguments

		ObjectWithKey * obj = [ObjectWithKey object];

	    [[obj should] changeValueForKey:@"aKey" 
							 forMessage:@"setValue:forKey:" 
						  withArguments:[NSArray arrayWithObjects:@"aValue", @"aKey", nil]];

### changeValueForKey:(NSString *)aKey from:(id)fromValue to:(id)toValue forMessage:(NSString *)messageString withArguments:(NSArray *)arguments

		ObjectWithKey * obj = [ObjectWithKey object];

    	[[obj should] changeValueForKey:@"aKey" 
								   from:nil 
									 to:@"aValue"
							 forMessage:@"setValue:forKey:" 
						  withArguments:[NSArray arrayWithObjects:@"aValue", @"aKey", nil]];


### changeValueForKey:(NSString *)aKey ofObject:(id)anObject forMessage:(NSString *)messageString withArguments:(NSArray *)arguments

		ObjectWithKey * obj      = [ObjectWithKey object];

		ObjectWithKey * otherObj = [ObjectWithKey object];

    	[[obj should] changeValueForKey:@"aKey" 
							   ofObject:otherObj
							 forMessage:@"setValue:forKey:ofObject:" 
						  withArguments:[NSArray arrayWithObjects:@"aValue", @"aKey", otherObj, nil]];

### changeValueForKey:(NSString *)aKey ofObject:(id)anObject from:(id)fromValue to:(id)toValue forMessage:(NSString *)messageString withArguments:(NSArray *)arguments

    	ObjectWithKey * obj      = [ObjectWithKey object];

		ObjectWithKey * otherObj = [ObjectWithKey object];

		[[obj should] changeValueForKey:@"aKey" 
							   ofObject:otherObj
								   from:nil 
									 to:@"aValue"
							 forMessage:@"setValue:forKey:ofObject:" 
						  withArguments:[NSArray arrayWithObjects:@"aValue", @"aKey", otherObj, nil]];


### respondToSelector:(SEL)selector

        NSObject * o = [[NSObject alloc] init];

        [[o should] respondToSelector:@selector(copy)];

        [[o shouldNot] respondToSelector:@selector(nonexisting)];


### respondToSelector:(SEL)selector andReturn:(id)expectedValue

        NSObject * o = [[NSObject alloc] init];

        [[o should] respondToSelector:@selector(description) 
        					          andReturn:[o description]];

        [[o shouldNot] respondToSelector:@selector(description) 
        					             andReturn:@"Something Else"];

### respondToSelector:(SEL)selector withObject:(id)argument andReturn:(id)expectedValue

        NSObject * o = [[NSObject alloc] init];

        [[o should] respondToSelector:@selector(isEqualTo:) 
        					  withObject:o 
        					   andReturn:OM_YES];

        [[o shouldNot] respondToSelector:@selector(isEqualTo:) 
         					        withObject:@"Something Else"
         					         andReturn:OM_YES];

## Scalar Value Wrapper

Because ObjectiveMatchy can (and should and will) only handle Objects,   
there are Wrappers for scalar values for some special cases:  

* `OM_YES` for YES 
* `OM_NO` for NO
* `OM_INT(some_int_value)` for int values
* `OM_FLOAT(some_float_value)` for float values
* `OM_SEL(some_SEL_value)` for selectors


## Using ObjectiveMatchy standalone

Let's say you have an Object: 'obj'.   
At Runtime, you want to assure that 'obj'    
maintains a key: 'assoc' with the value of   
a pointer to some other Object: 'assocObj'.  

With ObjectiveMatchy you can express this intent as follows:  

		[[obj should] haveKey:@"assoc" 
		            withValue:assocObj];
            
With NSAssert it would rather sound like:

		NSAssert([assocObj isEqualTo:[obj valueForKey:@"assoc"]], 
		     @"obj should have key 'assoc' with value assocObj.");
     
Don't forget to include the ObjectiveMatchy-Framework   
in the implementation file that should use it.:    
`#import  <ObjectiveMatchy/ObjectiveMatchy.h>`



## Custom Matchers

Matchers are Instance-Methods of the OMMatcher class,  
so custom matchers can be added as a category to OMMatcher.  
In the implementation of your custom matcher method, you have to  
configure the matcher object (ie set some properties),  
that is available as the current self object.   
You have to set the matchers 'matches' property that   
the matcher will use to decide if the expectation has    
been satisfied or not and call handleExpectation on self.   
One should further provide custom positive (should)   
and negative (shouldNot) failure messages,   
set self.expected and return the expected Object.   
Also add the method definition to the category's   
interface, or the compiler will yell.  

### Example: eql-Matcher: Mandatory Implementation

    - (id) eql:(id)anExpected
    { 
    	self.matches = [self.actual isEqualTo:anExpected];
    	[self handleExpectation];
    	return anExpected;
    }

### Example: eql-Matcher: Complete Implementation
      - (id) eql:(id)anExpected
      { 
      	self.expected               = anExpected;
      	self.matches                = [self.actual isEqualTo:self.expected];
      	self.positiveFailureMessage = [NSString stringWithFormat:
      			@"'%@' should be equal to: '%@', but isn't (with isEqualTo).", 
      			self.actual, self.expected];
      	self.negativeFailureMessage = [NSString stringWithFormat:
      			@"'%@' should not be equal to: '%@', but is (with isEqualTo).", 
      			self.actual, self.expected];
	
      	[self handleExpectation];
	
      	return self.expected;
      }
      
### Template

      - (id) matcherName:(id)expectedValue
      {
      	self.expected = expectedValue;

		// expectedValue might be an OMWrapper Object. In that case, 
		// the actual Value is expected to be scalar and thus must also be wrapped.
		id actualValue = [self isWrapped] ? [[self.expected class] wrapperWithValue:[self.actual doSomethingToGetActualValue]] 
									      : [self.actual doSomethingToGetActualValue];
									
		// Specify the condition ...
      	self.matches = NO; // todo

		// Set the failure messages that will be shown inline if the condition evaluates to false.
      	self.positiveFailureMessage = 
				@"positive Failure: should but wasn't. Actual Object: '%@', Expected Value: '%@', Actual Value: '%@'", 
			    	self.actual, self.expected, actualValue;
      	self.negativeFailureMessage = 
				@"negative Failure: shouldn't but was. Actual Object: '%@', Expected Value: '%@', Actual Value: '%@'",
					self.actual, self.expected, actualValue;
		
		// Calling handleExpectation is mandatory
      	[self handleExpectation];
		
      	return self.expected;
      }




## Contribution

* Idea?, Feature Request?, Bug? -> [Lighthouse](http://300.lighthouseapp.com/projects/33499-objective-matchy/overview)
* source -> [GitHub](http://github.com/mhennemeyer/objectivematchy)
* talk? -> [GoogleGroup](http://groups.google.de/group/objective-matchy)

## Thanks to

* David Chelimsky, Dave Astels, Dan North, Pat Maddox, Steven Baker, Aslak Hellesoy et.al. for RSpec.
* sen:te for OCUnit and the SenTestingKit.
* Erik Doernenburg for OCMock.
* Steve Jobs for the iPhone.
* Dan North for BDD.
* Kent Beck for TDD.

## Links

* [RSpec](http://rspec.info)
* [OCMock](http://www.mulle-kybernetik.com/software/OCMock/)
* [OCUnit/SenTestingKit](http://www.sente.ch/software/ocunit/)
* [behaviour-driven](http://behaviour-driven.org/)
* [Dan North. Introducing BDD](http://dannorth.net/introducing-bdd)



## License

(The MIT License)

Copyright (c) Matthias Hennemeyer

Permission is hereby granted, free of charge, to any person obtaining   
a copy of this software and associated documentation files (the   
'Software'), to deal in the Software without restriction, including   
without limitation the rights to use, copy, modify, merge, publish,   
distribute, sublicense, and/or sell copies of the Software, and to   
permit persons to whom the Software is furnished to do so, subject to   
the following conditions:

The above copyright notice and this permission notice shall be   
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,   
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF   
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.   
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY   
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,   
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE   
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
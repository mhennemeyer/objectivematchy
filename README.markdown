This is prealpha software that hasn't been released yet.  
This Software is developed testdriven, so there may   
be fewer bugs than in other prealpha software but be careful anyway.  
If you want to try it, please clone the repository, open the   
Xcode Project and build the framework or run the tests.   

# ObjectiveMatchy

    [[@"Hello, World!" should] eql:@"Hello, World!"];



ObjectiveMatchy is a behaviour driven development framework for the iPhone Platform.    
It consists of a Matcher System, a utility that enables isolated xib tests,   
and a plain text feature parser.



# The Matcher System

A Matcher System is a Framework that provides a painless way   
to compose Assertions without the need to provide custom Failure Messages.   
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


## Using ObjectiveMatchy with OCUnit/SenTesting

Again: Include the ObjectiveMatchy-Framework:   
`#import <ObjectiveMatchy/ObjectiveMatchy.h>`

You can use the Assertion building system in your tests now:

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

### match:(NSString *)regEx

        [[@"Hello" should] match:@"/.*/"];

		[[@"Hello" shouldNot] match:@"/World/"];
        
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
* `OM_INT(int)` for int values
* `OM_FLOAT(float)` for float values
* `OM_SEL(SEL)` for selectors

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

# Isolated XIB (aka View) Tests

# The Plain Text Feature Parser

Consider the following Plain Text Feature Definition:


	Feature: Say Hello World

		As a Developer 
		I want to let my system say 'Hello, World!'
		So that i have a starting point.

		Scenario: Just opened the app
			Given i just opened the app
			When i push the 'Hello' Button
			Then the 'HelloLabel' Label should show 'Hello, World!'
				
ObjectiveMatchy's plain text feature parsing utility (OMFeatures)   
will create the following TestCase File from it:

    #import "OMFeature.h"

    @interface SayHelloWorldTest : OMFeature
    @end

    @implementation SayHelloWorldTest
	
    -(void) testJustOpenedTheApp
    {
        [self Given_i_just_opened_the_app]; 
        [self When_i_push_the____Button:@"Hello"]; 
        [self Then_the____Label_should_show___:@"HelloLabel" arg:@"Hello, World!"];
    }

    @end


The Step Definitions (eg. `Given_i_just_opened_the_app`) will be added    
as instance methods to the OMFeature class. OMFeature inherits from SenTestCase.

    //OMFeature.h 
	
	#import <SenTestingKit/SenTestingKit.h>
	#import <UIKit/UIKit.h>

	@interface OMFeature : SenTestCase {

	}

	-(void) Given_i_just_opened_the_app;

	-(void) When_i_push_the____Button:(NSString *)button;

	-(void) Then_the____Label_should_show___:(NSString *)labelName arg:(NSString *)labelValue;

	@end

	
	//OMFeature.h
	
	#import "OMFeature.h"

	@implementation OMFeature

	-(void) setUp
	{

	}

	-(void) Given_i_just_opened_the_app
	{
		NSLog(@"\nHello!!!");
	}

	-(void) When_i_push_the____Button:(NSString *)button
	{
		NSLog(button);
	}

	-(void) Then_the____Label_should_show___:(NSString *)labelName arg:(NSString *)labelValue
	{
		NSLog(labelName);
	}

	@end
	


## Install ObjectiveMatchy:


* Download the latest ObjectiveMatchy-X.X.X.zip file.   
* Extract it somewhere  (eg. to  ~/Resources)
* Copy the 'OM Templates' Folder to ~/'Application Support'/Developer/Shared/Xcode/'Project Templates'/
* Start or restart Xcode.
* The 'New Project'-Wizard should provide an 'OM Templates' tab now.
* Choose one of the provided Templates. They resemble the default ones.


## Contribution

* Idea?, Feature Request?, Bug? -> [Lighthouse](http://300.lighthouseapp.com/projects/33499-objective-matchy/overview)
* source -> [GitHub](http://github.com/mhennemeyer/objectivematchy)
* talk? -> [GoogleGroup](http://groups.google.de/group/objective-matchy)

## Thanks to

* David Chelimsky, Dave Astels, Dan North, Pat Maddox, Steven Baker, Aslak Hellesoy et.al. for RSpec.
* Aslak Hellesoy, David Chelimsky and Dan North for RBehave/RSpecUserStories/Cucumber.
* sen:te for OCUnit and the SenTestingKit.
* Erik Doernenburg for OCMock.
* Steve Jobs for the iPhone.
* Dan North for BDD.
* Kent Beck for TDD.

## Links

* [RSpec](http://rspec.info)
* [Cucumber](http://cukes.info)
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
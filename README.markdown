# ObjectiveMatchy

    [[@"Hello, World!" should] eql:@"Hello, World"];

ObjectiveMatchy is a Matcher System for Objective C.

A Matcher System is a Framework that provides a painless way   
to compose Assertions without the need to provide custom Failure Messages.   
Thus built Assertions consist of two parts:   

1. An Expectation that is added to an Object.
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

## Install ObjectiveMatchy:

1. Download [ObjectiveMatchy.zip](http://cloud.github.com/downloads/mhennemeyer/objectivematchy/ObjectiveMatchy.zip)
2. Copy the included 'ObjectiveMatchy.framework' to your Frameworks folder.
3. `#import  <ObjectiveMatchy/ObjectiveMatchy.h>`

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


## Built in matchers

* eql:(id)obj
    
        [[@"Hello, World!" should] eql:@"Hello, World"];
        [[@"Hello, World!" shouldNot] eql:@"Something Else"];
        
* haveKey:(NSString *)akey

        ObjectWithKey * o = [[ObjectWithKey alloc] init];
        [[o should] haveKey:@"Key"];
        [[o shouldNot] haveKey:@"nonexisting"];
       
* haveKey:(NSString *)aKey withValue:(id)value

        ObjectWithKey * o = [[ObjectWithKey alloc] init];
        [o setValue:@"Value" forKey:@"Key"];
        [[o should] haveKey:@"Key" withValue:@"Value"];
        [[o shouldNot] haveKey:@"Key" withValue:@"OtherValue"];
        
* returnValue:forMessage: ...

* contain: ...
  
    ...soon

* be: ...

    ...soon

* throw:forMessage: ...

    ...soon

* changeValueForKey:forMessage: ...

    ...soon

* changeValueForKey:from:to:forMessage: ...

    ...soon

* respondToSelector:(SEL)selector
       
        NSObject * o = [[NSObject alloc] init];
        [[o should] respondToSelector:@selector(copy)];
        [[o shouldNot] respondToSelector:@selector(nonexisting)];
        
        
* respondToSelector:(SEL)selector andReturn:(id)expectedValue

        NSObject * o = [[NSObject alloc] init];
        [[o should] respondToSelector:@selector(description) 
        					          andReturn:[o description]];
        [[o shouldNot] respondToSelector:@selector(description) 
        					             andReturn:@"Something Else"];
        					             
* respondToSelector:(SEL)selector withObject:(id)argument andReturn:(id)expectedValue

        NSObject * o = [[NSObject alloc] init];
        [[o should] respondToSelector:@selector(isEqualTo:) 
        					  withObject:o 
        					   andReturn:OM_YES];
        [[o shouldNot] respondToSelector:@selector(isEqualTo:) 
         					        withObject:@"Something Else"
         					         andReturn:OM_YES];
         					             
## Scalar Value Wrapper

Because ObjectiveMatchy can only handle Objects,   
there are Wrappers for the scalar values like   
`OM_YES` for YES and `OM_NO` for NO.

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
      	
      	// Specify the condition ...
      	self.matches = NO; // todo
      	
      	// if expectedValue is a OMWrapper Object
      	if ( [self.expected respondsToSelector:@selector(isAOMWrapper)] ) {
      	  // take care: scalar values in a format string.
      		self.positiveFailureMessage = @"format string with scalar values";
      		self.negativeFailureMessage = @"format string with scalar values";
      	} else {
      		self.positiveFailureMessage = @"positive Failure: should but wasn't";
      		self.negativeFailureMessage = @"negative Failure: shouldn't but was";
      	}

      	[self handleExpectation];
      	return self.expected;
      }

## Contribution

* Idea?, Feature Request?, Bug? -> [Lighthouse](http://300.lighthouseapp.com/projects/33499-objective-matchy/overview)
* source -> [GitHub](http://github.com/mhennemeyer/objectivematchy)
* talk? -> [GoogleGroup](http://groups.google.de/group/objective-matchy)

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
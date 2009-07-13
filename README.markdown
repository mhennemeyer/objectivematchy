# ObjectiveMatchy

    [[@"Hello, World!" should] eql:@"Hello, World"];

ObjectiveMatchy is a Matcher System for Objective C.

A Matcher System is a Framework that provides a painless way to compose Assertions without the need to provide custom Failure Messages.
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
3. #import  &lt;ObjectiveMatchy/ObjectiveMatchy.h&gt;

## Using ObjectiveMatchy standalone



## Using ObjectiveMatchy with OCUnit




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

Because ObjectiveMatchy can only handle Objects, there are Wrappers for 
the scalar values like 'OM_YES' for YES and 'OM_NO' for NO.
        					              

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


Feature: Say Hello World

	In order to have a starting point.
	As a Developer 
	I want to let my system say 'Hello, World!'
	
	Scenario: Just opened the app
		Given i just opened the app
		When i push the 'HelloButtonHello' Button
		Then the 'HelloHelloLabel' Label should show 'Hello, World!'
		
		
		
Feature: Say Hello World Again

	In order to have a starting point.
	As a Developer 
	I want to let my system say 'Hello, World! Again'
	
	Scenario: Just opened the app
		Given i just opened the app
		When i push the 'HelloAgain' Button
		Then the 'HelloAgainLabel' Label should show 'Hello, World! Again'
		
	Scenario: With a given Scenario
		GivenScenario: Just opened the app
		Given i just opened the app
		When i push the 'HelloAgain' Button
		Then the 'HelloAgainLabel' Label should show 'Hello, World! Again'
		
		
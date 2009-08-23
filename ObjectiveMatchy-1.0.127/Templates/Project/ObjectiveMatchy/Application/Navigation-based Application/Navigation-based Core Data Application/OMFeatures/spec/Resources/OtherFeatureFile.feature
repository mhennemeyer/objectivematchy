Feature: Say Hello

	As a Developer 
	I want to let my system say 'Hello, World!'
	So that i have a starting point.
	
	Scenario: With a blank Object
		Given a blank Object
		When i send it hello
		It should return 'Hello, World!'
		
	Scenario: With a custom Object
		GivenScenario: With a blank Object
		Given a custom Object with name 'Bob'
		When i send it hello
		It should return 'Hello, World! I am Bob.'
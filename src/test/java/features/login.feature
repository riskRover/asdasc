
@Login
Feature: Naukri Application Login functionality
  

  @invalidLogin
  Scenario Outline: Invalid Login of Naukri Application
    Given I want to land in Naukri Application
    When I enter Username as "<name>" and Password as "<password>"
    And clcik the Login button
    Then I verify the "<status>" based on the credentials

    #Examples: 
    #  | name                   | password        | status  |
    #  | bk2memry@gmail.com     | Shubham7@       | Invalid details. Please check the Email ID - Password combination. |
	#  | dregtrhthhhh@gmail.com | Welcomemec1!    | Invalid details. Please check the Email ID - Password combination. |
			
	@validLogin
  Scenario: Valid Login of Naukri Application
    Given I want to land in Naukri Application
    When I enter Username as "bk2memry@gmail.com" and Password as "Shubham7@"
    And clcik the Login button
    Then user should land in home page
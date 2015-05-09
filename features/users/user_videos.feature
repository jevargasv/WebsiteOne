@omniauth
Feature: As a site owner
  So I can make collaboration among registered users easier
  I would like to display a index of users with links to user profiles

  Background:
    Given I am logged in
    And the following users exist
      | first_name | last_name | email                  | password |
      | Alice      | Jones     | alice@btinternet.co.uk | 12345678 |
    And the following projects exist:
      | title       | description          | status   | tags            |
      | hello world | greetings earthlings | active   | WSO, WebsiteOne |
      | hello mars  | greetings aliens     | inactive | Autograders     |
    And I am a member of project "hello world"
    And I am a member of project "hello mars"

  Scenario: Show 'link your channel' message if my page channel is not linked
    Given my YouTube Channel is not connected
    When I go to my "profile" page
    Then I should not see a list of my videos
    When I go to my "edit profile" page
    And I should see "Sync with YouTube"

  Scenario: Show 'unlink your channel' message if my channel is connected
    Given my YouTube channel is connected
    When I go to my "edit profile" page
    Then I should see "Disconnect YouTube"

  Scenario: Link my Youtube channel to my account
    Given I have some videos on project "hello world"
    But my YouTube Channel is not connected
    And I am on my "edit profile" page
    When I click "Sync with YouTube"
    And I go to my "profile" page
    Then I should see "Title"
    And I should see a list of my videos
    But I should not see "Sync with YouTube"

  Scenario: Unlink my Youtube channel
    Given I have some videos on project "hello world"
    And my YouTube channel is connected
    And I am on my "edit profile" page
    When I click "Disconnect YouTube"
    And I go to my "profile" page

  Scenario: Show 'no videos' message if there no videos
    Given my YouTube channel is connected
    When I go to my "profile" page
    Then I should not see a list of my videos
    And I should see "has no publicly viewable Youtube videos"

  Scenario: show first video's description in the player's heading
    Given I have some videos on project "hello world"
    And my YouTube channel is connected
    When I go to my "profile" page
    Then I should see "PP on hello world - feature: 2" in "video description"

  Scenario: show videos sorted by descending published date
    Given I have some videos on project "hello world"
    And my YouTube channel is connected
    When I go to my "profile" page
    Then I should see "PP on hello world - feature: 2" before "PP on hello world - feature: 1"

  Scenario: show embedded youtube player with the first video
    Given I have some videos on project "hello world"
    And my YouTube channel is connected
    When I go to my "profile" page
    And I should see video "PP on hello world - feature: 2" in "player"

  @javascript
  Scenario: Selecting videos from the list
    Given I have some videos on project "hello world"
    And my YouTube channel is connected
    And I am on my "profile" page
    When I click "PP on hello world - feature: 1"
    Then I should see "PP on hello world - feature: 1" in "video description"
    And I should see video "PP on hello world - feature: 1" in "player"

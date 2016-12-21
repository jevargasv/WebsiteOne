@vcr
Feature: Tweeting Live Events
  As a site admin
  In order to increase participation in events
  I would like live events to generate twitter notifications

  Background:
    Given following events exist:
      | name       | description             | category        | start_datetime          | duration | repeats | time_zone | project | repeats_weekly_each_days_of_the_week_mask | repeats_every_n_weeks |
      | Scrum      | Daily scrum meeting     | Scrum           | 2014/02/03 07:00:00 UTC | 150      | never   | UTC       |         | And an event "Scrum"                      |                       |
    And an event "Scrum"

  Scenario: Event going live without valid live stream does not cause youtube link to be tweeted
    Given the live stream has not started
    When the HangoutConnection has pinged to indicate the event start, then the youtube link will not be sent

  Scenario: Event going live without valid live stream still causes hangout link to be tweeted
    Given the live stream has not started
    When the HangoutConnection has pinged to indicate the event start, then the hangout link will be sent

  Scenario: Event going live with valid livestream causes tweets of hangout link and youtube link to be sent
    Given the live stream has started
    When the HangoutConnection has pinged to indicate the event start, appropriate tweets will be sent

  #  Scenario: Broadcast termination causes tweet of the youtube URL to be sent
  #    Given that the HangoutConnection has pinged to indicate the event start
  #    And youtube stream has gone live
  #    And that recording has finished
  #    Then an appropriate tweet has been sent # e.g. see recording

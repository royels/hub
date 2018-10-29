Feature: hub issue
  Background:
    Given I am in "git://github.com/github/hub.git" git repo
    And I am "cornwe19" on github.com with OAuth token "OTOKEN"

  Scenario: Fetch issues
    Given the GitHub API server:
    """
    get('/repos/github/hub/issues/102') { json \
        :base => {
          :repo => {
            :owner => { :login => "defunkt" },
            :name => "hub",
            :private => false
          }
        },
        :head => {
          :ref => "hub_merge",
          :repo => {
            :owner => { :login => "jfirebaugh" },
            :name => "hub",
            :private => false
          }
        },
        :title => "Add `hub merge` command"
      }

      get('/repos/github/hub/issues/102/comments') { json \
              :base => {
                :repo => {
                  :owner => { :login => "defunkt" },
                  :name => "hub",
                  :private => false
                }
              },
              :head => {
                :ref => "hub_merge",
                :repo => {
                  :owner => { :login => "jfirebaugh" },
                  :name => "hub",
                  :private => false
                }
              },
              :title => "Add `hub merge` command"
      }
      """
    When I successfully run `hub issue view 102`
    Then the output should contain exactly:
      """
          #102  First issue
      """

Feature: Parse date strings

  Scenario: parse basic dates
  
    Then parse the following dates :
      | date                             | year | month | day | wday | bce? | circa? | complete? | unknown? |
      | Thurs 31 december 1998           | 1998 | 12    |   31|  4   | false| false  |  true     |   false  |
      |                                  |      |       |     |      |      |        |           |   true   |
      | 1540                             | 1540 |       |     |      |      |        |           |          |
      | september                        |      |   9   |     |      |      |        |           |          |
      | tuesday                          |      |       |     |  2   |      |        |           |          |
      | c sunday 1066                    | 1066 |       |     |  0   |      | true   |           |          |
      | 23 march 366 bc                  | 366  |  3    | 23  |  4   | true |        |  true     |          |
      | 10-11-12                         | 12   |  11   | 10  |      |      |        |  true     |          |
      
   Scenario: test random dates are parsed
   
     Then parse "1000" random dates
# API Outline
TBD: key auth?

## Main JSON Objects
### security
#### Description
General JSON object representing the basics of a security

#### Structure
- id (integer) security specific id
- cik (integer)
- ticker (string)
- name (string)
- sector (enum(string))


## URLs
### GET "/stageOne"
#### Description
Returns all entries for stage one

#### Paramaters
- {OPT} id (integer): When valid input, response will contain only the specified entry for this id number

#### Response Attributes
- count (integer): number of results
- results (array(objects)): array of objects representing results
    - id (integer): id for stage one entry
    - security (object): object representing the security, see Main JSON Objects
    - reasoning (string or NULL): reasoning for interest in security
    - partnerUUID (integer): unique integer which links partners in chronos' db and the auth db. The person who created this entry
    - active (boolean): whether this entry is active for this stage
    - time (time): time the entry was logged in this stage (see time for detailso n what this value looks like)

### GET "/stageTwo"
#### Description
Returns all entries for stage two

#### Paramaters
- {OPT} id (integer): When valid input, response will contain only the specified entry for this id number

#### Response Attributes
- count (integer): number of results
- results (array(objects)): array of objects representing results
    - id (integer): id for stage two entry
    - prev_link_id (integer or NULL): the stage one id which preceded this stage two entry if available
    - security (object): object representing the security, see Main JSON Objects
    - research_partnerUUID (integer or NULL): unique integer which links partners in chronos' db and the auth db. The person who is researching
    - active (boolean): whether this entry is active for this stage
    - time (time): time the entry was logged in this stage (see time for details on what this value looks like)

### GET "/stageThree"
#### Description
Returns all entries for stage three

#### Paramaters
- {OPT} id (integer): When valid input, response will contain only the specified entry for this id number

#### Response Attributes
- count (integer): number of results
- results (array(objects)): array of objects representing results
    - id (integer): id for stage three entry
    - prev_link_id (integer or NULL): the stage two id which preceded this stage two entry if available
    - security (object): object representing the security, see Main JSON object 
    - decision (enum(string)): the decision made on the security
    - reasoning (object): object for reasoning. See structure:
        - id (integer): id for the reasoning 
        - reasoning (string): reasoning behind decision
        - partnerUUID (integer): unique identifier for the partner which wrote this reasoning
        - time (time): time written
    - active (boolean): whether this entry is active for this stage
    - time (time): time the entry was logged in this stage (see time for details on what this value looks like)

### PUT "/stageOne"
#### Description
Create an entry in stage one
#### Paramaters
- {REQ} security_id (integer): The unique id for the corresponding security
- {REQ} partnerUUID (integer): The unique linking id for the partner entering this entry
- {OPT} reasoning (string): The reasoning behind the interest to be added to an analysis entry under type reasoning

#### Response Attributes
- id (integer): The id of newly created stage one entry

### PUT "/stageTwo"
#### Description
Create an entry in stage two
#### Paramaters
- {REQ} stage_one_id (integer): The stage 1 id of the entry to promote to stage two
- {OPT} partnerUUID (integer): unique identifier for the partner which is chosen to research it
#### Response Attributes
- id (integer): The id of the newly created stage two entry

### PUT "/stageThree"
#### Description
Create a new entry in stage three, as well as the required reasoning 
#### Paramaters
- {REQ} stage_two_id (integer): The stage 2 id of the entry to promote to stage three
- {REQ} decision (enum(string)): The decision to be made ("buy", "wait", "decline")
- {REQ} reasoning (object): object for reasoning
    - {REQ}: reasoning (string): the reasoning for the decision 
    - {REQ}: partnerUUID (integer): unique identifier for who wrote this description
#### Response Attributes
- id (integer): The id of the newly created stage three entry


### 
#### Description
#### Paramaters
#### Response Attributes

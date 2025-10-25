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
- None

#### Response Attributes
- count (integer): number of results
- results (array(objects)): array of objects representing results
    - id (integer): id for stage one entry
    - security (object): object representing the security, see Main JSON Objects
    - reasoning (string or NULL): reasoning for interest in security
    - partnerUUID (integer): unique integer which links partners in chronos' db and the auth db
    - active (boolean): whether this entry is active for this stage
    - time (time): time the entry was logged in this stage (see time for detailso n what this value looks like)

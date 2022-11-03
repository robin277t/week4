1. Design the Route Signature

1 the HTTP method
2 the path
3 any query parameters (passed in the URL)
4 or body parameters (passed in the request body)


1 GET
2 /artists
3 none
4 none

POST 
/artists
no query params
body params - name: Wild nothing
genre: Indie


2. Design the Response

POST
doesn't respond, returns nil, but calls create method on instance of artitstrepo
and inserts 1 new artist into the table

3. Write Examples
Replace these with your own design.

# Request:

POST /artists

# Expected response:

200 ok

4. Encode as Tests Examples
# EXAMPLE
# file: spec/integration/application_spec.rb

Test to include 200 status ok from POST

we will then reuse Get '/artists/ to check that the new artist is included

5. Implement the Route
Write the route and web server code to implement the route behaviour.

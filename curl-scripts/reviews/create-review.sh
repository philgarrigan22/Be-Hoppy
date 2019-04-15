#!/bin/bash

curl "http://localhost:4741/reviews" \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=${TOKEN}" \
  --data '{
    "review": {
      "beer": "'"${BEER}"'",
      "brewery": "'"${BREWERY}"'",
      "rating": "'"${RATING}"'",
      "location": "'"${LOCATION}"'",
      "beer_type": "'"${TYPE}"'",
      "flavor": "'"${FLAVOR}"'"
    }
  }'

echo

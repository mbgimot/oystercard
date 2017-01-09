#Read Me#

the card will have a default value of 0, the value is its balance. To test in IRB, we would like to make an instance (os) of Oystercard, and check to see its default balance. I would then like to add money to this balance. To check in IRB: using (os) instance, with top_up to see if balance increases (default_balance + top_up(amount)).

The card has a upper limit of £90. To check in IRB we will try and top up by a value greater than £90, assuming a balance of 0, and expect an error to be raised.

Once the card has a balance, we would like to be able to deduct money from it to pay for fares. To check in IRB: using (os) instance with deduct(fare) to see if balance decreases by deducted amount (balance - deduct(fare))

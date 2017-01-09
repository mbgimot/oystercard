###User Story 1###
In order to use public transport
As a customer
I want money on my card

###User Story 2###
In order to keep using public transport
As a customer
I want to add money to my card

###User Story 3###
In order to protect my money from theft or loss
As a customer
I want a maximum limit (of £90) on my card

###User Story 4###
In order to pay for my journey
As a customer
I need my fare deducted from my card

###User Story 5###
In order to get through the barriers.
As a customer
I need to touch in and out

###Functional Representation###
Object | Message?
card | balance
card | top_up
card | max_limit
card | deduct
station | touch_in/out
card | in_journey?

###Nouns & Verbs###
noun | verb
public transport | use
customer | want
money | add, deduct
card | limit
barriers | touch_in/out

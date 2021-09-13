
[README](../README.md)
# Requirements

#### Expected reader Knowledge
  - None

Frontend mentor supply you with a Figma design where most of the requirements can be found in visual form. [They ask that this Figma file is not shared](https://www.frontendmentor.io/faq) - which I have complied with. [They have publicly available images to get an overview of what it should look like.](https://www.frontendmentor.io/challenges/product-feedback-app-wbvUYqjR6) When you complete the application you put it onto Github and share it with other users of the website and to [tweet about it](https://www.frontendmentor.io/faq) - there's no expectation of this being secret.

## [Requirements publicly available](https://www.frontendmentor.io/challenges/product-feedback-app-wbvUYqjR6)

Your users should be able to:

- View the optimal layout for the app depending on their device's screen size
- See hover states for all interactive elements on the page
- Create, read, update, and delete product feedback requests
- Receive form validations when trying to create/edit feedback requests
- Sort suggestions by most/least upvotes and most/least comments
- Filter suggestions by category
- Add comments and replies to a product feedback request
- Upvote product feedback requests
- Bonus: Keep track of any changes, even after refreshing the browser (localStorage could be used for this if you're not building out a full-stack app)

## Requirements not publicly available - overview:

- Suggestions page with feedbacks of status "suggestion.
  - Columns can be ordered by comments and votes
- Roadmaps page with feedbacks of status "planned", "in-progress", and "live"
  - Columns should be ordered by upvote totals.


## Requirements I added to make sense:

Restrict who can change the Feedback status. [From the technical document authorization section.](./technical.md#Authorization).


| User Type | Authorization                            |
|:----------|:-----------------------------------------|
| Guest     | Visit the home page / suggestions        |
|           | Visit the Roadmap page                   |
| Customer  | Everything a guest can but also:         |
|           | Create feedbacks as suggestions          |
|           | Comment                                  |
|           | Vote                                     |
| Staff     | Everything a customer can but also:      |
|           | Can change the status of suggestions     |

Voting - a user should only be able to vote once for any given feedback.

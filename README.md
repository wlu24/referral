# Add features to a cut down version of the Buyapowa front-end

**Background**

As a customer, I would like to view a page with a URL that I can share to my friends. When my friends checkout, I should get a reward and be able to know I have a reward.

**Value**

Customers can refer their friends, get rewards, and be incentivised to refer more friends.

**Expectation**

 - Add the activity feed as per the wireframe
 - Get the customer data (i.e. customer email, share url, activity feed) from a rails api endpoint, rather than having hard coded data
 - Generate a unique share URL for the customer (this should render a page)
 
Stretch:

 - Create a referral when a user visits the unique share url and clicks a button and show this new referral on the activity feed
 
 
*Notes*

In `app/views/embed/show.html.slim` there are some partials that have been commented out, and a `javascript_pack_tag` that has also been commented out.
The `javascript_pack_tag` uses vuejs to build the frontend, and the partials are just plain html. Choose whichever you feel more comfortable with and uncomment the necessary parts.

Use any tools/libraries you like.

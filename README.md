# Blue Taxi App

Blue Taxi user & driver app project.


### High Level Architecture Overview

- Each view will have it's own model that extends the ChangeNotifier.
- Notify listeners for a view will ONLY BE CALLED when the View's state changes.
- Each view only has 2 states. Idle and Busy. Any other piece of UI contained in a view, that requires logic and state / UI updates will have it's own model associated with it. This way the main view only paints when the main view state changes.
- Providers will NOT be passed in through app level global provider, unless it's required by more than 1 view in the app architecture (Users information).
- Providers and services will be injected using get_it.
- Models will ONLY request data from Services and reduce state from that DATA. Nothing else.
- Dedicated Services(Just normal objects) will perform all the actual work. Api class will request and serialize data. The model will just call the function to do that. Authentication service will use the Api to get the user details and track it. The model just calls the function and passes values to it.

#Feedback
  - readme file, what to do
  - formatting

  Routes
  -keep it RESTful - /resource/:id/(action)

  resources do
    get :details
    resources :(other resources)
  end

  Backend
    - more validations - not null, dependent: destroy
    - not nulls, catch exceptions
    - atomicity - transaction, using new to create both
    - transactions
    - use more active records with data

  Code
    - on rescues be more specific and let others bubble up
    - naming conventions - be consistent and logical
    -


# RSPEC LAB - MODEL AND CONTROLLER SPECS

------

### OBJECTIVES

- Be able to write model specs using FactoryGirl and RSpec
- Be able to write controller specs using FactoryGirl and RSpec


------

## YOUR TASK

Dr. Feelgood has hired you to build an app that will track appointments for his office. Please look over the following requirements.

#### DOCTOR MODEL

- An instance of the Doctor class should have  `name`, `specialty`, and `active` properties.
  
  - A Doctor must have a `name` to be entered into the database
  - A Doctor must have a `specialty` to be entered into the database
  - A Doctor’s `active` property should be false by default (HINT: Don’t try to fake it with FactoryGirl. ***How can you assign default values to a record being saved in the database???***)
  
- The Doctor class should have two class methods:
  
  - `active_doctors` that returns the number of doctors whose `active` field is true
  - `inactive_doctors` that returns the number of doctors whose `active` field is false
  




#### DOCTORS CONTROLLER

- Only requires `index` and `show` actions
  
  - Both `index` and `show` should be tested to verify that they return http success.
  - The `index` action should be tested to verify that it assigns all Doctors in the database to the `@doctors` instance variable
  - The show action should be tested to verify that it assigns a single Doctor to the `@doctor` instance variable
  


#### APPOINTMENT MODEL

- Should have a `scheduled_date` property
  
  - An Appointment must have a `scheduled_date` to be entered into the database
  


#### APPOINTMENTS CONTROLLER

- Only requires `create` and `delete` actions
  
  - The `create` action should be tested to verify that it adds appointments to the database
  - The `delete` action should be tested to verify that it deletes appointments from the database
  


------

***TERMINAL OUTPUT***

``` ruby
AppointmentsController
  GET #create
    should save an appointment to the DB
  GET #destroy
    should delete an appointment from the database

DoctorsController
  GET #index
    should return http success
    should assign @doctors to include all doctors
  GET #show
    should return http success
    should assign a doctor to @doctor

Appointment
  should not save without a valid scheduled_date

Doctor
  should not save without a valid name
  should not save without a valid specialty
  #active
    should be false by default
  .active_doctors
    should return the number of active doctors
  .inactive_doctors
    should return the number of inactive doctors

Finished in 0.12009 seconds (files took 1.65 seconds to load)
12 examples, 0 failures
```


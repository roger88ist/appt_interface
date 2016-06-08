# Notes

The populate.rb file was created to demonstrate a way to populate the `appt_api` using the data provided by the csv file.
- However a "422" status code will be returned for each appointment due to the fact that the api does not allow the creation of a past appointment, only future appointments.

The same can be achieved from within the api application itself with the following steps:
  1. Adding the csv file to the db directory of the api.
  2. Comment out lines 21 and 22 of `populate.rb`
  3. Uncomment line 23 of `populate.rb`
  4. Copy and paste lines 11-26 of `populate.rb` into `seeds.rb` inside the db directory.
  5. run `rake db:seed` from the terminal inside the application directory.
- **However this as well will not go through as the database will rollback every transcation due to the validations set in place in the model file. In order for `rake db:seed` to work the validations would have to at least be commented out.**
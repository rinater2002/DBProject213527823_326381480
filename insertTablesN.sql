import random
import string

# Define ranges for random values
workers_roles = ["Production Worker", "Shift Manager", "Maintenance Worker", "Office Worker"]
wages_range = (7500, 15000)
workers_emails = ["https://sparkmailapp.com/blog/create-professional-email-address-format-examples"]
workers_phones = range(10000000, 99999999)
shifts = ["Morning", "Afternoon", "Evening"]

# Generate 400 random records
for i in range(400):
  # Choose a random worker role
  workers_role = random.choice(workers_roles)

  # Generate a random wage
  wage = random.randint(*wages_range)

  # Generate a random email address
  workers_email = random.choice(workers_emails) + str(i) + "@" + "gmail.com"

  # Generate a random phone number
  workers_phone = random.choice(workers_phones)

  # Choose a random shift
  shift = random.choice(shifts)

  # Generate a random worker name
  workers_name = "".join(random.choice(string.ascii_letters) for _ in range(10))

  # Create INSERT statement
  insert_query = f"INSERT INTO Workers (WorkersRole, Wage, WorkersMail, WorkersPhone, Shift, IdWo, WorkersName) VALUES ('{workers_role}', {wage}, '{workers_email}', {workers_phone}, '{shift}', {i}, '{workers_name}');"

  # Print INSERT statement
  print(insert_query)

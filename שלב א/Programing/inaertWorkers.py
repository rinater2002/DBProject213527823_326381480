import random
import string

first_names = [
  "Noah", "Olivia", "Liam", "Emma", "Oliver", "Ava", "Elijah", "Sophia",
  "William", "Isabella", "James", "Charlotte", "Benjamin", "Mia", "Lucas",
  "Evelyn", "Mason", "Abigail", "Ethan", "Harper", "Aaliyah", "Alexander",
  "Amelia", "Jackson", "Ava", "Emily", "Avah", "Mason", "Olivia", "Sophia",
  "Liam", "Isabella", "Noah", "William", "James", "Benjamin", "Charlotte",
  "Elijah", "Mia", "Lucas", "Evelyn", "Mason", "Abigail", "Ethan", "Harper",
  "Avery", "Logan", "Ella", "Sofia", "Matthew", "Evelyn", "Aaliyah", "Alexander",
  "Amelia", "Emily", "Elizabeth", "Michael", "Avery", "Charlotte", "Avah",
  "Sophia", "Liam", "Ava", "Noah", "William", "James", "Benjamin", "Amelia",
  "Mason", "Evelyn", "Elijah", "Lucas", "Olivia", "Ethan", "Harper", "Avery",
  "Logan", "Ella", "Luna", "David", "Layla", "Camila", "Mateo", "Mia", "Evelyn",
  "Penelope", "Henry", "Riley", "Charlotte", "Aurora", "Levi", "Zoe", "Violet",
  "Elias", "Stella", "Scarlett", "Julian", "Maverick", "Claire"
]
 
last_names = [
  "Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis",
  "Rodriguez", "Wilson", "Moore", "Clark", "Lewis", "Robinson", "Walker",
  "Allen", "Young", "Hall", "Wood", "Anderson", "Thomas", "Wright", "Hernandez",
  "King", "Scott", "Nelson", "Robinson", "Carter", "Campbell", "Adams", "Mitchell",
  "Bell", "Roberts", "Turner", "Phillips", "Green", "Baker", "Harris", "Lewis",
  "Lopez", "Martin", "Sanchez", "Clark", "Young", "Lee", "Allen", "Walker",
  "King", "Robinson", "Wright", "Scott", "Pierce", "Miller", "Diaz", "Cruz",
  "Murphy", "Harris", "Lewis", "Clark", "Hall", "Moore", "Robinson", "Garcia",
  "Rodriguez", "Anderson", "Thomas", "Jackson", "Campbell", "Young", "Allen",
  "Wright", "Diaz", "Walker", "Moore", "Robinson", "Nelson", "Carter", "Turner",
  "Garcia", "Johnson", "Davis", "Miller", "Rodriguez", "Lopez", "Hernandez", "Gonzalez",
  "Harris", "Clark", "Lewis", "Robinson", "Walker", "Allen", "Young", "King",
  "Wright", "Scott", "Pierce", "Moore", "Diaz", "Cruz", "Hall", "Bell", "Nelson",
  "Carter", "Campbell"
]

def generate_name():
  index1 = random.randint(0,98)
  first_name= first_names[index1]
  index2 = random.randint(0,98)
  last_name = last_names[index2]
  return first_name + " "+ last_name

def generate_email():
  suffix = "@gmail.com"
  chars = string.ascii_letters + string.digits  #array of all letters and numbers
  random_string = ''.join(random.choice(chars) for _ in range(8))
  return random_string + suffix

def generate_phone():
  
  # Fixed prefix (05)
  prefix = "05"
  # Generate remaining digits (8 random digits between 0 and 9)
  digits = ''.join(str(random.randint(0, 9)) for _ in range(8))
  # Combine prefix and digits
  return prefix + digits


# Define ranges for random values
workers_roles = ["Press Operator", "Prepress Technician", " Graphic Designer", "Customer Service Representative"]
wages_range = (7500, 15000)
shifts = ["Morning", "Afternoon", "Evening"]

# Generate 400 random records
for i in range(400):
  # Choose a random worker role
  workers_role = random.choice(workers_roles)

  # Generate a random wage
  wage = random.randint(*wages_range)

  # Generate a random email address
  workers_email = generate_email()

  # Generate a random phone number
  workers_phone = generate_phone()

  # Choose a random shift
  shift = random.choice(shifts)

  # Generate a random worker name
  workers_name = generate_name()

  # Create INSERT statement
  insert_query = f"INSERT INTO Workers (WorkersRole, Wage, WorkersMail, WorkersPhone, Shift, IdWo, WorkersName) VALUES ({workers_role}, {wage}, '{workers_email}', {workers_phone}, '{shift}', {i+1}, '{workers_name}');"

  # Print INSERT statement
  print(insert_query)

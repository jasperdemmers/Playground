import mysql.connector
from faker import Faker

def get_mock_data(fake, id_value):
    klant_id = fake.unique.random_number()
    woning_id = fake.unique.random_number()

    klant = {
        "Gebruikersnaam": fake.user_name(),
        "Wachtwoord": fake.password(),
        "Voornaam": fake.first_name(),
        "Achternaam": fake.last_name(),
        "Type": "Particulier",
        "Email": fake.email(),
        "Telefoon": fake.phone_number(),
        "GeboorteDatum": str(fake.date_of_birth(minimum_age=30, maximum_age=90)),
        "Created_date": str(fake.date_time_this_year()),
        "Updated_date": str(fake.date_time_this_year()),
    }

    woning = {
        "Klant_ID": id_value,
        "Naam": fake.street_name(),
        "Adres": fake.address().replace('\n', ', '),
        "Postcode": fake.zipcode(),
        "Plaats": fake.city(),
        "Land": fake.country(),
        "Oppervlakte": fake.random_int(min=100, max=200),
        "Created_date": str(fake.date_time_this_year()),
        "Updated_date": str(fake.date_time_this_year()),
    }

    waterton = {
        "Woning_ID": id_value,
        "Naam": fake.city(),
        "Max_inhoud": fake.random_int(min=100, max=200),
        "Inhoud": fake.random_int(min=20, max=100),
        "Laatste_onderhoud": str(fake.date_time_this_year()),
        "Volgende_onderhoud": str(fake.date_time_this_year()),
        "Created_date": str(fake.date_time_this_year()),
        "Updated_date": str(fake.date_time_this_year()),
    }

    return klant, woning, waterton

def main():
    # Create a connection
    conn = mysql.connector.connect(
        host='10.1.4.10',
        port=3306,
        user='AquaBrain',
        password='AquaBrain#2023!',
        database='AquaBrain'
    )
    c = conn.cursor()

    fake = Faker()

    for id_value in range(1, 50):  # generate 5 sets of data
        klant, woning, waterton = get_mock_data(fake, id_value)
        
        insert_into_klant = "INSERT INTO klant (Gebruikersnaam, Wachtwoord, Voornaam, Achternaam, Type, Email, Telefoon, GeboorteDatum, Created_date, Updated_date) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
        c.execute(insert_into_klant, list(klant.values()))

        insert_into_woning = "INSERT INTO woning (Klant_ID, Naam, Adres, Postcode, Plaats, Land, Oppervlakte, Created_date, Updated_date) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)"
        c.execute(insert_into_woning, list(woning.values()))

        insert_into_waterton = "INSERT INTO waterton (Woning_ID, Naam, Max_inhoud, Inhoud, Laatste_onderhoud, Volgende_onderhoud, Created_date, Updated_date) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"
        c.execute(insert_into_waterton, list(waterton.values()))

    # Commit the transaction
    conn.commit()

    # Close the connection
    c.close()
    conn.close()

if __name__ == "__main__":
    main()

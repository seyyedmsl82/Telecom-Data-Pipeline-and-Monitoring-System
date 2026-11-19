import getpass
import psycopg

password = getpass.getpass("Database password: ")

try:
    with psycopg.connect(
        host = "localhost", 
        port = 5432, 
        dbname = "telecom_db", 
        user = "telecom_user", 
        password = password
    ) as conn:
        print("Connected Successfully!")

        with conn.cursor() as cursor:
            cursor.execute("SELECT current_database(), current_user;")
            result = cursor.fetchone()

            print("Database: ", result[0])
            print("User: ", result[1])

except psycopg.Error as error:
    print("Connection Failed: ", error)
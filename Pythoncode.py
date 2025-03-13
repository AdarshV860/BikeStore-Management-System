import mysql.connector  # Import MySQL connector to connect with the database

# Connect to the MySQL database
def connect_to_database():
    try:
        connection = mysql.connector.connect(
            host="localhost",      # Database server
            user="root",           # MySQL username
            password="Hi102",      # MySQL password
            database="BikeStoreDB" # Name of the database
        )
        print("Connected to the database successfully!")
        return connection
    except mysql.connector.Error as err:
        print(f"Error: {err}")  # Print error if connection fails
        return None

# Get customer order details from the database
def fetch_order_report(connection):
    cursor = connection.cursor()  # Create a cursor to run SQL queries

    # SQL query to get customer names, order details, and total amount
    query = """
        SELECT Customers.first_name, Customers.last_name, 
               Orders.order_id, Orders.order_status, 
               SUM(Order_Items.list_price * Order_Items.quantity * (1 - Order_Items.discount / 100)) AS total_amount
        FROM Orders
        INNER JOIN Customers ON Orders.customer_id = Customers.customer_id
        INNER JOIN Order_Items ON Orders.order_id = Order_Items.order_id
        GROUP BY Orders.order_id;
    """

    cursor.execute(query)  # Run the query
    results = cursor.fetchall()  # Get all results
    cursor.close()  # Close the cursor
    return results

# Show the results on the screen and save them to a text file
def generate_report(results):
    file_path = "customer_order_report.txt"  # File name to save the report

    with open(file_path, "w") as file:
        # Print and write column headers
        header = f"{'First Name':<15}{'Last Name':<15}{'Order ID':<10}{'Status':<15}{'Total Amount ($)':<15}"
        print(header)
        print("=" * 70)
        file.write(header + "\n")
        file.write("=" * 70 + "\n")

        # Print and write each row of data
        for row in results:
            first_name, last_name, order_id, status, total_amount = row
            line = f"{first_name:<15}{last_name:<15}{order_id:<10}{status:<15}{total_amount:<15.2f}"
            print(line)
            file.write(line + "\n")

    print("\nReport has been generated and saved as 'customer_order_report.txt'")

# Main function to run the program
def main():
    connection = connect_to_database()  # Connect to the database
    if connection:  # Check if connection was successful
        results = fetch_order_report(connection)  # Get order details
        if results:  # Check if there are any results
            generate_report(results)  # Create the report
        connection.close()  # Close the database connection

# Run the program when the script is executed
if __name__ == "__main__":
    main()

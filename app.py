from flask import Flask
from flask_cors import CORS

app = Flask(__name__)
CORS(app)


@app.route("/")
def home():
    return {"message": "Flask backend is running"}


@app.route("/api/user/create" , methods=["POST"])
def create_user():
    # Here you can handle the POST request and process the data
    user_data = {
        "google_id": "123456789",
        "name": "Harsh",
        "email": "harsh@gmail.com",
        "profile_image": None
    }
    response = supabase.table("users").insert(user_data).execute()
    if not response.status_code == 201:
        return {
            "message": "Failed to create user",
            "error": response.error
        }, 400

    # Process the user_data as needed
    return {
        "message": "User created successfully",
        "user": response.data
    }
    
if __name__ == "__main__":
    app.run(debug=True)
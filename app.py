from flask import Flask, jsonify, request, send_from_directory
from flask_cors import CORS
import mysql.connector
import os

app = Flask(__name__, static_folder='.', static_url_path='')
CORS(app)

@app.route('/')
def index():
    return send_from_directory('.', 'index.html')


db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': 'tejas', # Update this!
    'database': 'streamview'
}

def get_db_connection():
    return mysql.connector.connect(**db_config)

def init_views():
    """Ensures the SQL views exist in the database."""
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        
        # View 1: Top Rated Movies
        cursor.execute("""
            CREATE OR REPLACE VIEW TopRatedMovies AS
            SELECT title, director_name, genre, avg_rating 
            FROM Movies 
            WHERE avg_rating >= 8.5
            ORDER BY avg_rating DESC;
        """)
        
        # View 2: Director Statistics
        cursor.execute("""
            CREATE OR REPLACE VIEW DirectorMovieCount AS
            SELECT director_name, COUNT(*) as movie_count, AVG(avg_rating) as avg_director_rating
            FROM Movies
            GROUP BY director_name
            ORDER BY movie_count DESC;
        """)
        
        conn.commit()
        cursor.close()
        conn.close()
        print("SQL Views initialized successfully.")
    except Exception as e:
        print(f"Error initializing views: {e}")

@app.route('/api/movies', methods=['GET'])
def get_movies():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Movies")
    movies = cursor.fetchall()
    for m in movies:
        if m['avg_rating']: m['avg_rating'] = float(m['avg_rating'])
    cursor.close()
    conn.close()
    return jsonify(movies)

@app.route('/api/movies/favorite', methods=['POST'])
def toggle_favorite():
    data = request.json
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("UPDATE Movies SET is_favorite = %s WHERE movie_id = %s", 
                   (data['is_favorite'], data['movie_id']))
    conn.commit()
    cursor.close()
    conn.close()
    return jsonify({"success": True})

# --- NEW RECOMMENDATION LOGIC ---
@app.route('/api/movies/recommend/<int:movie_id>', methods=['GET'])
def get_recommendations(movie_id):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    
    # 1. Get the genre and director of the current movie
    cursor.execute("SELECT genre, director_name FROM Movies WHERE movie_id = %s", (movie_id,))
    current_movie = cursor.fetchone()
    
    if not current_movie:
        return jsonify([])

    # 2. Find similar movies (matching director OR sharing part of the genre string)
    # We limit to 4 recommendations
    genre_part = current_movie['genre'].split(',')[0] # Get first genre tag
    query = """
        SELECT * FROM Movies 
        WHERE (director_name = %s OR genre LIKE %s) 
        AND movie_id != %s 
        ORDER BY avg_rating DESC 
        LIMIT 4
    """
    cursor.execute(query, (current_movie['director_name'], f"%{genre_part}%", movie_id))
    recommendations = cursor.fetchall()
    
    for r in recommendations:
        if r['avg_rating']: r['avg_rating'] = float(r['avg_rating'])
        
    cursor.close()
    conn.close()
    return jsonify(recommendations)

# --- VIEW ENDPOINTS (For Teacher Demonstration) ---
@app.route('/api/views/top-rated', methods=['GET'])
def get_top_rated_view():
    """Fetches data from the 'TopRatedMovies' SQL View"""
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM TopRatedMovies")
    data = cursor.fetchall()
    for d in data:
        if d['avg_rating']: d['avg_rating'] = float(d['avg_rating'])
    cursor.close()
    conn.close()
    return jsonify(data)

@app.route('/api/views/director-stats', methods=['GET'])
def get_director_stats_view():
    """Fetches data from the 'DirectorMovieCount' SQL View"""
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM DirectorMovieCount")
    data = cursor.fetchall()
    for d in data:
        if d['avg_director_rating']: d['avg_director_rating'] = float(d['avg_director_rating'])
    cursor.close()
    conn.close()
    return jsonify(data)

if __name__ == '__main__':
    init_views()
    app.run(debug=True, port=5000)
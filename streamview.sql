-- 1. Create the Database
CREATE DATABASE IF NOT EXISTS streamview;
USE streamview;

-- 2. Create the Unified Movies Table
-- We use a single table to avoid "Foreign Key Constraint" errors.
CREATE TABLE Movies (
    movie_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year INT,
    duration INT,
    language VARCHAR(50),
    summary TEXT,
    director_name VARCHAR(150),
    lead_actor VARCHAR(150),
    genre VARCHAR(255),       -- Example: "Action, Sci-Fi"
    age_rating VARCHAR(10),   -- Example: "18+", "13+", "U"
    avg_rating DECIMAL(3, 1) DEFAULT 0.0
);




-- Add a 'is_favorite' column. 0 = Not Favorite, 1 = Favorite.
ALTER TABLE Movies ADD COLUMN is_favorite TINYINT(1) DEFAULT 0;

-- 3. Insert 100 Unique Movies (One-Shot)
INSERT INTO Movies (title, release_year, duration, language, summary, director_name, lead_actor, genre, age_rating, avg_rating) VALUES
('Inception', 2010, 148, 'English', 'A thief steals secrets through dreams.', 'Christopher Nolan', 'Leonardo DiCaprio', 'Sci-Fi, Action', '13+', 8.8),
('The Matrix', 1999, 136, 'English', 'A hacker discovers reality is a simulation.', 'The Wachowskis', 'Keanu Reeves', 'Sci-Fi, Action', '13+', 8.7),
('Interstellar', 2014, 169, 'English', 'Explorers travel through a wormhole.', 'Christopher Nolan', 'Matthew McConaughey', 'Sci-Fi, Drama', 'U', 8.6),
('The Dark Knight', 2008, 152, 'English', 'Batman faces a rising criminal mastermind.', 'Christopher Nolan', 'Christian Bale', 'Action, Crime', '13+', 9.0),
('Blade Runner 2049', 2017, 164, 'English', 'A young blade runner unearths a secret.', 'Denis Villeneuve', 'Ryan Gosling', 'Sci-Fi, Drama', '18+', 8.0),
('Tenet', 2020, 150, 'English', 'A secret agent embarks on a time-bending mission.', 'Christopher Nolan', 'John David Washington', 'Sci-Fi, Action', '13+', 7.3),
('Mad Max: Fury Road', 2015, 120, 'English', 'A woman rebels against a tyrant.', 'George Miller', 'Tom Hardy', 'Action, Adventure', '18+', 8.1),
('Looper', 2012, 119, 'English', 'Killers are sent back in time to be executed.', 'Rian Johnson', 'Joseph Gordon-Levitt', 'Sci-Fi, Thriller', '18+', 7.4),
('The Martian', 2015, 144, 'English', 'An astronaut is stranded on Mars.', 'Ridley Scott', 'Matt Damon', 'Sci-Fi, Adventure', 'U', 8.0),
('Source Code', 2011, 93, 'English', 'A soldier wakes up in someone else body.', 'Duncan Jones', 'Jake Gyllenhaal', 'Sci-Fi, Thriller', '13+', 7.5),
('Edge of Tomorrow', 2014, 113, 'English', 'A soldier fights aliens in a time loop.', 'Doug Liman', 'Tom Cruise', 'Sci-Fi, Action', '13+', 7.9),
('Minority Report', 2002, 145, 'English', 'Police arrest murderers before they act.', 'Steven Spielberg', 'Tom Cruise', 'Sci-Fi, Mystery', '13+', 7.6),
('Arrival', 2016, 116, 'English', 'A linguist communicates with alien visitors.', 'Denis Villeneuve', 'Amy Adams', 'Sci-Fi, Drama', 'U', 7.9),
('Dune', 2021, 155, 'English', 'Noble family struggles for a desert planet.', 'Denis Villeneuve', 'Timothee Chalamet', 'Sci-Fi, Adventure', '13+', 8.0),
('Avatar', 2009, 162, 'English', 'A Marine dispatched to the moon Pandora.', 'James Cameron', 'Sam Worthington', 'Sci-Fi, Action', 'U', 7.9),
('The Prestige', 2006, 130, 'English', 'Two magicians engage in a deadly rivalry.', 'Christopher Nolan', 'Hugh Jackman', 'Drama, Mystery', '13+', 8.5),
('Shutter Island', 2010, 138, 'English', 'A Marshal investigates a psychiatric facility.', 'Martin Scorsese', 'Leonardo DiCaprio', 'Mystery, Thriller', '18+', 8.2),
('Gladiator', 2000, 155, 'English', 'A General sets out to exact vengeance.', 'Ridley Scott', 'Russell Crowe', 'Action, Drama', '18+', 8.5),
('Jurassic Park', 1993, 127, 'English', 'A paleontologist visits a dinosaur theme park.', 'Steven Spielberg', 'Sam Neill', 'Sci-Fi, Adventure', 'U', 8.2),
('Star Wars', 1977, 121, 'English', 'Rebels fight a galactic empire.', 'George Lucas', 'Mark Hamill', 'Sci-Fi, Adventure', 'U', 8.6),
('Goodfellas', 1990, 146, 'English', 'A young man grows up in the mob.', 'Martin Scorsese', 'Robert De Niro', 'Crime, Drama', '18+', 8.7),
('The Departed', 2006, 151, 'English', 'An undercover cop and a mole try to hide.', 'Martin Scorsese', 'Leonardo DiCaprio', 'Crime, Thriller', '18+', 8.5),
('The Wolf of Wall Street', 2013, 180, 'English', 'The rise and fall of Jordan Belfort.', 'Martin Scorsese', 'Leonardo DiCaprio', 'Comedy, Crime', '18+', 8.2),
('Django Unchained', 2012, 165, 'English', 'A freed slave rescues his wife.', 'Quentin Tarantino', 'Jamie Foxx', 'Action, Drama', '18+', 8.4),
('The Hateful Eight', 2015, 168, 'English', 'Bounty hunters seek shelter from a storm.', 'Quentin Tarantino', 'Samuel L. Jackson', 'Mystery, Western', '18+', 7.8),
('Inglourious Basterds', 2009, 153, 'English', 'Jewish soldiers hunt Nazis in France.', 'Quentin Tarantino', 'Brad Pitt', 'Action, War', '18+', 8.3),
('Fight Club', 1999, 139, 'English', 'An insomniac forms an underground club.', 'David Fincher', 'Brad Pitt', 'Drama', '18+', 8.8),
('Se7en', 1995, 127, 'English', 'Two detectives hunt a sin-based killer.', 'David Fincher', 'Morgan Freeman', 'Crime, Mystery', '18+', 8.6),
('Pulp Fiction', 1994, 154, 'English', 'Crime lives intertwine in Los Angeles.', 'Quentin Tarantino', 'John Travolta', 'Crime, Drama', '18+', 8.9),
('John Wick', 2014, 101, 'English', 'An ex-hitman comes out of retirement.', 'Chad Stahelski', 'Keanu Reeves', 'Action, Thriller', '18+', 7.4),
('Parasite', 2019, 132, 'Korean', 'A poor family schemes to work for a rich one.', 'Bong Joon-ho', 'Song Kang-ho', 'Drama, Thriller', '18+', 8.5),
('The Truman Show', 1998, 103, 'English', 'A man discovers his life is a TV show.', 'Peter Weir', 'Jim Carrey', 'Comedy, Drama', 'U', 8.2),
('Saving Private Ryan', 1998, 169, 'English', 'Soldiers find a paratrooper behind lines.', 'Steven Spielberg', 'Tom Hanks', 'Drama, War', '18+', 8.6),
('The Godfather', 1972, 175, 'English', 'The patriarch of a crime dynasty.', 'Francis Ford Coppola', 'Marlon Brando', 'Crime, Drama', '18+', 9.2),
('Titanic', 1997, 194, 'English', 'A romance on the ill-fated ship.', 'James Cameron', 'Leonardo DiCaprio', 'Drama, Romance', '13+', 7.9),
('Memento', 2000, 113, 'English', 'A man with memory loss seeks a killer.', 'Christopher Nolan', 'Guy Pearce', 'Mystery, Thriller', '18+', 8.4),
('The Batman', 2022, 176, 'English', 'Batman investigates Gothams corruption.', 'Matt Reeves', 'Robert Pattinson', 'Action, Crime', '13+', 7.8),
('Zodiac', 2007, 157, 'English', 'Obsession with the Zodiac killer.', 'David Fincher', 'Jake Gyllenhaal', 'Crime, Drama', '18+', 7.7),
('Dunkirk', 2017, 106, 'English', 'Evacuation of soldiers in WWII.', 'Christopher Nolan', 'Fionn Whitehead', 'Action, War', '13+', 7.8),
('Drive', 2011, 100, 'English', 'A getaway driver gets into trouble.', 'Nicolas Winding Refn', 'Ryan Gosling', 'Action, Crime', '18+', 7.8),
('Heat', 1995, 170, 'English', 'Professional bank robbers feel the heat.', 'Michael Mann', 'Robert De Niro', 'Action, Crime', '18+', 8.3),
('The Green Mile', 1999, 189, 'English', 'Death row guards have a spiritual experience.', 'Frank Darabont', 'Tom Hanks', 'Drama, Fantasy', '18+', 8.6),
('The Sixth Sense', 1999, 107, 'English', 'A boy communicates with spirits.', 'M. Night Shyamalan', 'Bruce Willis', 'Drama, Mystery', '13+', 8.2),
('Unbreakable', 2000, 106, 'English', 'A security guard survives a train wreck.', 'M. Night Shyamalan', 'Bruce Willis', 'Drama, Sci-Fi', '13+', 7.3),
('Signs', 2002, 106, 'English', 'A family discovers crop circles.', 'M. Night Shyamalan', 'Mel Gibson', 'Sci-Fi, Thriller', '13+', 6.8),
('The Village', 2004, 108, 'English', 'A community lives in fear of creatures.', 'M. Night Shyamalan', 'Bryce Dallas Howard', 'Drama, Mystery', '13+', 6.6),
('Split', 2016, 117, 'English', 'A man with 23 personalities kidnaps girls.', 'M. Night Shyamalan', 'James McAvoy', 'Horror, Thriller', '18+', 7.3),
('Glass', 2019, 129, 'English', 'Security guard uses supernatural abilities.', 'M. Night Shyamalan', 'Bruce Willis', 'Drama, Sci-Fi', '13+', 6.6),
('Oldboy', 2003, 120, 'Korean', 'A man seeks revenge after 15 years.', 'Park Chan-wook', 'Choi Min-sik', 'Action, Drama', '18+', 8.4),
('The Handmaiden', 2016, 145, 'Korean', 'A handmaiden to a Japanese heiress.', 'Park Chan-wook', 'Kim Min-hee', 'Drama, Romance', '18+', 8.1),
('Snowpiercer', 2013, 126, 'English', 'Survivors live on a train after an ice age.', 'Bong Joon-ho', 'Chris Evans', 'Action, Sci-Fi', '18+', 7.1),
('Okja', 2017, 121, 'English', 'A girl risks everything for her massive animal.', 'Bong Joon-ho', 'Tilda Swinton', 'Action, Adventure', '13+', 7.3),
('Memories of Murder', 2003, 131, 'Korean', 'Detectives struggle with a provincial case.', 'Bong Joon-ho', 'Song Kang-ho', 'Crime, Drama', '18+', 8.1),
('The Host', 2006, 120, 'Korean', 'A creature emerges from the Han River.', 'Bong Joon-ho', 'Song Kang-ho', 'Horror, Sci-Fi', '13+', 7.1),
('Train to Busan', 2016, 118, 'Korean', 'Zombie outbreak on a train to Busan.', 'Yeon Sang-ho', 'Gong Yoo', 'Action, Horror', '18+', 7.6),
('The Wailing', 2016, 156, 'Korean', 'A stranger arrives in a small village.', 'Na Hong-jin', 'Kwak Do-won', 'Horror, Mystery', '18+', 7.4),
('I Saw the Devil', 2010, 144, 'Korean', 'A secret agent seeks revenge on a killer.', 'Kim Jee-woon', 'Lee Byung-hun', 'Action, Crime', '18+', 7.8),
('The Chaser', 2008, 125, 'Korean', 'A pimp tries to find a missing girl.', 'Na Hong-jin', 'Kim Yoon-seok', 'Action, Crime', '18+', 7.8),
('A Bittersweet Life', 2005, 120, 'Korean', 'An enforcer is ordered to kill a mistress.', 'Kim Jee-woon', 'Lee Byung-hun', 'Action, Crime', '18+', 7.5),
('New World', 2013, 134, 'Korean', 'An undercover cop in a crime syndicate.', 'Park Hoon-jung', 'Lee Jung-jae', 'Crime, Drama', '18+', 7.5),
('The Man from Nowhere', 2010, 119, 'Korean', 'A quiet man rescues a kidnapped girl.', 'Lee Jeong-beom', 'Won Bin', 'Action, Crime', '18+', 7.7),
('Veteran', 2015, 123, 'Korean', 'A detective hunts a wealthy heir.', 'Ryoo Seung-wan', 'Hwang Jung-min', 'Action, Comedy', '18+', 7.0),
('The Admiral: Roaring Currents', 2014, 128, 'Korean', 'Admiral Yi Sun-sin leads 12 ships.', 'Kim Han-min', 'Choi Min-sik', 'Action, Drama', '13+', 7.1),
('Ode to My Father', 2014, 126, 'Korean', 'A mans life through Korean history.', 'Yoon Je-kyoon', 'Hwang Jung-min', 'Drama, War', '13+', 7.8),
('The Attorney', 2013, 127, 'Korean', 'A tax lawyer takes a civil rights case.', 'Yang Woo-suk', 'Song Kang-ho', 'Drama', '13+', 7.7),
('A Taxi Driver', 2017, 137, 'Korean', 'A taxi driver helps a German journalist.', 'Jang Hoon', 'Song Kang-ho', 'Action, Drama', '13+', 7.9),
('Miracle in Cell No. 7', 2013, 127, 'Korean', 'A mentally challenged father is imprisoned.', 'Lee Hwan-kyung', 'Ryu Seung-ryong', 'Comedy, Drama', '13+', 8.1),
('Masquerade', 2012, 131, 'Korean', 'A commoner takes the Kings place.', 'Choo Chang-min', 'Lee Byung-hun', 'Drama, History', '13+', 7.8),
('The Thieves', 2012, 135, 'Korean', 'Professional thieves team up for a heist.', 'Choi Dong-hoon', 'Kim Yoon-seok', 'Action, Comedy', '13+', 6.8),
('Assassination', 2015, 140, 'Korean', 'Resistance fighters target a Japanese general.', 'Choi Dong-hoon', 'Jun Ji-hyun', 'Action, Drama', '13+', 7.3),
('Extreme Job', 2019, 111, 'Korean', 'Undercover cops open a chicken restaurant.', 'Lee Byeong-heon', 'Ryu Seung-ryong', 'Action, Comedy', '13+', 7.0),
('Along with the Gods: The Two Worlds', 2017, 139, 'Korean', 'A man is guided through the afterlife.', 'Kim Yong-hwa', 'Ha Jung-woo', 'Action, Drama', '13+', 7.3),
('Along with the Gods: The Last 49 Days', 2018, 142, 'Korean', 'The guardians seek their lost memories.', 'Kim Yong-hwa', 'Ha Jung-woo', 'Action, Drama', '13+', 7.1),
('Exit', 2019, 103, 'Korean', 'Rock climbers escape a poisonous gas.', 'Lee Sang-geun', 'Jo Jung-suk', 'Action, Comedy', '13+', 7.0),
('Ashfall', 2019, 128, 'Korean', 'A volcanic eruption threatens the peninsula.', 'Lee Hae-jun', 'Lee Byung-hun', 'Action, Adventure', '13+', 6.2),
('Swing Kids', 2018, 133, 'Korean', 'Soldiers find joy in tap dancing.', 'Kang Hyeong-cheol', 'D.O.', 'Drama, War', '13+', 7.5),
('Broker', 2022, 129, 'Korean', 'Individuals seek parents for a baby.', 'Hirokazu Kore-eda', 'Song Kang-ho', 'Drama', '13+', 7.1),
('Decision to Leave', 2022, 138, 'Korean', 'A detective falls for a murder suspect.', 'Park Chan-wook', 'Park Hae-il', 'Crime, Drama', '13+', 7.3),
('Hunt', 2022, 125, 'Korean', 'Agents hunt a mole within the agency.', 'Lee Jung-jae', 'Lee Jung-jae', 'Action, Thriller', '18+', 6.7),
('The Night Owl', 2022, 118, 'Korean', 'An acupuncturist witnesses a murder.', 'An Tae-jin', 'Ryu Jun-yeol', 'Drama, Thriller', '13+', 7.3),
('Concrete Utopia', 2023, 130, 'Korean', 'Earthquake survivors in an apartment.', 'Um Tae-hwa', 'Lee Byung-hun', 'Action, Drama', '13+', 6.8),
('Smugglers', 2023, 129, 'Korean', 'Haenyeo divers get involved in smuggling.', 'Ryoo Seung-wan', 'Kim Hye-su', 'Action, Crime', '13+', 6.6),
('Sleep', 2023, 94, 'Korean', 'A couple deals with terrifying sleepwalking.', 'Jason Yu', 'Lee Sun-kyun', 'Horror, Mystery', '18+', 6.8),
('Project Wolf Hunting', 2022, 122, 'Korean', 'Dangerous criminals on a cargo ship.', 'Kim Hong-sun', 'Seo In-guk', 'Action, Horror', '18+', 6.1),
('Hansan: Rising Dragon', 2022, 129, 'Korean', 'The battle of Hansan Island.', 'Kim Han-min', 'Park Hae-il', 'Action, Drama', '13+', 6.7),
('Emergency Declaration', 2021, 140, 'Korean', 'A plane declares an emergency mid-flight.', 'Han Jae-rim', 'Song Kang-ho', 'Action, Drama', '13+', 6.8),
('The Roundup', 2022, 106, 'Korean', 'Detectives hunt a criminal in Vietnam.', 'Lee Sang-yong', 'Ma Dong-seok', 'Action, Crime', '18+', 7.0),
('The Roundup: No Way Out', 2023, 105, 'Korean', 'Detective Ma Seok-do joins a new team.', 'Lee Sang-yong', 'Ma Dong-seok', 'Action, Crime', '18+', 6.6),
('The Roundup: Punishment', 2024, 109, 'Korean', 'Police target an illegal gambling ring.', 'Heo Myung-haeng', 'Ma Dong-seok', 'Action, Crime', '18+', 6.7),
('The Moon', 2023, 129, 'Korean', 'A rescue mission for a stranded astronaut.', 'Kim Yong-hwa', 'D.O.', 'Action, Drama', '13+', 5.9),
('Road to Boston', 2023, 108, 'Korean', 'Korean runners prepare for a marathon.', 'Kang Je-gyu', 'Ha Jung-woo', 'Drama, Sport', 'U', 6.6),
('Ballerina', 2023, 93, 'Korean', 'An ex-bodyguard seeks revenge for her friend.', 'Lee Chung-hyun', 'Jeon Jong-seo', 'Action, Thriller', '18+', 6.2),
('Kill Boksoon', 2023, 137, 'Korean', 'A legendary assassin balances her work.', 'Byun Sung-hyun', 'Jeon Do-yeon', 'Action, Crime', '18+', 6.6),
('Dream', 2023, 125, 'Korean', 'A soccer player coaches homeless people.', 'Lee Byeong-heon', 'Park Seo-joon', 'Comedy, Drama', '13+', 6.6),
('The Point Men', 2023, 108, 'Korean', 'Diplomats try to save hostages in Afghanistan.', 'Yim Soon-rye', 'Hwang Jung-min', 'Action, Drama', '13+', 6.0),
('Alienoid', 2022, 142, 'Korean', 'Swordsmen and aliens in two time periods.', 'Choi Dong-hoon', 'Ryu Jun-yeol', 'Action, Fantasy', '13+', 6.3),
('Alienoid: Return to the Future', 2024, 122, 'Korean', 'Characters race to prevent a gas explosion.', 'Choi Dong-hoon', 'Ryu Jun-yeol', 'Action, Fantasy', '13+', 6.5),
('Exhuma', 2024, 134, 'Korean', 'Shamans unearth a suspicious grave.', 'Jang Jae-hyun', 'Choi Min-sik', 'Horror, Mystery', '18+', 6.9),
('Citizen of a Kind', 2024, 114, 'Korean', 'A phishing victim tries to catch the culprit.', 'Park Young-ju', 'Ra Mi-ran', 'Action, Comedy', '13+', 6.5),
('Noryang: Deadly Sea', 2023, 153, 'Korean', 'The final battle of the Imjin War.', 'Kim Han-min', 'Kim Yoon-seok', 'Action, Drama', '13+', 6.6);

-- 4. Create SQL Views
-- View 1: Top Rated Movies (Concept: Simple filtering view)
CREATE OR REPLACE VIEW TopRatedMovies AS
SELECT title, director_name, genre, avg_rating 
FROM Movies 
WHERE avg_rating >= 8.5
ORDER BY avg_rating DESC;

-- View 2: Director Statistics (Concept: View with aggregation)
CREATE OR REPLACE VIEW DirectorMovieCount AS
SELECT director_name, COUNT(*) as movie_count, AVG(avg_rating) as avg_director_rating
FROM Movies
GROUP BY director_name
ORDER BY movie_count DESC;
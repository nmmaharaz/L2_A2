-- Active: 1747751836784@@127.0.0.1@5432@test_table
CREATE Table rangers (
    ranger_id serial PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    region VARCHAR(50) NOT NULL
);

CREATE Table species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50) NOT NULL,
    scientific_name VARCHAR(100) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(50) NOT NULL
);

CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    species_id INT REFERENCES "species" (species_id) NOT NULL,
    ranger_id INT REFERENCES "rangers" (ranger_id) NOT NULL,
    location VARCHAR(100) NOT NULL,
    sighting_time TIMESTAMP NOT NULL,
    notes TEXT
);

INSERT INTO
    rangers (name, region)
VALUES (
        ' Alice Green',
        ' Northern Hills'
    ),
    ('Bob White', 'River Delta'),
    (
        'Carol King ',
        'Mountain Range'
    );

INSERT INTO
    species (
        common_name,
        scientific_name,
        discovery_date,
        conservation_status
    )
VALUES (
        'Snow Leopard',
        'Panthera uncia  ',
        '1775-01-01  ',
        'Endangered '
    ),
    (
        'Bengal Tiger ',
        ' Panthera tigris tigris',
        '1758-01-01  ',
        'Endangered'
    ),
    (
        'Red Panda',
        'Ailurus fulgens',
        '1825-01-01',
        'Vulnerable'
    ),
    (
        'Asiatic Elephant',
        'Elephas maximus indicus',
        '1758-01-01',
        'Endangered'
    );

INSERT INTO
    sightings (
        species_id,
        ranger_id,
        location,
        sighting_time,
        notes
    )
VALUES (
        1,
        1,
        'Peak Ridge',
        '2022-05-10 07:45:00',
        'Camera trap image captured'
    )
  ;



-- probelm 1: Insert data into the rangers table
INSERT INTO
    rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');



--problem 2: Count unique species ever sighted
SELECT count(*) AS unique_species_count
from (
        SELECT count(*) AS species_count
        FROM sightings
        GROUP BY
            species_id
        HAVING
            COUNT(*) = 1
    );



-- problem 3: Find all sightings where the location includes "Pass"
SELECT * FROM sightings WHERE location LIKE '%Pass%';



-- problem 4: List each ranger's name and their total number of sightings
SELECT name, count(*) AS total_sightings
FROM rangers
    JOIN sightings ON rangers.ranger_id = sightings.ranger_id
GROUP BY
    rangers.ranger_id;



-- problem 5: List species that have never been sighted.
SELECT common_name
FROM species
    LEFT JOIN sightings ON species.species_id = sightings.species_id
WHERE
    sightings.species_id IS NULL;



-- problem 6: Show the most recent 2 sightings.
SELECT common_name, sighting_time, name
FROM
    species
    LEFT JOIN sightings ON species.species_id = sightings.species_id
    LEFT JOIN rangers ON sightings.ranger_id = rangers.ranger_id
WHERE
    sightings.species_id IS NOT NULL
ORDER BY sightings.sighting_time DESC
LIMIT 2;



-- problem 7: Update all species discovered before year 1800 to have status 'Historic'
UPDATE species
SET
    conservation_status = 'Historic'
WHERE
    discovery_date < '1800-01-01';



-- problem 8: Label each sighting's time of day as 'Morning', 'Afternoon', or 'Evening'
SELECT
    sighting_id,
    CASE
        WHEN EXTRACT(
            HOUR
            FROM sighting_time
        ) < 12 THEN 'Morning'
        WHEN EXTRACT(
            HOUR
            FROM sighting_time
        ) < 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_day
FROM sightings;



-- problem 9:  Delete rangers who have never sighted any speciess
DELETE FROM rangers
WHERE
    ranger_id NOT IN (
        SELECT ranger_id
        FROM sightings
    );
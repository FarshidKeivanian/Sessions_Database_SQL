-- Schema definition for the events table
CREATE TABLE events (
    id SERIAL PRIMARY KEY,
    venue VARCHAR(255),
    event_date DATE
);

-- Insert sample data into events table
INSERT INTO events (venue, event_date) VALUES
('National Gallery', '2024-06-15'),
('Old Parliament House', '2024-07-01'),
('Canberra Theatre', '2024-05-20'),
('National Museum', '2024-07-30'),
('National Gallery', '2024-08-12');

-- SQL query to list all unique event locations
SELECT DISTINCT venue FROM events;

-- SQL query to calculate the number of days until the next event at 'National Gallery'
SELECT event_date - CURRENT_DATE AS days_until_event
FROM events
WHERE venue = 'National Gallery'
AND event_date >= CURRENT_DATE;  -- ensures future events are considered

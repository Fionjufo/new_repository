--Fionjufo Fahrezi
--create table
CREATE TABLE email_list (
  ID INT AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(255) NOT NULL
  );

-- input example value
INSERT INTO email_list (email) VALUES
    ('example1@example.com'),
    ('example2@example.com'),
    ('example3@example.com'),
    ('example1@example.com'),
    ('example4@example.com');

-- query for get value
SELECT email
FROM email_list
GROUP BY email
HAVING COUNT(email) > 1;
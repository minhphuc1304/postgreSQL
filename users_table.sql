-- DROP EXIST TABLE
DROP TABLE IF EXISTS users;

-- CREATE USERS TABLE
CREATE TABLE users (
	id SERIAL,
	name VARCHAR(15) NOT NULL,
	phone VARCHAR(15) NOT NULL UNIQUE, -- phone is unique
	user_key VARCHAR(5),
	PRIMARY KEY (id, user_key)
);

-- Create func get last 5 phone numbers 
CREATE OR REPLACE FUNCTION generate_user_key()
RETURNS TRIGGER AS $$
BEGIN 
	NEW.user_key := RIGHT(NEW.phone, 5);
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- TRIGGER create user_key 
CREATE TRIGGER set_user_key
BEFORE INSERT ON users
FOR EACH ROW
EXECUTE FUNCTION generate_user_key();

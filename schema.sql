CREATE TABLE goals (
  id serial PRIMARY KEY,
  goal_name text NOT NULL CHECK (LENGTH(goal_name) > 0),
  goal_amount decimal(7, 2) NOT NULL CHECK (goal_amount >= 0.01),
  goal_private boolean DEFAULT true,
  creator_id integer NOT NULL
);

CREATE TABLE users (
  id serial PRIMARY KEY,
  username text NOT NULL,
  first_name text NOT NULL,
  last_name text NOT NULL,
  email text UNIQUE NOT NULL,
  password text NOT NULL
);

ALTER TABLE goals
ADD FOREIGN KEY (creator_id) REFERENCES users(id) ON DELETE CASCADE;

CREATE TABLE contributions (
  id serial PRIMARY KEY,
  amount decimal(7, 2) NOT NULL,
  date_contributed date DEFAULT NOW(),
  goal_id integer REFERENCES goals(id),
  user_id integer REFERENCES users(id)
);
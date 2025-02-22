CREATE TABLE users_type (
  user_type_id SERIAL PRIMARY KEY,
  user_type_name VARCHAR(255) DEFAULT NULL
);

INSERT INTO users_type (user_type_id, user_type_name) VALUES (1, 'Recruiter'), (2, 'Job Seeker');

CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  email VARCHAR(255) UNIQUE,
  is_active BOOLEAN DEFAULT NULL,
  password VARCHAR(255) DEFAULT NULL,
  registration_date TIMESTAMP(6) DEFAULT NULL,
  user_type_id INT REFERENCES users_type(user_type_id)
);

CREATE TABLE job_company (
  id SERIAL PRIMARY KEY,
  logo VARCHAR(255) DEFAULT NULL,
  name VARCHAR(255) DEFAULT NULL
);

CREATE TABLE job_location (
  id SERIAL PRIMARY KEY,
  city VARCHAR(255) DEFAULT NULL,
  country VARCHAR(255) DEFAULT NULL,
  state VARCHAR(255) DEFAULT NULL
);

CREATE TABLE job_seeker_profile (
  user_account_id INT PRIMARY KEY REFERENCES users(user_id),
  city VARCHAR(255) DEFAULT NULL,
  country VARCHAR(255) DEFAULT NULL,
  employment_type VARCHAR(255) DEFAULT NULL,
  first_name VARCHAR(255) DEFAULT NULL,
  last_name VARCHAR(255) DEFAULT NULL,
  profile_photo VARCHAR(255) DEFAULT NULL,
  resume VARCHAR(255) DEFAULT NULL,
  state VARCHAR(255) DEFAULT NULL,
  work_authorization VARCHAR(255) DEFAULT NULL
);

CREATE TABLE recruiter_profile (
  user_account_id INT PRIMARY KEY REFERENCES users(user_id),
  city VARCHAR(255) DEFAULT NULL,
  company VARCHAR(255) DEFAULT NULL,
  country VARCHAR(255) DEFAULT NULL,
  first_name VARCHAR(255) DEFAULT NULL,
  last_name VARCHAR(255) DEFAULT NULL,
  profile_photo VARCHAR(64) DEFAULT NULL,
  state VARCHAR(255) DEFAULT NULL
);

CREATE TABLE job_post_activity (
  job_post_id SERIAL PRIMARY KEY,
  description_of_job VARCHAR(10000) DEFAULT NULL,
  job_title VARCHAR(255) DEFAULT NULL,
  job_type VARCHAR(255) DEFAULT NULL,
  posted_date TIMESTAMP(6) DEFAULT NULL,
  remote VARCHAR(255) DEFAULT NULL,
  salary VARCHAR(255) DEFAULT NULL,
  job_company_id INT REFERENCES job_company(id),
  job_location_id INT REFERENCES job_location(id),
  posted_by_id INT REFERENCES users(user_id)
);

CREATE TABLE job_seeker_save (
  id SERIAL PRIMARY KEY,
  job INT REFERENCES job_post_activity(job_post_id),
  user_id INT REFERENCES job_seeker_profile(user_account_id),
  UNIQUE (user_id, job)
);

CREATE TABLE job_seeker_apply (
  id SERIAL PRIMARY KEY,
  apply_date TIMESTAMP(6) DEFAULT NULL,
  cover_letter VARCHAR(255) DEFAULT NULL,
  job INT REFERENCES job_post_activity(job_post_id),
  user_id INT REFERENCES job_seeker_profile(user_account_id),
  UNIQUE (user_id, job)
);

CREATE TABLE skills (
  id SERIAL PRIMARY KEY,
  experience_level VARCHAR(255) DEFAULT NULL,
  name VARCHAR(255) DEFAULT NULL,
  years_of_experience VARCHAR(255) DEFAULT NULL,
  job_seeker_profile INT REFERENCES job_seeker_profile(user_account_id)
);

CREATE TABLE partner (
   id INTEGER NOT NULL PRIMARY KEY,
   email TEXT NOT NULL, --Used for notifications
   external_uuid TEXT UNIQUE NOT NULL --Link to partner details in auth table for login
);

-- insert AI partner into database
INSERT INTO partner(email, external_uuid) VALUES ("e.a.josiah@gmail.com", "0000-0000-0000");

CREATE TABLE sector_type_enum (
   id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
   sector_type TEXT NOT NULL
);

INSERT INTO sector_type_enum(sector_type) VALUES
('Communication Services'),
('Consumer Discretionary'),
('Consumer Staples'),
('Financials'),
('Energy'),
('Health Care'),
('Industrials'),
('Information Technology'),
('Materials'),
('Real Estate'),
('Utilities');

CREATE TABLE security (
   id INTEGER NOT NULL PRIMARY KEY,
   cik DECIMAL(10, 0) NOT NULL,
   ticker VARCHAR(14) NOT NULL,
   name VARCHAR(256) NOT NULL,
   sector_id INTEGER,
   FOREIGN KEY(sector_id) REFERENCES sector_type_enum(id)
);

CREATE TABLE metric (
   id INTEGER NOT NULL PRIMARY KEY,
   security_id INTEGER NOT NULL, 
   name VARCHAR(50) NOT NULL,
   acronym VARCHAR(6) NOT NULL,
   value DECIMAL(10, 4) NOT NULL, -- make sure this data type matches the type in notifications table
   time INTEGER NOT NULL, -- see docs on how sqlite does time
   FOREIGN KEY(security_id) REFERENCES security(id)
);

CREATE TABLE stage_one (
   id INTEGER NOT NULL PRIMARY KEY,
   security_id INTEGER NOT NULL, 
   reasoning TEXT, -- reasoning for why they found it interesting
   partner_id INTEGER NOT NULL, 
   active BOOLEAN NOT NULL,
   time INTEGER NOT NULL, -- see docs for time 
   FOREIGN KEY(security_id) REFERENCES security(id),
   FOREIGN KEY(partner_id) REFERENCES partner(id)
);

CREATE TABLE stage_two (
   id INTEGER NOT NULL PRIMARY KEY,
   previous_stage_link INTEGER NOT NULL,
   security_id INTEGER NOT NULL,
   research_partner_id INTEGER, -- partner who is researching
   active BOOLEAN NOT NULL,
   time INTEGER NOT NULL, -- see docs
   FOREIGN KEY(previous_stage_link) REFERENCES stage_one(id),
   FOREIGN KEY(security_id) REFERENCES security(id),
   FOREIGN KEY(research_partner_id) REFERENCES partner(id)
);

CREATE TABLE decision_type_enum (
   id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
   decision_type TEXT NOT NULL UNIQUE
);

INSERT INTO decision_type_enum(decision_type) VALUES 
('buy'),
('wait'),
('decline');

CREATE TABLE stage_three (
   id INTEGER NOT NULL PRIMARY KEY,
   previous_stage_link INTEGER,
   security_id INTEGER NOT NULL,
   decision INTEGER NOT NULL,
   reasoning_id INTEGER NOT NULL,
   active BOOLEAN NOT NULL,
   time INTEGER NOT NULL, -- see docs
   FOREIGN KEY(previous_stage_link) REFERENCES stage_two(id),
   FOREIGN KEY(security_id) REFERENCES security(id),
   FOREIGN KEY(decision) REFERENCES decision_type_enum(id),
   FOREIGN KEY(reasoning_id) REFERENCES analysis(id)
);

CREATE TABLE sentiment_type_enum (
   id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
   sentiment_type TEXT NOT NULL UNIQUE
);

INSERT INTO sentiment_type_enum(sentiment_type) VALUES 
('positive'),
('neutral'),
('negative');

CREATE TABLE article (
   id INTEGER NOT NULL PRIMARY KEY,
   security_id INTEGER NOT NULL,
   link TEXT NOT NULL,
   title TEXT NOT NULL,
   sentiment INTEGER NOT NULL,
   sentiment_reasoning TEXT NOT NULL,
   FOREIGN KEY(security_id) REFERENCES security(id),
   FOREIGN KEY(sentiment) REFERENCES sentiment_type_enum(id)
);

CREATE TABLE summary(
   id INTEGER NOT NULL PRIMARY KEY,
   article_id INTEGER NOT NULL,
   summary TEXT NOT NULL,
   partner_id INTEGER NOT NULL,
   FOREIGN KEY(article_id) REFERENCES article(id),
   FOREIGN KEY(partner_id) REFERENCES partner(id)
);

CREATE TABLE analysis_type_enum (
   id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
   analysis_type TEXT NOT NULL UNIQUE
);

INSERT INTO analysis_type_enum(analysis_type) VALUES 
("thesis"),
("future_analysis"),
("decision_reasoning"),
("thesis_review"); -- meant to be a place for us to review a past thesis

CREATE TABLE analysis(
   id INTEGER NOT NULL PRIMARY KEY,
   security_id INTEGER NOT NULL,
   description TEXT NOT NULL,
   analysis_type INTEGER NOT NULL,
   partner_id INTEGER NOT NULL,
   time INTEGER NOT NULL, -- see docs
   FOREIGN KEY(security_id) REFERENCES security(id),
   FOREIGN KEY(analysis_type) REFERENCES analysis_type_enum(id),
   FOREIGN KEY(partner_id) REFERENCES partner(id)
);

CREATE TABLE notifications (
   id INTEGER NOT NULL PRIMARY KEY,
   metric_id INTEGER NOT NULL,
   threshold_value DECIMAL(10, 4) NOT NULL, -- make sure this matches the type in metrics table
   above BOOLEAN NOT NULL, -- if true then notify when metric goes above the threshold, when false do it for below
   partner_id INTEGER NOT NULL, -- partner to be notified
   FOREIGN KEY(metric_id) REFERENCES metric(id),
   FOREIGN KEY(partner_id) REFERENCES partner(id)
)
